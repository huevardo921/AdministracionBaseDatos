create database practicas1josue
ON 

--Se le dan las especificaciones a la base de datos 
( NAME = practicas1josue, 

    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\practicas1josue.mdf', 

    SIZE = 19MB, 

    MAXSIZE = 50MB, 

    FILEGROWTH = 30MB ) 

go

-- creando esquema
create schema dbo1
go

-- creando tablas
create table dbo1.tbEmpresa(
	id_empresa int primary key identity(1,1),
	nombre varchar(50)  not null)
go

create table dbo1.tbActividad(
	id_actividad int primary key identity(1,1),
	nombre varchar(50)  not null,
	fecha date not null,
	tipo varchar(50) not null,
	id_empresa int,
	constraint FK_tbEmpresa_empresa_id foreign key (id_empresa) references dbo1.tbEmpresa(id_empresa)
)	
go

create table dbo1.tbInscritos(
	id_inscritos int primary key identity(1,1),
	nombre varchar(50)  not null,
	primerApellido varchar(50)  not null,
	rol varchar(50) not null,
	id_actividad int,
	constraint FK_tbActividad_actividad_id foreign key (id_actividad) references dbo1.tbActividad(id_actividad)
)
go

create table dbo1.Logs(
	id int primary key identity(1,1),
	texto varchar(50)  not null,
	fecha date not null,
	usuario varchar(50) not null
)
go

-- creando procedimientos almacenados insertar, mostrar, modificar y eliminar

create procedure dbo1.EmpresaInsertar(@nombre varchar(50))
	as
	begin 
		insert into dbo1.tbEmpresa(nombre)
		values(@nombre);
	end
	go

CREATE PROCEDURE dbo1.selectEmpresa
			AS 
			begin
			SELECT * FROM dbo1.tbEmpresa WHERE id_empresa = 1
			end
		GO
		

CREATE PROCEDURE dbo1.updateEmpresa  (@id_empresa INT,@nombre VARCHAR(50))
		AS 
		begin
		UPDATE dbo1.tbEmpresa SET  
       nombre = @nombre
       WHERE id_empresa = @id_empresa 
	   end

GO

create procedure dbo1.eliminarEmpresa(@id_empresa int )
as
begin
set nocount on;
delete from dbo1.tbEmpresa where id_empresa = @id_empresa;
end
go


-- Vistas

--Muestra los nombres de la tabla empresa
	create view dbo1.vista1_Empresa as 
	select nombre from dbo1.tbEmpresa
	go

--Muestra solo los campos de nombre donde coincida con la igualdad en nombre de la empresa
	create view dbo1.vista1_Empresa_nombre as 
	select  nombre='ICE' from dbo1.tbEmpresa
	go






--Este  trigger hace que muestre un mensaje de error si la cantidad de letras del nombre de la tabla emopresa es igual menor a 12
	--esto sucede a la hora a la insercion 
	create trigger dbo1.tbEmpresa_inser on dbo1.tbEmpresa
after insert
as
begin
set nocount on;
	 if exists(select 1 from inserted where len(inserted.nombre)<12)
	 begin
		RAISERROR('Valor equivocado',16,1)
		rollback transaction;
		return;
	 end
end
 go

 --Despues de una insercion va ir a registrar la actividad en la tabla logs 
 create trigger dbo1.tbLogs_insert on dbo1.Logs
after insert
as
begin
insert into [dbo1].[Logs]
values (GETDATE(),'inserto',1)
end
 go



