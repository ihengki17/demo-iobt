docker exec broker-central1 kafka-cluster-links --bootstrap-server broker-central1:29092 --create --link edge-to-central-link --config bootstrap.servers=broker-edge:29192

docker exec broker-central1 kafka-mirrors --create --mirror-topic test --link edge-to-central-link --bootstrap-server broker-central1:29092
