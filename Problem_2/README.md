# This is the Report and Results of Problem 3 (Container Runtime)

### Description
This is the guide and report for SDMN homework 2, problem 2. Please read it very carefully. The answer to the questions asked in the homework is documented here.

## Creating the container 
### "my_cli.sh" 
We provided a bash script named "my_cli.sh". Running this bash script is equivalant to ruuning a new container with the desired functionality. Further explanation about implementation is documented below.

Note that each new container has a new root folder. These root folders are in a folder named "my_container_roots". \
Each root folder has a name like "container_i" where "i" is a number. \
At the beginning of the code, we check whethere the folder "my_container_roots" exists or not. If not, we create this folder. Then we check for root directory folders.
We look for folders with name "container_i" in a loop while increasing "i". The first "i" which does not have a folder with aforesaid name is a free folder to create.
So we create the folder to be the root folder for the new container.

After creating an empty folder as the root folder, we copy the ubuntu:20.04 filesystems to the folder.
We downloaded the filesystems from the following link: [ubuntu-focal-oci-amd64-root](https://github.com/tianon/docker-brew-ubuntu-core/blob/5ed9ebdc8e9050d5b327c7ce3cda08b62cd28f67/focal/ubuntu-focal-oci-amd64-root.tar.gz) \
So we extract ubuntu-focal-oci-amd64-root.tar.gz to the new root folder directory. Now the root folder is completely ready.

Now is the time to run our container and configure the namespaces. We use the following line to run the container: unshare --fork --pid --mount-proc --mount --uts --net --root=my_container_roots/container_$i bash -c "hostname $1 && /bin/bash"

"unshare" is a linux command which is used to create containers with given namespaces. You can find the full documentation in the following link: [unshare doc](https://man7.org/linux/man-pages/man1/unshare.1.html)

Here we explain the functionality of each option we used:

--fork
+ Fork the specified program as a child process of unshare rather than running it directly.
This is useful when creating a new PID namespace. Note that when unshare is waiting for the child process, then it ignores SIGINT and SIGTERM and does not forward any signals to the child.
It is necessary to send signals to the child process.

--pid 
+ Unshare the PID namespace. If file is specified, then a persistent namespace is created by a bind mount. (Creation of a persistent PID namespace will fail if the --fork option is not also specified.)

--mount-proc
+ Just before running the program, mount the proc filesystem at mountpoint (default is /proc). This is useful when creating a new PID namespace.
It also implies creating a new mount namespace since the /proc mount would otherwise mess up existing programs on the system.
The new proc filesystem is explicitly mounted as private (with MS_PRIVATE|MS_REC). <strong>This option enables us to use "ps fax" command in the container.</strong>.

--mount
+ Unshare the mount namespace. If file is specified, then a persistent namespace is created by a bind mount.
Note that file must be located on a mount whose propagation type is not shared (or an error results).

--uts
+ Unshare the UTS namespace. If file is specified, then a persistent namespace is created by a bind mount.



Finally, you only need to execute the script will the following command:

    ./create_net.sh

Now the topology is ready.

**IMPORTANT NOTE:** If you have Docker installed on your system, the rules and IPs related to Docker and its containers may conflict with the routing functionality in our topology, and you may be unable to ping nodes from another subnet or, in the worst case, any node.
So you should either fix the conflicting rule/IP or run the code on a system that doesn't have docker installed. 

### "ping_script.sh" 
We provided a bash script named "ping_script.sh". This bash script helps us easily ping the destination node from the source node. To do so, we write multiple "if" statements to recognize source and destination. \
Suppose that you want to ping "node2" from "router". To do so, you have to execute the bash script with the following added names:

        ./ping_script.sh router node2 

Also, we added a third input option while pinging the "router". The third input can be either "1" or "2". Note that the router has two interfaces. So if the third input is "1", the first interface, which is "172.0.0.1", will be pinged, and if the third input is "2", the second interface, which is "10.10.0.1", will be pinged. \
For example, if you want to ping "10.10.0.1" from node1, you have to execute the following command:

        ./ping_script.sh node1 router 2

And if you want to ping "172.0.0.1" from node1, you have to execute the following command:

        ./ping_script.sh node1 router 1

If you don't give the third input, the code will ping the default interface, which is the interface in the same subnet as the source. 

### Results
We provided some screenshots of the pinging process. You can see the results below:

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_1/Results/01.png?raw=true)

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_1/Results/02.png?raw=true)

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_1/Results/03.png?raw=true)


