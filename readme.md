# This is repo to create the certificates requiered to run a docker mongo container in localhost with tls connections, "For development purposes only"

 1. Run bash script to create Certificates 
    ```
        bash createCerts.sh
    ```

 2. The command above will create a tls folder for non-required files, and leave at this level the 3 required files "ca.crt, server.pem, client.pem"

 3. There is also a docker-compose file with the minimal config to run the container. Be aware the path required files needs to match when mount the volumes if you copy the compose code

 4. In the mongod.conf file is the minimal configuration for this proyect, feel free if you need to add more configurations

 5. For the client authentication you need the client.pem and ca.crt files with x509 authentication method
