FROM mysql/mysql-server:5.7
COPY ./Transaccional.sql /docker-entrypoint-initdb.d/1.sql
COPY ./Estrella-compra.sql /docker-entrypoint-initdb.d/2.sql
COPY ./Estrella-venta.sql /docker-entrypoint-initdb.d/3.sql
COPY ./Datos.sql /docker-entrypoint-initdb.d/4.sql
CMD ["mysqld"]