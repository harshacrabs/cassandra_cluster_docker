# Base image for Cassandra
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk python3

# Create symbolic link for python
RUN ln -s /usr/bin/python3.10 /usr/bin/python

# Create Cassandra user
RUN groupadd -r cassandra && useradd --no-log-init -r -g cassandra cassandra

# Add Cassandra tarball and extract it
ADD http://archive.apache.org/dist/cassandra/3.11.12/apache-cassandra-3.11.12-bin.tar.gz /opt/
RUN tar -xvzf /opt/apache-cassandra-3.11.12-bin.tar.gz -C /opt && \
    rm /opt/apache-cassandra-3.11.12-bin.tar.gz && \
    mv /opt/apache-cassandra-3.11.12 /opt/cassandra && \
    chown -R cassandra:cassandra /opt/cassandra

# Set Cassandra environment variables
ENV CASSANDRA_HOME=/opt/cassandra
ENV PATH=$PATH:$CASSANDRA_HOME/bin

# Switch to the Cassandra user
USER cassandra

# Start Cassandra service
CMD ["cassandra", "-f"]

# Set the version as the tag
ARG CASSANDRA_VERSION=3.11.12
LABEL cassandra.version=$CASSANDRA_VERSION