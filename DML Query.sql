insert into [dbo1].[tbEmpresa]([nombre])
values ('SpaceX')

insert into [dbo1].[tbActividad]([nombre],[fecha],[tipo],[id_empresa])
values ('SuperBowl',GETDATE(),'Deportes',2)

insert into [dbo1].[tbInscritos]([nombre],[primerApellido],[rol],[id_actividad])
values ('Josue','Camacho','Jugador',2)


select * from dbo1.tbEmpresa

select * from dbo1.tbActividad

select * from dbo1.tbInscritos