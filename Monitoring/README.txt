Felipe Giuste
README updated: 2/6/2019

# If monitoring GPU, set default runtime to nvidia on monitored nodes:
/etc/docker/daemon.json
{
        "default-runtime": "nvidia",
	"runtimes": {
		"nvidia": {
			"path": "nvidia-container-runtime",
			"runtimeArgs": []
		}
	}
}

# Pull Dockerfiles and .yaml files:
git clone https://github.com/fgiuste7/Docker.git

# Go to Directory "Monitoring/" within pulled Repository:
cd Monitoring

# Using docker-compose:
docker-compose -p monitor -f monitoring.yaml up

# Start single-node swarm to run Docker stack:
docker swarm init
## If Error, try: 
## docker swarm init --advertise-addr ${PICK_AN_ADDRESS}

# Run Monitoring stack on nodes to monitor:
docker stack deploy --compose-file monitoring.yaml monitor

# If you want Grafana to run on the current node:
## Create docker volume to store grafana settings:
## named 'grafana_volume'
docker volume create grafana_volume

## Run resource graphing with grafana on head node:
docker stack deploy --compose-file grafana.yaml grafana
