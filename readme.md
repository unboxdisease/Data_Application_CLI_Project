# Hospital Management Database

# Instructions to run the database
- Steps to install docker can be found [here](https://docs.docker.com/engine/install/)
- Steps to install mysql can be found at:
    - [ubuntu users](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04)
    - [mac users](https://flaviocopes.com/mysql-how-to-install/)
- `python3, pymysql,Datetime` are required.
    - To install `pymysql` using pip3, do `pip3 install pymysql`
    - To install `Datetime` using pip3, do `pip3 install Datetime`
## Steps to run-------------------------------------------------------------------------------------------------------
- `Hospital.sql` creates the database, the necessary tables and also populates the database with some data.

- `Hospital_management.py` is the actual python implemented CLI code.
- use `mysql -h <local host> -u <username> --port=<port> -p < Hospital.sql` to load the database. Then type the password of the user loading the database.

- use `python3 Hospital_management.py` to start the CLI application.

