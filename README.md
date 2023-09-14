# Development of a React App


### Running the Application

- Build backend development server container
`cd backend`
`docker build -t soccer-sleuth-frontend -f Dockerfile.dev .`
- Build frontend development server container
`cd frontend`
`docker build -t soccer-sleuth-backend -f Dockerfile.dev .`
However,these two steps are usually not needed.
Build the entire stack by running the command `docker-compose build`. Make sure to be in the root directory while running this.
You can run the whole stack container with the command in the root directory terminal window :`docker compose up -d`
Please, make sure docker is running before attempting this. To stop the stack container, run `docker compose down`

### Development

When the docker container is running, your changes will not be visible on the application unless you rebuild the container (see command from earlier above). We will set up automatic file-watching later to eliminate this repetitive building of the container.


### PGadmin

PGadmin allows for seeing the data live as we perform operations on the app.
Download: https://www.pgadmin.org/download/
Docker: already configured in the covker file
Starting it up: the port is `5050:80`. you will be prompoted for login credintials. I set them as: 
   - username: pgadmin4@pgadmin.org
   - password: admin
Connecting Database: Once signed in, you need to connect our database.
   - right click Servers -> Regsiter -> Server
   - Under General Tabe enter Name (doesnt matter)
   - Under Connection Tab enter: name = db, username = admin, Password = project
Viewing Table:
   - Servers -> Databases -> soccer_sleuth-db -> Schemas -> public -> Tables
   - Right click on table you want to view -> View Data