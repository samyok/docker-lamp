# How to use 
Of course, you need Docker installed! 

As an example, `setup_phpBB3.sh` sets up phpBB3 😊

Some notes: 
- URLS: 
    - Apache container at `http://localhost:8080`
    - phpMyAdmin (for DB administration) at `http://localhost:8181`
    
- The hostname of the mysql server is `db`, and the username/password can be changed in the `.env` file.
    - default credentials: `dbuser:dbpass` (database name: `db`)
    - root credentials: `root:rootpassword`
- the PHP for your project can be thrown in `public/`. To change, update the last line in `.env`!
- If (for some reason) you need to get a terminal into any of the containers, just run 
```shell script
docker-compose exec <container_name> sh
```
Container names are `db`, `apache`, `php`, and `phpmyadmin`. You can also run 
```shell script
source .env; 
# to login as the user:
docker-compose exec db mysql -u $DB_USERNAME -p$DB_PASSWORD;

# to login as root: 
docker-compose exec db mysql -u root -p$DB_ROOT_PASSWORD;
```
to use the MYSQL CLI as root. 

- If you are going to use Cloudflare's Argos Tunnel ($5/month) to securely expose just the Apache container 
(without exposing phpmyadmin or MySQL) you need to follow these steps:
    0. Make sure you have `cloudflared` installed in your host OS.
    1. Run `cloudflared login` in your host OS
    2. Uncomment the lines at the bottom of `apache/supervisord.conf`
    3. Uncomment the lines at the bottom of `apache/Dockerfile`
    4. Set the path of your host machine's `cert.pem` in `apache/Dockerfile` (usually `~/.cloudflared/cert.pem`)
    5. Edit the hostname in `apache/config.yaml` to be the active Argos Tunnel zone. 
    6. Rebuild the apache container by doing `docker-compose up -d --build`

- If you're using on a server (like I was), the dozzle configuration (for viewing logs) can be viewed on port 9999 (if uncommented from `docker-compose.yml`). Otherwise, just use Docker Desktop.