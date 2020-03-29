# jupyterlab-ds
Docker Image with jupyterlab, plotly, orca and other data science libs:
* FROM [sergiosjs/jupyterlab-plotly](https://hub.docker.com/repository/docker/sergiosjs/jupyterlab-plotly)
* ORCA==1.1.1
* [Data science Libs](https://github.com/SergioSJS/jupyterlab-ds/blob/master/requirements.txt)

## Usage
Pull the image:
```
docker pull sergiosjs/jupyterlab-ds
```
And run:
```
docker run --rm -p 8888:8888 -v "/your/work/directory":/home/jovyan/work sergiosjs/jupyterlab-ds
```
