# App structure:
app/
	routes.py ( "app=" )

	
# To run:
cd ${app_directory}
docker run -it --rm -v ${PWD}/:/apps/:rw -p 3031:3031 -p 9191:9191 fgiuste/flask:production
