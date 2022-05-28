#!/bin/bash

# Adding Nodes
ip netns add node1
ip netns add node2

# Adding Linux Bridge
ip link add br1 type bridge

# Seeting the bridge up
ip link set dev br1 up

# Adding link (vitual ethernet) from nodes to br1
ip link add veth-node1 type veth peer name veth-node1-br1
ip link add veth-node2 type veth peer name veth-node2-br1

# Seeting the virtual ethernets on each node and on bridge 
ip link set veth-node1 netns node1
ip link set veth-node1-br1 master br1

ip link set veth-node2 netns node2
ip link set veth-node2-br1 master br1

# Assigning IP addresses to each node
ip -n node1 addr add 172.0.0.2/24 dev veth-node1
ip -n node2 addr add 172.0.0.3/24 dev veth-node2

# Making interfaces up
ip link set veth-node1-br1 up
ip link set veth-node2-br1 up
ip -n node1 link set veth-node1 up
ip -n node2 link set veth-node2 up
