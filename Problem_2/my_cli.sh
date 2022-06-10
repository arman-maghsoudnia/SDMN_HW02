#!/bin/bash

# At first we create the directory which contains chroots for further containers. 
ROOT_DIR=my_container_roots
if [ -d "$ROOT_DIR" ]
then
	true  # If the directory exists, do nothing.
else
	mkdir $ROOT_DIR  # If the directory does not exist, create it. 
fi

# Each container has a uniqe directory which is its chroot. We have to create this directory and copy the filesystems to it. 
# Note that the chroot folder has an name like container_i, where "i" is a number. At first in a while loop we search for the previous folders and we make the new folder with the first free index "i".
i=1

while [ -d $ROOT_DIR/container_$i ]  # If folder container_i exists, increase "i". This procedure continues until we find a non existing folder and we make it as the new root folder for new container. 
do
  i=$(( i + 1 ))
done

# Making the new root folder for the new container.
mkdir $ROOT_DIR/container_$i
echo "The container's root folder is in the path:" $ROOT_DIR/container_$i

# We extract ubuntu:20.04 filesystems to the root directory.
tar -zxf ubuntu-focal-oci-amd64-root.tar.gz -C my_container_roots/container_$i

# If the second input argument is supplied, this means we have to limit the memory usage to the given number in megabytes.
j=1

if [ -z "$2" ]
  then
    echo "Note: No argument supplied for memory restriction. So no memory restriction was applied."
else
    # Similar to the process of making the root directory, we make a directory with a unique name for the cgroup in the path: /sys/fs/cgroup/memory/ 
    MEMORY_DIR=/sys/fs/cgroup/memory/
    while [ -d $MEMORY_DIR/my_container_Group_$j ]
    do
    	j=$(( j + 1 ))
    done
fi

# Making the directory with the given name in the path: /sys/fs/cgroup/memory/
cgcreate -g memory:my_container_Group_$j
echo "The container's cgroup folder is in the path:" $MEMORY_DIR""my_container_Group_$j

# We configure the amount of memory which can be used by processes which are assigned to this cgroup. 
echo "Memory usage of the container is restricted to:"
echo $2M | tee /sys/fs/cgroup/memory/my_container_Group_$j/memory.limit_in_bytes 1> /dev/null

# We make the new container and configure desired namespaces. More explanation is provided in README.md on github.
# Also note that we run the container under mentioned cgroup directory which restricts the amount of memory which can be used by the container and the bash which is run in the container.  
cgexec -g memory:my_container_Group_$j unshare --fork --pid --mount-proc --mount --uts --net --root=my_container_roots/container_$i bash -c "hostname $1 && /bin/bash"

# When the container is exited, we remove its root folder. 
rm -r my_container_roots/container_$i
echo "The container's root folder has been removed."

# When the container is exited, we remove its cgroup folder. 
rmdir $MEMORY_DIR/my_container_Group_$j
echo "The container's cgroup folder has been removed."
