/**
 * Created by vaksenov on 23.07.2019.
 * Ported to C++ by Mark Jeffrey 2021.04.27
 */
#pragma once

#include <array>
#include <cmath>
#include <cstdint>
#include <vector>
#include <algorithm>

#include "utils.h"
#include "node_CSR.h"
#include "edge_CSR.cpp"
#include "message_CSR.h"
#include "iterator.h"

typedef uint64_t node_id;
typedef uint64_t message_id;
typedef uint64_t edge_id;

class MRF_CSR {
	public:
		static constexpr uint64_t LENGTH = Edge::LENGTH;

	private:
		uint64_t num_nodes;
		uint64_t num_edges;

		// CSR format
		// For edge i -> j, nodes[i] points to struct Node of node_id = i
		// edge_indices[i] holds the start index in which to traverse edge_dest for edges originating from i
		// edge_dest[edge_indices[i]] to edge_dest[edge_indices[i+1] - 1] holds destination node_id's of edges originating from i
		// the indices of edge_dest index into the corresponding array edges which holds information about the edge's potential
		Node* nodes;
		uint64_t* edge_indices;
		node_id* edge_dest;
		Edge* edges;
		Message* messages;

		// a reverse CSR is needed where edge i -> j can be found quickly only knowing node_id j
		// reverse_edge_id holds the edge id of the corresponding edge i -> j to allow for indexing into edges and messages
		uint64_t* reverse_edge_indices;
		node_id* reverse_edge_dest;
		edge_id* reverse_edge_id;

	public:
		MRF_CSR(uint64_t num_nodes, uint64_t num_edges);

		~MRF_CSR();

		void addEdge(node_id i, node_id j, Edge::array2d_t phi); 
		
		void endAddEdge(); // generates CSC and updates logProductIn of all nodes

		uint64_t getNumNodes() const { return num_nodes; }

		uint64_t getNumEdges() const { return num_edges; }

		uint64_t getNumMessages() const { return 2*num_edges; }

		static constexpr uint64_t getNumValues(uint64_t) {
			return LENGTH;
		}

		void setNodePotential(node_id n, std::array<double,LENGTH> potentials) {
			for (uint64_t i = 0; i < LENGTH; i++) {
        		(nodes[n].logNodePotentials)[i] = std::log(potentials[i]);
    		}   
		}

		message_id getReverseMessage(message_id m) {
			if ((m % 2) == 0) {
				return m + 1;
			} else {
				return m - 1;
			}
		}

		IteratorMessagesFrom getMessagesFrom(node_id n) {
			return IteratorMessagesFrom(n, edge_indices, reverse_edge_indices, reverse_edge_id, messages);
		}

		IteratorMessagesTo getMessagesTo(node_id n) {
			return IteratorMessagesTo(n, edge_indices, reverse_edge_indices, reverse_edge_id, messages);
		}

		std::array<double,LENGTH> getMessageVal(message_id m) {
			return messages[m].logMu;
		}

		std::array<double,LENGTH> getLogProductIn(node_id n) {
			return nodes[n].logProductIn;
		}

		Message* getMessage(message_id m) {
			return &messages[m];
		}

		Node* getNode(node_id n) {
			return &nodes[n];
		}

		Edge* getEdge(edge_id e) {
			return &edges[e];
		}

		void updateLogProductIn(node_id n, std::array<double,LENGTH> newLogProductIn) {
			nodes[n].logProductIn = newLogProductIn;
		}

		std::array<double,LENGTH> getFutureMessageVal(message_id m);

		void updateMessage(message_id m_id, std::array<double,LENGTH> newLogMu) {
			node_id dest = getDest(m_id);
			Node &n = nodes[dest];
			Message &m = messages[m_id];
			m.logMu = newLogMu;
		}

		void updateLookAhead(message_id m_id, std::array<double,LENGTH> newLogMu) {
			Message &m = messages[m_id];
			m.lookAhead = newLogMu;
		}

		std::array<double,LENGTH> getLookAhead(message_id m_id) {
			Message &m = messages[m_id];
			return m.lookAhead;
		}

		node_id getDest(message_id m) {
			return messages[m].j;
		}

		node_id getSource(message_id m) {
			return messages[m].i;
		}

		void getNodeProbabilities(std::vector<std::array<double,LENGTH> >* answer) const; 
};
