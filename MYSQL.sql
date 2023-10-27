 

show databases;


create database dbHotel;

use dbHotel;

 
    create table funcionarios (
	idFunc int primary key auto_increment,
	nomeFunc varchar(100) not null,
    login varchar(20) not null unique,
    senha varchar(255) not null,
    cargo varchar(20)
);






table pedido (
	idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum("Pendente", "Finalizado", "Cancelado") not null,
    idClientes int not null,
    focreatereign key (idClientes) references clientes(idClientes)
);

/* ABERTURA DE PEDIDOS */
insert into pedido (statuspedido, idClientes) values ("pendente", 1); 
insert into pedido (statuspedido, idClientes) values ("pendente", 2);

 select * from pedido;
select * from pedido inner join clientes on pedido.idClientes = clientes.idClientes;
