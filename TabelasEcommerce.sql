-- criaçao do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_cpf_client unique (CPF)
        );

alter table clients auto_increment=1;        
        
-- criar tabela produto

create table Product(
		idProduct int auto_increment primary key,
        Category enum('Eletrônico', 'Vestimentos', 'Brinquedos', 'Alimentos') not null,
		ProductDescription varchar(100),
        avaliação float default 0,
        size varchar(10),
        Price float not null
);

alter table Product auto_increment=1; 

-- criar tabela de pagamento

create table payments(
		idClient int,
        idPayment int,
        typePayment enum('Dinheiro', 'Boleto', 'Cartao'),
        limitAvailable float,
        primary key(idClient, idPayment)
);

alter table payments auto_increment=1; 

-- criar tabela pedido 

create table Orders(
		idOrders int auto_increment primary key,
        idOrderClient int,
        OrderStatus ENUM('Em Andamento', 'Processando', 'Enviado', 'Entregue') default ('Processando'),
		Ordersdescription varchar(100),
        Frete float not null default 0,
        paymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);
alter table Orders auto_increment=1;

-- criar tabela estoque

create table ProductStorege(
		idProductStorege int auto_increment primary key,
        idOrderClient int,
		Category enum('Eletrônico', 'Vestimentos', 'Brinquedos', 'Alimentos') not null,
		location varchar(100) not null,
		quantity int not null
);

alter table ProductStorege auto_increment=1;

-- criar fornecedor 

create table Supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(100) not null,
		CNPJ char(15) not null,
		contact varchar(11) not null,
		 constraint unique_CNPJ_supllier unique (CNPJ)
);

alter table Supplier auto_increment=1;

-- criar vendedor

create table Seller(
		idSeller int auto_increment primary key,
        SocialName varchar(100) not null,
        AbstractName varchar(100),
        location varchar(100) not null,
		CNPJ char(15),
        CPF char(9),
		contact varchar(11) not null,
        constraint unique_cpf_seller unique (CPF),
		constraint unique_CNPJ_seller unique (CNPJ)
);

alter table Seller auto_increment=1;

create table ProductSeller(
	idPSeller int,
    idPproduct int,
    prodQuantity int not null,
    primary key (idPSeller, idPproduct),
    constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references Product(idProduct)
);

alter table ProductSeller auto_increment=1;

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key(idPOproduct, idPOorder),
    constraint fk_productOrder_seller foreign key (idPOproduct) references Product(idProduct),
    constraint fk_productOrder_product foreign key (idPOorder) references orders(idOrders)
    
);

alter table productOrder auto_increment=1;

create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(100) not null,
primary key(idLproduct, idLstorage),
constraint fk_storage_Location_seller foreign key (idLproduct) references Product(idProduct),
constraint fk_storage_Location_storage foreign key (idLstorage) references ProductStorege(idProductStorege)
);

alter table storageLocation auto_increment=1;

create table productSupplier(
idPsSupplier int,
idPsProduct int,
primary key(idPsSupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

alter table productSupplier auto_increment=1;

create table Requisite(
idRequisite int auto_increment primary key,
		CNPJ char(15),
        CPF char(9),
        constraint unique_cpf_seller unique (CPF),
		constraint unique_CNPJ_seller unique (CNPJ)
);

alter table Requisite auto_increment=1;

create table CliRequisite(
idCliRequisite int,
idRrequisite int,
primary key(idCliRequisite, idRrequisite),
constraint fk_client_requisite_requisite foreign key (idCliRequisite) references clients(idClient),
constraint fk_client_requisite_client foreign key (idRrequisite) references Requisite(idRequisite)
);

alter table CliRequisite auto_increment=1;

create table delivery(
		idDelivery int,
		idDOrder int,
		primary key(idDelivery, idDOrder),
		DStatus enum('Pendente', 'A caminho', 'Entregue', 'Cancelado') default 'Pendente',
		Ddescription varchar(100),
        TraceCode varchar(100),
        constraint unique_TraceCode_delivery unique (TraceCode),
		constraint fk_order_delivery_order foreign key (idDOrder) references orders(idOrders)
);

alter table delivery auto_increment=1;



