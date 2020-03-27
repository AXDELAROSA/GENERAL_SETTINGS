SELECT * FROM BD_GENERAL.DBO.CURRENCY WHERE L_CURRENCY=1
SELECT * FROM BD_GENERAL.DBO.TERMS 

--	SELECT * FROM DATA_02PRUEBAS.DBO.users_pearl
--	SELECT en_num_emp FROM DATA_02PRUEBAS.DBO.users_pearl

SELECT * 
FROM HOWE.DBO.VISTA_GAFETES
inner JOIN DATA_02PRUEBAS.DBO.users_pearl on correo=EP_CORREO_ELECTRONICO
WHERE EN_SUPERVISOR='GERENTES'

-- AGREGAR COLUMNA # RELOJ A LA TABLA DE USUARIOS_PEARL
--ALTER TABLE DATA_02PRUEBAS.DBO.users_pearl
--ADD en_num_emp		int default 0

-- ELIMINAR COLUMNA # RELOJ A LA TABLA DE USUARIOS_PEARL
-- ALTER TABLE DATA_02PRUEBAS.DBO.users_pearl
-- DROP COLUMN en_num_emp


-- PARA INSERTAR LOS VALORES CORRESPONDIENTES
DECLARE @VP_CORREO		VARCHAR(250)
DECLARE @VP_CODIGO		INT
DECLARE @VP_NOMBRE		VARCHAR(100)
DECLARE @VP_NUM_EMPL	INT
--DECLARE @VP_ESPACIOS	INT

DECLARE CU_INSERT_NUM_EMPL CURSOR LOCAL FOR		
		SELECT	EN_NUM_EMP,
				EP_CORREO_ELECTRONICO,
				(
				CASE WHEN CHARINDEX(' ',EP_NOMBRE)=0 THEN EP_NOMBRE
					 WHEN CHARINDEX(' ',EP_NOMBRE)<>0 THEN SUBSTRING( EP_NOMBRE,1,(CHARINDEX(' ',EP_NOMBRE))-1)
				END
				)+SUBSTRING(EP_APELLIDO_PATERNO,1,1)
				as nombre,
				ep_nombre,
				ep_apellido_paterno,
				ep_apellido_materno
--				,CHARINDEX(' ',EP_NOMBRE)
		FROM	HOWE.DBO.VISTA_GAFETES
--		where	ep_nombre like '%alma%'
		where	ep_apellido_paterno like '%pen%'
		order by nombre
OPEN CU_INSERT_NUM_EMPL
	FETCH NEXT FROM CU_INSERT_NUM_EMPL INTO	@VP_NUM_EMPL, @VP_CORREO,@VP_NOMBRE	--,@VP_ESPACIOS
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
	--SELECT	@VP_CODIGO=CODIGO
	--FROM	DATA_02PRUEBAS.DBO.users_pearl
	--WHERE	RTRIM(LTRIM(UPPER(correo)))=RTRIM(LTRIM(UPPER(@VP_CORREO)))

	SELECT	@VP_CODIGO=K_USUARIO_PEARL
	FROM	USUARIO_PEARL
	WHERE	D_USUARIO_PEARL=@VP_NOMBRE

		IF NOT(@VP_CODIGO IS NULL)
		BEGIN
			UPDATE	BD_GENERAL.DBO.USUARIO_PEARL
			SET
					K_EMPLEADO_PEARL = @VP_NUM_EMPL
			WHERE	D_USUARIO_PEARL=@VP_NOMBRE
		END

	FETCH NEXT FROM CU_INSERT_NUM_EMPL INTO	@VP_NUM_EMPL, @VP_CORREO,@VP_NOMBRE	--,@VP_ESPACIOS
	END
CLOSE		CU_INSERT_NUM_EMPL
DEALLOCATE	CU_INSERT_NUM_EMPL

/*
select * from usuarios_perm
SELECT * FROM bd_general.dbo.USUARIO_PEarl
select * from perm_pearl

select	codigo,nombre,apellido,usuario,tipo,app_pearl,descripcion 
from	users_pearl 
inner join	perm_pearl on codigo=usr_pearl 
			and		(rtrim(usuario)='alejandrod') 
inner join	apps_pearl on app_pearl=opt_cd

select distinct grupo from apps_pearl order by grupo

SELECT * FROM data_02.dbo.USERS_PEARL order by usuario
SELECT * FROM HOWE.dbo.VISTA_GAFETES order by ep_apellido_paterno


 SELECT	 SUBSTRING( EP_NOMBRE,1,CHARINDEX(' ',EP_NOMBRE))
		+SUBSTRING(EP_APELLIDO_PATERNO,1,1),
		EP_APELLIDO_PATERNO
 FROM HOWE.dbo.VISTA_GAFETES


 SELECT CHARINDEX(' ',EP_NOMBRE)-1
 FROM HOWE.dbo.VISTA_GAFETES

select DISTINCT(user_type) from usuarios_perm



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
*/