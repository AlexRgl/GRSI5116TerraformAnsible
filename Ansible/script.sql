CREATE database maharadb character set UTF8;
CREATE USER 'mahara'@'%' IDENTIFIED BY 'Passw0rd';
GRANT ALL PRIVILEGES ON maharadb.* TO 'mahara'@'%';
FLUSH PRIVILEGES;

