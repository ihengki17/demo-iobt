# <div align="center">Demo IoBT</div>

## Step-by-Step Demo IoBT

## **Step**
1. [Build Confluent Platform and Database on top of Docker](#step-1)
2. [Create Dummy Data](#step-2)
3. [Create Cluster Linking from Edge Cluster to Central Cluster](#step-3)
4. [Create Sink Postgres from Central Cluster](#step-4)

***

## **Prerequisites**
<br>

1. Installed docker and docker-compose
2. DBeaver (optional)

## <a name="step-1"></a>Build Confluent Platform and Database on top of Docker

1. Make sure you already clone the git from the repo to your local environment.
```git
git clone https://github.com/ihengki17/demo-iobt.git
```
2. Bring up all of the component on the docker-compose to your local environment.
```docker
docker-compose up -d
```
3. Wait until all of the component is up and running, you could also check the component status using Control Center.
**C3 Central**
```C3 Central
http://localhost:9021
or
http://<hostname>:9021
```
**C3 Edge**
```C3 edge
http://localhost:9121
or
http://<hostname>:9121
```

## <a name="step-2"></a>Create Dummy Data

1. Access Control Center
2. Click Topic on the left side
3. Click Create topic on the right side
4. Type the topic name (on this demo we type **new_test**)
5. Set the partition as 1 and **click create with defaults**
6. Click connect tab on the left side
7. Click the connect-default
8. Now import the **dummy_data.json** to the Kafka Connect to deploy the task
9. You could change or modified the config as you seen fit to your demo
10. If all set, click next and launch the connector
11. If the Connector is running well you'll get a new topic with the message inside the Cluster
   * Click Topics on the left side
   * Click the topics name (by using the json that has been provide it will be **new_test**)
   * Click **Messages** tab
   * Click the offset bar on the right middle page, type 0 and enter
   * You'll see the message that starting from offset 0 up to now

You could use API to deploy the connector as you see fit and easier to deploy the connector.

## <a name="step-3"></a>Create Cluster Linking from Edge Cluster to Central Cluster

Execute the script **cluster-linking-edge-to-central.sh**

or

You could create manually by using this step-by-step command

1. Build the link for cluster linking from destination to source
```Cluster Linking link build
docker exec broker-central1 kafka-cluster-links --bootstrap-server broker-central1:29092 --create --link edge-to-central-link --config bootstrap.servers=broker-edge:29192
```
If it is success you will get the prompt
**Cluster link 'demo-link' creation successfully completed.**

2. Create the mirror topic as you've been done on the edge
```Mirroring Topic
docker exec broker-central1 kafka-mirrors --create --mirror-topic <topic_name> --link edge-to-central-link --bootstrap-server broker-central1:29092
```
If it is sucess you will get the prompt
**Created topic <topic_name>.**

3. We could check the topic and the message that has been replicated over cluster linking through the **Topic** tab on the left side and click the topic name and check the message inside the topic

## <a name="step-4"></a>Create Sink Postgres from Central Cluster

1. Access Control Center and click connect tab on the left side
2. Click the connect-default
3. Now import the **connector_Postgres_Sink_config.json** to the Kafka Connect to deploy the task
4. You could change or modified the config as you seen fit to your demo
5. If all set, click next and launch the connector
6. Now check the Postgres DB and you'll find that will be new table with all of the content
