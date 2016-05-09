# docker-isilon_data_insights_connector
Docker image for isilon_data_insights_connector
(https://github.com/Isilon/isilon_data_insights_connector)

## Assumptions

This assumes your Isilon cluster(s) are running OneFS 8.x and that your TSDB endpoint is InfluxDB.

## Setup

#### Clone the Git repo locally

```
git clone https://github.com/scr512/docker-isilon_data_insights_connector.git
```

#### Modify isi_data_insights_d.cfg with your InfluxDB endpoint and the Isilon Cluster(s) you want to query:

```
.....
stats_processor_args: <myinfluxdb> 8086 isi_data_insights
.....
clusters: myusername:mypass@10.25.69.74:False myusername:mypass@10.245.108.21
.....
```
#### Build the Docker image

```
docker build -rm -t scr512/isilon_data_insights_connector ./docker-isilon_data_insights_connector
```
#### Run Docker image (Daemonized)

```
docker run -d --name isilon_data_insights_connector scr512/isilon_data_insights_connector
```
#### Confirm that data is being collected

```
docker exec -ti isilon_data_insights_connector tail -f /var/log/isi_data_insights_d.log
```

#### Base Image

Built using [Phusion's base image](https://github.com/phusion/baseimage-docker).
