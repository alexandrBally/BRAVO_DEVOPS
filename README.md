# BRAVO_BE_FE

instruction: 
1. install dockerfile for frontend and backend:
>    $ make dockerfile-install
2. run docker-compose.yml file:
>    $ make start 

if you ran this command before then restart docker:

>    $ make restart
3. to make a database backup:
>    $ make backup-all

What have I done in this project?

Set up Docker containerization, created Dockerfile for FE and BE, wrote docker-compose.yml configuration;
MakeFile wrote to automate application deployment;
Wrote nginx config for be nad fe;
Compiled a configuration GitHub Actions for continuous delivery of updates to the server;