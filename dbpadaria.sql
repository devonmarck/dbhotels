show databases;

create database dbPadaria;

use dbPadaria;

create table fornecedores (
	idFornecedor int primary key auto_increment,
    nomeFornecedor varchar(50) not null,
    cnpjFornecedor varchar(20) not null,
    telefoneFornecedor varchar(20),
    emailFornecedor varchar(50) not null unique,
    cep varchar(9),
    enderecoFornecedor varchar(100),
    numeroEndereco varchar(10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

insert into fornecedores (nomeFornecedor, cnpjFornecedor, emailFornecedor) values ("Ana Rosa Confeitaria", "03.266.407/0001-53", "anarosaconfeitaria@gmail.com");
select * from fornecedores;

create table produtos (
	idProduto int primary key auto_increment,
    nomeProduto varchar(50) not null,
    descricaoProduto text,
    precoProduto decimal (10,2) not null,
    estoqueProduto int not null,
    categoriaProduto enum("Pães", "Bolos", "Confeitaria", "Salgados"),
    idFornecedor int not null,
    foreign key (idFornecedor) references fornecedores (idFornecedor)
);

insert into produtos (nomeProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Bolo de laranja", 44.99, 5, "Bolos", 1); 
insert into produtos (nomeProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Farinha", 14.90, 7, "Confeitaria", 1); 

select * from produtos where categoriaProduto = "Pães";

select * from produtos where precoProduto < 50.00 order by precoProduto asc;

create table clientes (
	idCliente int primary key auto_increment,
    nomeCliente varchar(50),
    cpfCliente varchar(15) not null unique, 
    telefoneCliente varchar(20),
    emailCliente varchar(50) unique,
    cep varchar (9),
    enderecoCliente varchar(100),
    numeroEndereco varchar (10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

insert into clientes (nomeCliente, cpfCliente) values ("José da Silva", "068.137.310-50");
select * from clientes;

create table pedidos (
	idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum ("Pendente", "Finalizado", "Cancelado") not null,
    idCliente int not null,
    foreign key (idCliente) references clientes (idCliente)
);

insert into pedidos (statusPedido, idCliente) values ("Pendente", 1);

select * from pedidos inner join clientes on pedidos.idCliente = clientes.idCliente;

create table itensPedidos (
	idItensPedidos int primary key auto_increment,
    idPedido int not null,
    idProduto int not null,
    foreign key (idPedido) references pedidos (idPedido),
    foreign key (idProduto) references produtos (idProduto),
	quantidade int not null
);

select idPedido from pedidos;
insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 1, 3);
insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 2, 5);


/* OBJETIVO: consultar o nome do cliente que abriu seu pedido em determinada data para verificar o que ele comprou de itens nesse pedido e a respectiva quantidade,
ou seja, quais produtos e quanto de cada um 
QUEM COMPROU? QUANDO COMPROU? O QUE COMPROU? QUANTO COMPROU? */

select clientes.nomeCliente, pedidos.idPedido, pedidos.dataPedido, itensPedidos.quantidade, produtos.nomeProduto, produtos.precoProduto
from clientes inner join pedidos on clientes.idCliente = pedidos.idCliente inner join
itensPedidos on pedidos.idPedido = itensPedidos.idPedido inner join
produtos on produtos.idProduto = itensPedidos.idProduto;


