# This is the Report and Results of Problem 1 (Container Networking)

### Description
This is the guide and report for SDMN homework 2, problem 1. Please read it very carefully. \
**THE ANSWER TO THE QUESTIONS ASKED IN THE HOMEWORK IS DOCUMENTED HERE. (REFER TO PART 2 AND PART 3)**

## Part 1: Creating the Topology using Linux network namespace
### "create_net.sh" 
We provided a bash script named "create_net.sh". This bash script applies all the needed actions to create and config the namespaces.

First of all, we enable IPv4 Forwarding. It is mandatory to allow us to ping nodes from different subnets. \
Line 6 to 41 is written to delete potentially previously implemented namespaces and related interfaces. Note that the output is suppressed because there may be no such namespaces, and we didn't want to show unimportant warnings. \
Line 44 to 49 is written to create namespaces (Nodes). \
Line 55 to 112 is written to create bridges and desired links. It also sets the interfaces up. \
Line 114 to 122 is written to assign IP addresses to nodes and router. \
Line 124 to 128 is written to assign the default gateway for nodes. This action, alongside IPv4 forwarding, enables us to ping nodes from another subnet.

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

## Part 2: Removing the router
As mentioned in the homework, we need to provide some rules to keep the network connected after removing the router. The connectivity is provided by the kernel and the rules which we provide. Here are the rules which we apply:

Enabling IP Forwarding in root namespace: 

        sysctl -w net.ipv4.ip_forward=1

Rules in the nodes (namespaces):

        ip netns exec node1 ip route add 10.10.0.0/24 dev veth-node1
        ip netns exec node2 ip route add 10.10.0.0/24 dev veth-node2
        ip netns exec node3 ip route add 172.0.0.0/24 dev veth-node3
        ip netns exec node4 ip route add 172.0.0.0/24 dev veth-node4
        
Rules in the root namespace:

        ip route add 10.10.0.0/24 dev br2
        ip route add 172.0.0.0/24 dev br1
        
The rules applied in the nodes make it possible to ping a node from another subnet. And the rules applied in the root namespace make a route between bridges to connect them in the kernel. Note that NO physical links were used, and we connected the network by our rules. 

Note that the topology is made by a similar bash script as "create_net.sh" which was used in the previous part. The only change is that we have to remove the router namespace and related links and configurations. We have made and checked the topology, but we did NOT upload the codes because the homework file says that no implementation is needed.

## Part 3: Namespaces on different servers, connected with layer 2 switch
As mentioned in the homework, we need to provide some rules in both servers, which are connected together with a layer 2 switch. So here the connectivity of different subnet is provided physically by a layer 2 switch. **Suppose that each server has an interface with a name "eth{i}" (server 1: eth1 and server 2: eth2) and this interface is connected physically to the layer 2 switch.** Below are the rules we applied on each server:

Rules in the nodes (namespaces):

        ip netns exec node1 ip route add 10.10.0.0/24 dev veth-node1
        ip netns exec node2 ip route add 10.10.0.0/24 dev veth-node2
        ip netns exec node3 ip route add 172.0.0.0/24 dev veth-node3
        ip netns exec node4 ip route add 172.0.0.0/24 dev veth-node4

Rules on Server 1:

        ip route 10.10.0.0/24 dev eth1  # Outgoing packets which have to be sent from Server 1 to Server 2
        ip route 172.0.0.0/24 dev br1  # Incoming packets which are coming from Server 2 to Server 1

Rules on Server 2:

        ip route 172.0.0.0/24 dev eth2  # Outgoing packets which have to be sent from Server 2 to Server 1
        ip route 10.10.0.0/24 dev br2  # Incoming packets which are coming from Server 1 to Server 2
        
Like the previous part, the rules applied in the nodes make it possible to ping a node from another subnet.

The rules applied in each server handle outgoing packets (packets going to the other sever) and incoming packets (packets coming from the other server to own server). For example, in Server 1, if "node1" tries to ping "node3", this is an outgoing packet with a destination in the range "10.10.0.0/24". So we write a rule to route packets with such destinations to "eth1" . Then "eth1" forwards the packet to the switch, and then the switch forwards it to Server 2. Also, in reply, "node3" answers the ping message of "node1", so this is an incoming packet with a destination address of "172.0.0.0/24", so we write a rule to route packets with such destinations to "br1". Then "br1" forwards the packet to "node1" and the pinging process is done. \
Similar example can explain rules written in Server 2. 

