#!/bin/bash

# Adding Nodes
ip netns add node1
ip netns add node2
ip netns add node3
ip netns add node4
ip netns add router

# Adding Linux Bridges
ip link add br1 type bridge
ip link add br2 type bridge

# Seeting the bridge up
ip link set dev br1 up
ip link set dev br2 up

# Adding link (vitual ethernet) from nodes to bridges
ip link add veth-node1 type veth peer name veth-br1-node1
ip link add veth-node2 type veth peer name veth-br1-node2

ip link add veth-node3 type veth peer name veth-br2-node3
ip link add veth-node4 type veth peer name veth-br2-node4

# Adding link (vitual ethernet) from bridges to router
ip link add veth-router-br1 type veth peer name veth-br1-router
ip link add veth-router-br2 type veth peer name veth-br2-router

# Seeting the virtual ethernets on each node and on bridge 
ip link set veth-node1 netns node1
ip link set veth-br1-node1 master br1

ip link set veth-node2 netns node2
ip link set veth-br1-node2 master br1

ip link set veth-node3 netns node3
ip link set veth-br2-node3 master br2

ip link set veth-node4 netns node4
ip link set veth-br2-node4 master br2

ip link set veth-router-br1 netns router
ip link set veth-br1-router master br1

ip link set veth-router-br2 netns router
ip link set veth-br2-router master br2

# Assigning IP addresses to each node
ip -n node1 addr add 172.0.0.2/24 dev veth-node1
ip -n node2 addr add 172.0.0.3/24 dev veth-node2

ip -n node3 addr add 10.10.0.2/24 dev veth-node3
ip -n node4 addr add 10.10.0.3/24 dev veth-node4

ip -n router addr add 172.0.0.1/24 dev veth-router-br1
ip -n router addr add 10.10.0.1/24 dev veth-router-br2

# Making interfaces up
ip link set veth-br1-node1 up
ip link set veth-br1-node2 up

ip link set veth-br2-node3 up
ip link set veth-br2-node4 up

ip link set veth-br1-router up
ip link set veth-br2-router up

ip -n node1 link set veth-node1 up
ip -n node2 link set veth-node2 up

ip -n node3 link set veth-node3 up
ip -n node4 link set veth-node4 up

ip -n router link set veth-router-br1 up
ip -n router link set veth-router-br2 up
