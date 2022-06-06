# This is the Report and Results of Problem 3 (Container Runtime)

### Description
This is the guide and report for SDMN homework 2, problem 2. Please read it very carefully. The answer to the questions asked in the homework is documented here.

## Creating the container 
### "my_cli.sh" 
We provided a bash script named "my_cli.sh". Running this bash script is equivalent to running a new container with the desired functionality. Further explanation about implementation is documented below.

Note that each new container has a new root folder. These root folders are in a folder named "my_container_roots". \
Each root folder has a name like "container_i" where "i" is a number. \
At the beginning of the code, we check whether the folder "my_container_roots" exists or not. If not, we create this folder. Then we check for root directory folders.
We look for folders with the name "container_i" in a loop while increasing "i". The first "i" which does not have a folder with the name described above, is a free folder to create.
So we create the folder to be the root folder for the new container.

After creating an empty folder as the root folder, we copy the ubuntu:20.04 filesystems to the folder.
We downloaded the filesystems from the following link: [ubuntu-focal-oci-amd64-root](https://github.com/tianon/docker-brew-ubuntu-core/blob/5ed9ebdc8e9050d5b327c7ce3cda08b62cd28f67/focal/ubuntu-focal-oci-amd64-root.tar.gz) \
So we extract ubuntu-focal-oci-amd64-root.tar.gz to the new root folder directory. Now the root folder is entirely ready.

Now is the time to run our container and configure the namespaces. We use the following line to run the container: <strong>unshare --fork --pid --mount-proc --mount --uts --net --root=my_container_roots/container_$i bash -c "hostname $1 && /bin/bash"</strong>. This command will change the desired namespaces and also will change the root directory of the container. 

"unshare" is a Linux command used to create containers with given namespaces. You can find the complete documentation in the following link: [unshare doc](https://man7.org/linux/man-pages/man1/unshare.1.html)

Here we explain the functionality of each option we used:

<strong>--fork</strong>
+ Fork the specified program as a child process of unshare rather than running it directly.
This is useful when creating a new PID namespace. Note that when unshare is waiting for the child process, it ignores SIGINT and SIGTERM and does not forward any signals to the child.
It is necessary to send signals to the child process.

<strong>--pid</strong> 
+ Unshare the PID namespace. If file is specified, then a persistent namespace is created by a bind mount. (Creation of a persistent PID namespace will fail if the --fork option is not also specified.)

<strong>--mount-proc</strong>
+ Just before running the program, mount the proc filesystem at mountpoint (default is /proc). This is useful when creating a new PID namespace.
It also implies creating a new mount namespace since the /proc mount would otherwise mess up existing programs on the system.
The new proc filesystem is explicitly mounted as private (with MS_PRIVATE|MS_REC). <strong>This option enables us to use the "ps fax" command in the container.</strong>

<strong>--mount</strong>
+ Unshare the mount namespace. If file is specified, then a persistent namespace is created by a bind mount.
Note that file must be located on a mount whose propagation type is not shared (or an error results).

<strong>--uts</strong>
+ Unshare the UTS namespace. If file is specified, then a persistent namespace is created by a bind mount.

<strong>--net</strong>
+ Unshare the network namespace. If file is specified, then a persistent namespace is created by a bind mount.

<strong>--root=dir</strong>
+ Run the command with root directory set to dir. <strong>We use this option to set the root directoty to "my_container_roots/container_$i", which is our previously made root folder with filesystems.</strong>

At the end of the command we insert ' bash -c "hostname $1 && /bin/bash" '. This line will apply the written commands in the container terminal. So we edit the hostname and change it to the hostname given by the user. Also, we run the "bash" to keep the container alive and see the container terminal. 

At the end of "my_cli.sh" code, we remove the created root folder for the container. This line will be applied after exiting the container. So the container will be completely wiped out after exiting it. 

## Running the container
Running the container is as simple as running the "my_cli.sh" code and giving the desired hostname.

    sudo ./my_cli.sh your-desired-hostname
    
After running the container, a root folder will be created in the "my_container_roots" folder. The root folder's name will be shown in the terminal immediately after running the container. 

Congratulations. Now you are in the container!

## Results
We ran three containers simultaneously, and we provided some screenshots, which you can see below. 

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_2/Results/01.png?raw=true)

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_2/Results/02.png?raw=true)

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_2/Results/03.png?raw=true)



