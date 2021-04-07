# singlecell-ccc

This is a Docker Image for running downstream single-cell RNA-seq analyses and evaluating cell-cell communication using jupyter notebooks.

Contains:

* Anaconda & Jupyter
* Python 3.8.8
* [scanpy](https://github.com/theislab/scanpy)  
* [cell2cell](https://github.com/earmingol/cell2cell)
* R 4.0.3
* [Seurat](https://github.com/satijalab/seurat)  
* [CellChat](https://github.com/sqjin/CellChat)

## Installation
1. Install docker following these instructions
https://docs.docker.com/install/

2. Pull the latest image from DockerHub with
```docker pull earmingol/singlecell-ccc```

## Running the docker image
This docker image can be run with the following command.  You should mount a local path so that your notebooks can be saved outside the Docker container.

```
docker run --rm -p 8888:8888 -v [local path]:/home/jovyan/work docker-hca-ccc:latest
```

You will then access the notebook with this URL:

```http://127.0.0.1:8888/?token=[your token]```

You can get the token from the console output from the ```docker run``` command.
