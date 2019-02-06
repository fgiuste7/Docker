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


# Run Monitoring stack on nodes to monitor:
docker stack deploy --compose-file monitoring.yaml monitor

# Create docker volume to store grafana settings:
# named 'grafana_volume'
docker volume create grafana_volume

# Run resource graphing with grafana on head node:
docker stack deploy --compose-file grafana.yaml grafana
