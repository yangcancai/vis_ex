import { DataSet, Network } from 'vis/index-network';
function getOptions() {
  // Return vis.js options here, like layout, physics, etc
  // Ommited for brevity
}
function diagramInit(data) {
var nodes = new DataSet(data.nodes);
var edges = new DataSet(data.edges);
// create a network
var container = document.getElementById('diagram');
// provide the data in the vis format
var data = {
    nodes: nodes,
    edges: edges
};
var options = {};

// initialize your network!
new Network(container, data, options);
}
export default diagramInit