# Cassandra_Cluster_Docker


<body>
    <h1>Cassandra Cluster with Docker Compose</h1>
    <p>This repository contains the necessary files to set up a Cassandra cluster using Docker Compose.</p>

    <h2>Prerequisites</h2>
<p>Before you begin, make sure you have Docker and Docker Compose installed on your system.</p>
<ul>
    <li><a href="https://docs.docker.com/engine/install/">Docker Installation Guide</a></li>
    <li><a href="https://docs.docker.com/compose/install/">Docker Compose Installation Guide</a></li>
</ul>

<h2>Dockerfile</h2>
<p>The Dockerfile in this repository is used to build a custom Cassandra image based on Ubuntu. The custom image includes Java 8 and Python 3.10, along with the necessary Cassandra installation.</p>

<h3>Build the Image</h3>
<p>To build the custom Cassandra image, run the following command in the same directory as the Dockerfile:</p>
<code>docker build -t custom-cassandra .</code>
<p>This will create an image with the tag <code>custom-cassandra</code> that can be used in the <code>docker-compose.yaml</code> file.</p>

<h2>docker-compose.yaml</h2>
<p>The <code>docker-compose.yaml</code> file describes the Cassandra cluster configuration with three nodes. Each node is running a separate container, and the containers are connected to form a cluster.</p>

<h3>Start the Cassandra Cluster</h3>
<p>To start the Cassandra cluster, run the following command in the same directory as the <code>docker-compose.yaml</code> file:</p>
<code>docker-compose up -d</code>
<p>This will create and start three containers named <code>node-1</code>, <code>node-2</code>, and <code>node-3</code>, each running a Cassandra instance. The containers will use the custom image <code>custom-cassandra</code> we built earlier.</p>

<h2>Cluster Details</h2>
<p>The Cassandra cluster is configured with the following details:</p>
<ul>
    <li>Node 1 (<code>node-1</code>): This is the first node in the cluster. It listens on port 9042 and is exposed to the host on port 9042. Data for this node is stored in the <code>./data_node-1</code> directory on the host.</li>
    <li>Node 2 (<code>node-2</code>): This is the second node in the cluster. It listens on port 9043 and depends on Node 1 (<code>node-1</code>). Data for this node is stored in the <code>./data_node-2</code> directory on the host.</li>
    <li>Node 3 (<code>node-3</code>): This is the third node in the cluster. It listens on port 9044 and depends on Node 1 (<code>node-1</code>). Data for this node is stored in the <code>./data_node-3</code> directory on the host.</li>
</ul>

<h2>Cluster Configuration</h2>
<p>Each node in the cluster is configured with the following environment variables:</p>
<ul>
    <li><code>CASSANDRA_CLUSTER_NAME</code>: The name of the Cassandra cluster (<code>my-cluster</code> in this case).</li>
    <li><code>CASSANDRA_ENDPOINT_SNITCH</code>: The snitch used for dynamic endpoint calculation (<code>GossipingPropertyFileSnitch</code> in this case).</li>
    <li><code>CASSANDRA_SEEDS</code>: The comma-separated list of seed nodes. Nodes 2 and 3 depend on Node 1 as their seed node.</li>
</ul>

<h2>Accessing Cassandra</h2>
<p>You can now connect to the Cassandra cluster using the Cassandra Query Language (CQL) or any Cassandra client. The cluster is available on the following ports:</p>
<ul>
    <li>Node 1: <code>localhost:9042</code></li>
    <li>Node 2: <code>localhost:9043</code></li>
    <li>Node 3: <code>localhost:9044</code></li>
</ul>
<p>For example, you can use the <code>cqlsh</code> tool to connect to Node 1:</p>
<code>docker exec -it node-1 cqlsh</code>

<h2>Stopping the Cluster</h2>
<p>To stop the Cassandra cluster and remove the containers, run the following command:</p>
<code>docker-compose down</code>
<p>This will stop and remove all the containers associated with the Cassandra cluster.</p>
</body>
