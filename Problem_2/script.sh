#!/bin/bash

# At first we create the directory which contains chroots for further containers. 
DIR=my_container_roots
if [ -d "$DIR" ]
then
	true  # If the directory exists, do nothing.
else
	mkdir $DIR  # If the directory does not exist, create it. 
fi

# Each container has a uniqe directory which is its chroot. We have to create this directory and copy the filesystems to it. 
# Note that the chroot folder has an name like container_i, where "i" is a number. At first in a while loop we search for the previous folders and we make the new folder with the first free index "i".
i=1

while [ -d $DIR/container_$i ]  # If folder container_i exists, increase "i". This procedure continues until we find a non existing folder and we make it as the new root folder for new container. 
do
  i=$(( i + 1 ))
done

# Making the new root folder for the new container.
mkdir $DIR/container_$i
echo "The container's root folder is in the path:" $DIR/container_$i

# We extract ubuntu:20.04 filesystems to the root directory.
tar -zxf ubuntu-focal-oci-amd64-root.tar.gz -C my_container_roots/container_$i

# We make the new container and configure desired namespaces. More explanation is provided in README.md on github.
unshare --fork --pid --mount-proc --mount --uts --net --root=my_container_roots/container_$i bash -c "hostname $1 && /bin/bash" 

# When the container is exited, we remove its root folder. 
rm -r my_container_roots/container_$i
echo "The container's root folder has been removed."
