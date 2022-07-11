# docker-swarm
php, nginx, portainer and laravel using docker swarm

set docker to swarm mode
#docker swarm init

deploy docker compose file
#docker stack deploy -c docker-compose.yml stack-name

deploy with .env file
#docker stack deploy -c <(docker-compose config) stack-name

list services
#docker service ls

remove stack
#docker stack rm stack-name
