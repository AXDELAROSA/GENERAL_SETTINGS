
select * from data_02.dbo.usuarios_perm
select * from data_02.dbo.perm_pearl
SELECT * FROM bd_general.dbo.USUARIO_PEarl

select	codigo,nombre,apellido,usuario,tipo,app_pearl,descripcion 
from	users_pearl 
inner join	perm_pearl on codigo=usr_pearl 
			and		(rtrim(usuario)='alejandrod') 
inner join	apps_pearl on app_pearl=opt_cd

-- CONSULTA LOS GRUPOS DISPONIBLES PARA AGREGAR A LA VISTA DEL TREE VIEW LOS ENCABEZADOS
-- QUE ESTARAN DISPONIBLES
select distinct grupo from data_02.dbo.apps_pearl order by grupo
-- ASIGNA A LOS NODOS LAS FORMAS DISPONIBLES PARA CADA GRUPO
select * from data_02.dbo.apps_pearl where grupo='FINANZAS' order by grupo,descripcion

SELECT * FROM data_02.dbo.USERS_PEARL order by usuario
SELECT * FROM HOWE.dbo.VISTA_GAFETES order by ep_apellido_paterno


 SELECT	 SUBSTRING( EP_NOMBRE,1,CHARINDEX(' ',EP_NOMBRE))
		+SUBSTRING(EP_APELLIDO_PATERNO,1,1),
		EP_APELLIDO_PATERNO
 FROM HOWE.dbo.VISTA_GAFETES


 SELECT CHARINDEX(' ',EP_NOMBRE)-1
 FROM HOWE.dbo.VISTA_GAFETES

select DISTINCT(user_type) from usuarios_perm

select * from HOWE.dbo.VISTA_GAFETES  where EP_APELLIDO_PATERNO like '%galle%'

SELECT	k_usuario_pearl,
		codigo,
		d_usuario_pearl,
		usuario,
		ep_nombre,
		nombre,
		ep_apellido_paterno,
		apellido,
		ep_apellido_materno,
		k_empleado_pearl,
		EN_NUM_EMP
FROM	USuario_PEARL 
inner join HOWE.dbo.VISTA_GAFETES on EN_NUM_EMP=k_empleado_pearl
inner join data_02.dbo.USERS_PEARL on codigo=k_usuario_pearl

SELECT * FROM USUARIO_PEARL WHERE K_EMPLEADO_PEARL=0


SELECT   
		K_USUARIO_PEARL,
         EP_NOMBRE,
         EP_APELLIDO_PATERNO,
         EP_APELLIDO_MATERNO,
         CORREO_USUARIO_PEARL,
         USUARIO_TIPO,
         PASSWORD_USUARIO_PEARL,
         TEMA_USUARIO_PEARL
FROM     USUARIO_PEARL
INNER JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL