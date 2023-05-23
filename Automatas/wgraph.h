#include <map>
#include <set>
#include <queue>
#include <stack>
#include "exception.h"

using namespace std;

template <class Vertex, class Edge>
class WGraph {
    private:
        bool direction;
        set<Vertex> vertexes;
        map<Vertex, map<Vertex, Edge>> edges;

    public:
        WGraph(bool);
        bool containsVertex(Vertex) const;
        void addEdge(Vertex, Vertex, Edge);
        map<Vertex, Edge> getConnectionsFrom(Vertex) const;
        string toString() const;
};

template<class Vertex, class Edge>
WGraph<Vertex, Edge>::WGraph(bool direction) {
    this.direction = direction;
}

template<class Vertex, class Edge >
bool WGraph<Vertex, Edge>::containsVertex(Vertex v) const {
    return (vertexes.find(v) != vertexes.end())? true : false;
}
        

template<class Vertex, class Edge>
void WGraph<Vertex, Edge>::addEdge(Vertex from, Vertex to, Edge cost){
    if(!containsVertex(from)) {
        vertexes.insert(from);
        edges.insert(pair<Vertex, map<Vertex, Edge>>(from, map<Vertex, Edge>()));
    }

    if(!containsVertex(to)) {
        vertexes.insert(to);
        edges.insert(pair<Vertex, map<Vertex, Edge>>(to, map<Vertex, Edge>()));
    }

    edges[from].insert(pair<Vertex, Edge>(to, cost));
    if(!direction){
        edges[to].insert(pair<Vertex, Edge>(from, cost));
    }
}
        
template<class Vertex, class Edge>
map<Vertex, Edge> WGraph<Vertex, Edge>::getConnectionsFrom(Vertex v) const{
    if(!containsVertex(v)) {
        throw NoSuchElement();
    }

    return edges[v];
}
        
template<class Vertex, class Edge>
string WGraph<Vertex, Edge>::toString() const{
    stringstream aux;

	typename set<Vertex>::iterator i;
	typename map<Vertex, Edge>::const_iterator j;

	for(i = vertexes.begin(); i != vertexes.end(); i++) {
		aux << (*i) << "\t";
		for(j = edges.at((*i)).begin(); j != edges.at((*i)).end(); j++) {
			aux << "(" << j->first << "," << j->second << ")\t";
		}
		aux << "\n";
	}
	aux << "\n";

	return aux.str();
}
