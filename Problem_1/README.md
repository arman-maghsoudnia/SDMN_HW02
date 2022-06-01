# This is the Report and Results of Problem 1 (Container Networking)

### Description
This is the guide and report for SDMN homework 2, problem 1. Please read it very carefully. The answer to the questions asked in the homework is documented here.

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
