#!/bin/bash

if [[ $1 == "node1" ]]
then
	if [[ $2 == "node1" ]]
	then
		echo "'node1: 172.0.0.2' PINGING itself (lo)"
        	ip netns exec node1 ping 172.0.0.2
	
        elif [[ $2 == "node2" ]]
        then
       	echo "'node1: 172.0.0.2' PINGING 'node2: 172.0.0.3'"
        	ip netns exec node1 ping 172.0.0.3
        	
        elif [[ $2 == "node3" ]]
        then
        	echo "'node1: 172.0.0.2' PINGING 'node3: 10.10.0.2'"
        	ip netns exec node1 ping 10.10.0.2
        	
        elif [[ $2 == "node4" ]]
        then
        	echo "'node1: 172.0.0.2' PINGING 'node4: 10.10.0.3'"
        	ip netns exec node1 ping 10.10.0.3
        
        elif [[ $2 == "router" ]] && [[ $3 == "1" ]]
        then
        	echo "'node1: 172.0.0.2' PINGING 'router's first interface: 172.0.0.1'"
        	ip netns exec node1 ping 172.0.0.1
        
        elif [[ $2 == "router" ]] && [[ $3 == "2" ]]
        then
        	echo "'node1: 172.0.0.2' PINGING 'router's second interface: 10.10.0.1'"
        	ip netns exec node1 ping 10.10.0.1
        	
        elif [[ $2 == "router" ]]
        then
        	echo "'node1: 172.0.0.2' PINGING 'router: 172.0.0.1'"
        	ip netns exec node1 ping 172.0.0.1
        fi

elif [[ $1 == "node2" ]]
then
        if [[ $2 == "node1" ]]
	then
		echo "'node2: 172.0.0.3' PINGING 'node1: 172.0.0.2'"
        	ip netns exec node2 ping 172.0.0.2
	
        elif [[ $2 == "node2" ]]
        then
       	echo "'node2: 172.0.0.3' PINGING itself (lo)"
        	ip netns exec node2 ping 172.0.0.3
        	
        elif [[ $2 == "node3" ]]
        then
        	echo "'node2: 172.0.0.3' PINGING 'node3: 10.10.0.2'"
        	ip netns exec node2 ping 10.10.0.2
        	
        elif [[ $2 == "node4" ]]
        then
        	echo "'node2: 172.0.0.3' PINGING 'node4: 10.10.0.3'"
        	ip netns exec node2 ping 10.10.0.3
        
        elif [[ $2 == "router" ]] && [[ $3 == "1" ]]
        then
        	echo "'node2: 172.0.0.3' PINGING 'router's first interface: 172.0.0.1'"
        	ip netns exec node2 ping 172.0.0.1
        
        elif [[ $2 == "router" ]] && [[ $3 == "2" ]]
        then
        	echo "'node2: 172.0.0.3' PINGING 'router's second interface: 10.10.0.1'"
        	ip netns exec node2 ping 10.10.0.1
        	
        elif [[ $2 == "router" ]]
        then
        	echo "'node2: 172.0.0.3' PINGING 'router: 172.0.0.1'"
        	ip netns exec node2 ping 172.0.0.1
        fi

elif [[ $1 == "node3" ]]
then
        if [[ $2 == "node1" ]]
	then
		echo "'node3: 10.10.0.2' PINGING 'node1: 172.0.0.2'"
        	ip netns exec node3 ping 172.0.0.2
	
        elif [[ $2 == "node2" ]]
        then
       	echo "'node3: 10.10.0.2' PINGING 'node2: 172.0.0.3'"
        	ip netns exec node3 ping 172.0.0.3
        	
        elif [[ $2 == "node3" ]]
        then
        	echo "'node3: 10.10.0.2' PINGING itself (lo)"
        	ip netns exec node3 ping 10.10.0.2
        	
        elif [[ $2 == "node4" ]]
        then
        	echo "'node3: 10.10.0.2' PINGING 'node4: 10.10.0.3'"
        	ip netns exec node3 ping 10.10.0.3
        
        elif [[ $2 == "router" ]] && [[ $3 == "1" ]]
        then
        	echo "'node3: 10.10.0.2' PINGING 'router's first interface: 172.0.0.1'"
        	ip netns exec node3 ping 172.0.0.1
        
        elif [[ $2 == "router" ]] && [[ $3 == "2" ]]
        then
        	echo "'node3: 10.10.0.2' PINGING 'router's second interface: 10.10.0.1'"
        	ip netns exec node3 ping 10.10.0.1
        	
        elif [[ $2 == "router" ]]
        then
        	echo "'node3: 10.10.0.2' PINGING 'router: 10.10.0.1'"
        	ip netns exec node3 ping 10.10.0.1
        fi

