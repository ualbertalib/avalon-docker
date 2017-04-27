# avalon-docker
The project contains the Dockerfiles for all the necessary components of [Avalon Media System](http://github.com/avalonmediasystem/avalon)

## Usage
1. Clone this Repo and checkout the desired branch
2. Copy dotenv.example to .env and fill in the passwords and Rails secrect key base.

### On Linux
1. Install [Docker](https://docs.docker.com/engine/installation/linux/centos/)
2. Install [Docker-Compose](https://docs.docker.com/compose/install/)
3. From inside the avalon-docker directory
  * `docker-compose pull` to get the prebuilt images from [Dockerhub](dockerhub.com)
  * `docker-compose build avalon fedora solr db` to rebuild a few components with U of A specific changes.
  * `docker-compose up` to stand up the stack

### On a Mac
* Install [Docker Toolbox for OS X](https://www.docker.com/products/docker-toolbox)
* Run
  * `docker-machine stop default`
  * `docker-machine start default`
  * `docker-machine env`
  * `eval $(docker-machine env)`
  * `docker-machine start default`
  * `docker-compose up`
* The docker container will be accessible via `http://192.168.99.100:8888/`
* if anytime OS X says docker is not started, rerun `eval $(docker-machine env)

### Notes
* `docker-compose logs <service_name>` to see the container(s) logs
* `docker-compose build --no-cache <service_name>` to build the image(s) from scratch
* `docker ps` to see all running containers
* `docker exec -it avalondocker_avalon_1 /bin/bash` to log into Avalon docker container
