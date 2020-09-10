MSSQL to PGSQL Migration

Following bullet point describes how to migrate MSSQL database to PostgreSQL in three simply steps.

Perform following steps on MSSQL container
------------------------------------------
# Install DbVisualizer 
# Run docker image of mssql from dockerhub 
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=yourpassword" --name "<dbName>" -p 1400:1433 -v sqldata:/var/opt/mssql \-d mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04
# Make a directory called backup and copy the file into backup folder inside the container.
docker exec -it mssql-db  mkdir /var/opt/mssql/backup
docker cp <from location(path)> mssql-db:/var/opt/mssql/backup

# List out logical file names and path inside the backup.
 docker exec -it mssql-db /opt/mssql-tools/bin/sqlcmd -S localhost \
-U SA -P 'yourpassword' \
-Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/backup/<backup filename>"' \
| tr -s ' ' | cut -d ' ' -f 1-2

# Call Restore Database commands to restore the database inside the container.
docker exec -it  msssql-db /opt/mssql-tools/bin/sqlcmd  \
-S localhost -U SA -P ' yourpassword '  \
-Q 'RESTORE DATABASE mssqldb FROM DISK = "/var/opt/mssql/backup//<backup filename>" " WITH MOVE "RetailV45" TO "/var/opt/mssql/data/mssqldb.mdf", MOVE "RetailV45_log" TO "/var/opt/mssql/data/mssqldb.ldf "'
 
# Verify :
docker exec -it mssql-db /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'yourpassword' -Q 'SELECT Name FROM sys.Databases'
 

Perform following operation on PostreSQL container.
--------------------------------------------------
1) Install pgAdmin
2) Install pgLoader
3) Run PGSQL docker image using docker hub
   # docker run --name localpg -e POSTGRES_PASSWORD=myStrong2020pgsql -p 5432:5432 -d postgres
4) Run following commands to transfer file data from MSSQL to PostgreSQL.
   # pgloader mssql://sa:<yourMSSQlpassword>@<msql path> pgsql://postgres:<yourPGSQLpassword>@<pgsql path>
