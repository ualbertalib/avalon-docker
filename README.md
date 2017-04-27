# avalon-docker
The project contains the Dockerfiles for all the necessary components of [Avalon Media System](http://github.com/avalonmediasystem/avalon)

## Usage
1. Clone this Repo and checkout the desired branch
2. Copy dotenv.example to .env and fill in the passwords and Rails secrect key base.

## Important U of A things ...

This implementation runs in rails development mode and reads the avalon source code
from the host file system.

1. Clone the U of A Avalon source. For most ease of use, do it in a way so that
   both the 'avalon-docker' and the 'avalon' checkout are in the same directory, next to each other.
   Alternatively, you can set the directory by setting AVALON_SRC in the .env file.
2. Set the values of APP_UID and APP_GID in .env. This will prevent docker from changing
   the ownership of files in your avalon source code in the host machine. You can find out
   your UID by running "id -u", GID by running "id -g" (on Linux, these are usually
   numbers close to 1000, and likely the same number for both).

### On Linux
1. Install [Docker](https://docs.docker.com/engine/installation/linux/centos/)
2. Install [Docker-Compose](https://docs.docker.com/compose/install/)
3. From inside the avalon-docker directory
  * `docker-compose pull` to get the prebuilt images from [Dockerhub](dockerhub.com)
  * `docker-compose up` to stand up the stack
4. Rebuild a few of the components with local changes:
  * `docker-compose build avalon fedora solr db`

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
