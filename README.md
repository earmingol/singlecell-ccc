# docker-hca-ccc

This is a Docker image for running cell-cell communication in jupyter notebooks:

Contains:

* Anaconda
* R 4.0.3
* CellChat

This docker image can be run with the following command.  You should mount a local path so that your notebooks can be saved outside the Docker container.

```
docker run -it --rm -p 8888:8888 -v [local path]:/root/mount/ docker-hca-ccc:latest
```

You will then access the notebook with this URL:

http://127.0.0.1:8888/?token=[your token]

You can get the token from the console output from the ```docker run``` command.