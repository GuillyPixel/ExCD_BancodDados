create database db_cds;
use db_cds;

create table tb_artista (
    pk_cod_art int auto_increment primary key,
    nome_art varchar(100) not null
);

create table tb_gravadora (
    pk_cod_grav int auto_increment primary key,
    nome_grav varchar(50) not null
);

create table tb_categoria (
    pk_cod_cat int auto_increment primary key,
    nome_cat varchar(50) not null
);

create table tb_estado (
    pk_sigla_est char(2) not null primary key,
    nome_est char(50) not null
);

create table tb_cidade (
    pk_cod_cid int auto_increment primary key,
    fk_sigla_est char(2) not null,
    nome_cid varchar(100) not null,
    foreign key (fk_sigla_est) references tb_estado (pk_sigla_est)
);

create table tb_cliente (
    pk_cod_cli int auto_increment primary key,
    nome_cli varchar(100) not null,
    fk_cod_cid int not null,
    end_cli varchar(200) not null,
    renda_cli decimal(10,2) not null default 0,
    sexo_cli enum('masculino', 'feminino') not null default 'feminino',
    foreign key (fk_cod_cid) references tb_cidade (pk_cod_cid)
);

create table tb_conjuge (
    pk_fk_cod_cli int auto_increment primary key,
    nome_conj varchar(100) not null,
    renda_conj decimal(10,2) not null default 0,
    sexo_conj enum('feminino', 'masculino') not null default 'masculino',
    foreign key (pk_fk_cod_cli) references tb_cliente (pk_cod_cli)
);

create table tb_funcionario (
    pk_cod_func int auto_increment primary key,
    nome_func varchar(100) not null,
    end_func varchar(200) not null,
    sexo_func enum('feminino', 'masculino') default 'masculino',
    sal_func decimal(10,2) not null default 0
);

create table dependente (
    pk_cod_dep int auto_increment primary key,
    nome_dep varchar(100) not null,
    fk_cod_func int not null,
    sexo_dep enum('feminino', 'masculino') default 'masculino',
    foreign key (fk_cod_func) references tb_funcionario (pk_cod_func)
);

create table tb_titulo (
    pk_cod_tit int auto_increment primary key,
    nome_cd varchar(100) not null unique,
    fk_cod_cat int not null,
    fk_cod_grav int not null,
    val_cd decimal(10,2) not null,
    qtd_estq int not null,
    foreign key (fk_cod_cat) references tb_categoria (pk_cod_cat),
    foreign key (fk_cod_grav) references tb_gravadora (pk_cod_grav)
);

create table tb_pedido (
    pk_num_ped int auto_increment primary key,
    data_ped datetime not null,
    fk_cod_cli int not null,
    fk_cod_func int not null,
    val_ped decimal(10,2) not null default 0,
    foreign key (fk_cod_cli) references tb_cliente(pk_cod_cli),
    foreign key (fk_cod_func) references tb_funcionario(pk_cod_func)
);

create table tb_titulo_pedido (
    fk_num_ped int not null,
    fk_cod_tit int not null,
    qtd_cd int not null,
    val_cd decimal(10,2) not null,
    primary key (fk_num_ped, fk_cod_tit),
    foreign key (fk_num_ped) references tb_pedido(pk_num_ped),
    foreign key (fk_cod_tit) references tb_titulo(pk_cod_tit)
);

create table tb_titulo_artista (
    fk_cod_tit int not null,
    fk_cod_art int not null,
    primary key (fk_cod_tit, fk_cod_art),
    foreign key (fk_cod_tit) references tb_titulo(pk_cod_tit),
    foreign key (fk_cod_art) references tb_artista(pk_cod_art)
);