elif [[ $1 == "node4" ]]
then
        if [[ $2 == "node1" ]]
	then
		echo "'node4: 10.10.0.3' PINGING 'node1: 172.0.0.2'"
        	ip netns exec node4 ping 172.0.0.2
	
        elif [[ $2 == "node2" ]]
        then
       	echo "'node4: 10.10.0.3' PINGING 'node2: 172.0.0.3'"
        	ip netns exec node4 ping 172.0.0.3
        	
        elif [[ $2 == "node3" ]]
        then
        	echo "'node4: 10.10.0.3' PINGING 'node3: 10.10.0.2'"
        	ip netns exec node4 ping 10.10.0.2
        	
        elif [[ $2 == "node4" ]]
        then 
        	echo "'node4: 10.10.0.3' PINGING itself (lo)" 
        	ip netns exec node4 ping 10.10.0.3
        
        elif [[ $2 == "router" ]] && [[ $3 == "1" ]]
        then
        	echo "'node4: 10.10.0.3' PINGING 'router's first interface: 172.0.0.1'"
        	ip netns exec node4 ping 172.0.0.1
        
        elif [[ $2 == "router" ]] && [[ $3 == "2" ]]
        then
        	echo "'node4: 10.10.0.3' PINGING 'router's second interface: 10.10.0.1'"
        	ip netns exec node4 ping 10.10.0.1
        	
        elif [[ $2 == "router" ]]
        then
        	echo "'node4: 10.10.0.3' PINGING 'router: 10.10.0.1'"
        	ip netns exec node4 ping 10.10.0.1
        fi

elif [[ $1 == "router" ]]
then
        if [[ $2 == "node1" ]]
	then
		echo "'router: 172.0.0.1' PINGING 'node1: 172.0.0.2'"
        	ip netns exec router ping 172.0.0.2
	
        elif [[ $2 == "node2" ]]
        then
       	echo "'router: 172.0.0.1' PINGING 'node2: 172.0.0.3'"
        	ip netns exec router ping 172.0.0.3
        	
        elif [[ $2 == "node3" ]]
        then
        	echo "'router: 10.10.0.1' PINGING 'node3: 10.10.0.2'"
        	ip netns exec router ping 10.10.0.2
        	
        elif [[ $2 == "node4" ]]
        then 
        	echo "'router: 10.10.0.1' PINGING 'node4: 10.10.0.3'" 
        	ip netns exec router ping 10.10.0.3
        
        elif [[ $2 == "router" ]] && [[ $3 == "1" ]]
        then
        	echo "'router: 172.0.0.1' PINGING itself"
        	ip netns exec router ping 172.0.0.1
        
        elif [[ $2 == "router" ]] && [[ $3 == "2" ]]
        then
        	echo "'router: 10.10.0.1' PINGING itself"
        	ip netns exec router ping 10.10.0.1
        	
        elif [[ $2 == "router" ]]
        then
        	echo "'router: 172.0.0.1' PINGING itself (4 packets)"
        	ip netns exec router ping 172.0.0.1 -c4
        	
        	echo " "
        	echo " "
        	echo " "
        	
        	echo "'router: 10.10.0.1' PINGING itself (4 packets)"
        	ip netns exec router ping 10.10.0.1 -c4
        fi
fi
