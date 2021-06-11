-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		BD_GENERAL
-- // MODULE:			USUARIO_PEARL
-- // OPERATION:		SP'S
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200324
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- ////////					CONTENIDO DEL SP
--	[PG_LI_USUARIO_PEARL]
--	[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG]
--	[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG_MENU]
--	[PG_SK_USUARIO_PEARL]
--	[PG_SK_USUARIO_INCONVENIENTE]
--	[PG_ASIGNAR_D_USUARIO]
--	[PG_SK_USUARIO_PEARL_NUEVO]
--	[PG_IN_USUARIO_PEARL]
--	[PG_INUP_USUARIO_PERMISOS]
--	[PG_UP_USUARIO_PEARL]
--	[PG_DL_USUARIO_PEARL]
--	[PG_SK_USUARIO_EXIST]
--	[PG_SK_USUARIO_LOGIN]
--	[PG_UP_USUARIO_LOGIN]
--	[PG_UP_THEME]


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_USUARIO_PEARL]
GO
-- select * from usuario_pearl
-- EXECUTE [dbo].[PG_LI_USUARIO_PEARL] 0,139,''
CREATE PROCEDURE [dbo].[PG_LI_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_COMODIN						VARCHAR(10)
AS
	-- =========================================
	SELECT	TOP (5000)
			K_USUARIO_PEARL AS K_CODIGO,
			K_EMPLEADO_PEARL AS K_EMPLEADO,
			APELLIDO_PATERNO AS APELLIDO_PATERNO,
			APELLIDO_MATERNO AS APELLIDO_MATERNO,
			NOMBRE AS NOMBRE,
			K_USUARIO_DEPARTAMENTO AS K_DEPARTAMENTO,
			D_USUARIO_PEARL AS USUARIO,
			(	CASE
					WHEN	LEN(CORREO_USUARIO_PEARL)=0		THEN	'SIN CORREO'
					WHEN	LEN(CORREO_USUARIO_PEARL)>=1	THEN	CORREO_USUARIO_PEARL
				END ) AS CORREO,
			K_USUARIO_TIPO AS K_USUARIO_TIPO,			
			(	CASE
					WHEN	K_USUARIO_PEARL	IN	(41,139,144)	THEN	''
					ELSE	PASSWORD_USUARIO_PEARL
			END )	AS [PASSWORD],
			TEMA_USUARIO_PEARL AS TEMA
	FROM    USUARIO_PEARL
	LEFT JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL
	WHERE	L_BORRADO=0
	ORDER BY APELLIDO_PATERNO ASC
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE USUARIO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG]
GO
--		 EXECUTE [dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG] 0,139,139
CREATE PROCEDURE [dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL				INT
--	@PP_K_GRUPO_TAG					INT
AS	
	-- =========================================
		SELECT DISTINCT		SISTEMA_TAG.K_GRUPO_TAG,
							SISTEMA_TAG.K_SISTEMA_TAG,
							D_SISTEMA_TAG,
							D_SISTEMA_TAG_MENU
		FROM				USUARIO_PEARL
		INNER JOIN	USUARIO_PERMISOS ON USUARIO_PEARL.k_usuario_pearl =USUARIO_PERMISOS.K_USUARIO_PEARL
		INNER JOIN	SISTEMA_TAG ON USUARIO_PERMISOS.K_SISTEMA_TAG=sistema_tag.K_SISTEMA_TAG
		INNER JOIN	GRUPO_TAG ON SISTEMA_TAG.K_GRUPO_TAG=GRUPO_TAG.K_GRUPO_TAG
		WHERE		USUARIO_PEARL.K_USUARIO_PEARL=@PP_K_USUARIO_PEARL
		--AND			SISTEMA_TAG.K_GRUPO_TAG=@PP_K_GRUPO_TAG
		ORDER BY	SISTEMA_TAG.K_GRUPO_TAG
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE MENU_EXPLORER
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG_MENU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG_MENU]
GO
--		 EXECUTE [dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG_MENU] 0,139,87,60
--		 EXECUTE [dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG_MENU] 1,139,87,60
CREATE PROCEDURE [dbo].[PG_LI_USUARIO_PERMISOS_SISTEMA_TAG_MENU]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL				INT,
	@PP_K_GRUPO_TAG					INT
AS
	-- =========================================
		SELECT DISTINCT		SISTEMA_TAG.K_GRUPO_TAG,
							SISTEMA_TAG.K_SISTEMA_TAG,
							CONCAT(D_SISTEMA_TAG,' ',S_SISTEMA_TAG) AS D_SISTEMA_TAG,
							CONCAT(D_SISTEMA_TAG_MENU,' ',S_SISTEMA_TAG) AS D_SISTEMA_TAG_MENU,
							K_IMAGEN_SISTEMA_TAG
		FROM				USUARIO_PEARL
		INNER JOIN	USUARIO_PERMISOS ON USUARIO_PEARL.k_usuario_pearl =USUARIO_PERMISOS.K_USUARIO_PEARL
		INNER JOIN	SISTEMA_TAG ON USUARIO_PERMISOS.K_SISTEMA_TAG=sistema_tag.K_SISTEMA_TAG
		INNER JOIN	GRUPO_TAG ON SISTEMA_TAG.K_GRUPO_TAG=GRUPO_TAG.K_GRUPO_TAG
		WHERE		USUARIO_PEARL.K_USUARIO_PEARL=@PP_K_USUARIO_PEARL
		AND			GRUPO_TAG.K_GRUPO_TAG=@PP_K_GRUPO_TAG
		AND			L_SISTEMA_TAG=1
		ORDER BY	SISTEMA_TAG.K_GRUPO_TAG
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USUARIO_PEARL]
GO
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL] 0,139,139
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL] 0,139,71
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL] 0,139,51
CREATE PROCEDURE [dbo].[PG_SK_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_CODIGO					VARCHAR(10)
AS
	SELECT	TOP (1)
			K_USUARIO_PEARL AS K_CODIGO,
			ISNULL(EN_NUM_EMP,0) AS K_EMPLEADO,
			ISNULL(EP_APELLIDO_PATERNO,'') AS APELLIDO_PATERNO,
			ISNULL(EP_APELLIDO_MATERNO,'') AS APELLIDO_MATERNO,
			ISNULL(EP_NOMBRE,'') AS NOMBRE,
			D_USUARIO_PEARL AS USUARIO,
			(	CASE
					WHEN	LEN(CORREO_USUARIO_PEARL)=0		THEN	'SIN CORREO'
					WHEN	LEN(CORREO_USUARIO_PEARL)>=1	THEN	CORREO_USUARIO_PEARL
				END ) AS CORREO,
			K_USUARIO_TIPO AS K_USUARIO_TIPO,
			PASSWORD_USUARIO_PEARL AS [PASSWORD],
			TEMA_USUARIO_PEARL AS TEMA
	FROM    USUARIO_PEARL
	LEFT JOIN	HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL
	WHERE	L_BORRADO<>1
	AND		K_USUARIO_PEARL=@PP_K_CODIGO
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USUARIO_INCONVENIENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USUARIO_INCONVENIENTE]
GO
-- EXECUTE [dbo].[PG_SK_USUARIO_INCONVENIENTE] 0,139,99999
-- EXECUTE [dbo].[PG_SK_USUARIO_INCONVENIENTE] 0,139,12602
-- EXECUTE [dbo].[PG_SK_USUARIO_INCONVENIENTE] 0,139,13164
CREATE PROCEDURE [dbo].[PG_SK_USUARIO_INCONVENIENTE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_D_USUARIO				VARCHAR(150),
	@PP_INCONVENIENTE			INT				OUTPUT
AS
DECLARE @VP_EXISTE INT
		IF	@PP_D_USUARIO LIKE ('%ANAL%') OR	@PP_D_USUARIO LIKE ('%BUEI%') OR	@PP_D_USUARIO LIKE ('%BUEY%')  
		OR	@PP_D_USUARIO LIKE ('%CACA%') OR	@PP_D_USUARIO LIKE ('%CACO%') OR	@PP_D_USUARIO LIKE ('%CAGA%')  
		OR	@PP_D_USUARIO LIKE ('%CAGO%') OR	@PP_D_USUARIO LIKE ('%CAKA%') OR	@PP_D_USUARIO LIKE ('%CAKO%')  
		OR	@PP_D_USUARIO LIKE ('%COGE%') OR	@PP_D_USUARIO LIKE ('%COJA%') OR	@PP_D_USUARIO LIKE ('%COJE%')  
		OR	@PP_D_USUARIO LIKE ('%COJI%') OR	@PP_D_USUARIO LIKE ('%COJO%') OR	@PP_D_USUARIO LIKE ('%CULA%')  
		OR	@PP_D_USUARIO LIKE ('%CULO%') OR	@PP_D_USUARIO LIKE ('%FETO%') OR	@PP_D_USUARIO LIKE ('%GUEY%')  
		OR	@PP_D_USUARIO LIKE ('%JOTO%') OR	@PP_D_USUARIO LIKE ('%KACA%') OR	@PP_D_USUARIO LIKE ('%KACO%')  
		OR	@PP_D_USUARIO LIKE ('%KAGA%') OR	@PP_D_USUARIO LIKE ('%KAGO%') OR	@PP_D_USUARIO LIKE ('%KOGE%')  
		OR	@PP_D_USUARIO LIKE ('%KOJO%') OR	@PP_D_USUARIO LIKE ('%KAKA%') OR	@PP_D_USUARIO LIKE ('%KULA%')
		OR	@PP_D_USUARIO LIKE ('%KULO%')  
		OR	@PP_D_USUARIO LIKE ('%MAME%') OR	@PP_D_USUARIO LIKE ('%MAMO%') OR	@PP_D_USUARIO LIKE ('%MEAR%')  
		OR	@PP_D_USUARIO LIKE ('%MEAS%') OR	@PP_D_USUARIO LIKE ('%MECO%') OR	@PP_D_USUARIO LIKE ('%MEKO%') 
		OR	@PP_D_USUARIO LIKE ('%MEQO%') OR	@PP_D_USUARIO LIKE ('%MIAR%') OR	@PP_D_USUARIO LIKE ('%MION%') 
		OR	@PP_D_USUARIO LIKE ('%MOCO%') OR	@PP_D_USUARIO LIKE ('%MOKO%') OR	@PP_D_USUARIO LIKE ('%MULA%')  
		OR	@PP_D_USUARIO LIKE ('%NACA%') OR	@PP_D_USUARIO LIKE ('%NACO%') OR	@PP_D_USUARIO LIKE ('%NAKA%') 
		OR	@PP_D_USUARIO LIKE ('%NAKO%') OR	@PP_D_USUARIO LIKE ('%PEDA%') 
		OR	@PP_D_USUARIO LIKE ('%PEDO%') OR	@PP_D_USUARIO LIKE ('%PENE%') OR	@PP_D_USUARIO LIKE ('%PITO%')  
		OR	@PP_D_USUARIO LIKE ('%PUTA%')  
		OR	@PP_D_USUARIO LIKE ('%PUTO%') OR	@PP_D_USUARIO LIKE ('%QULO%') OR	@PP_D_USUARIO LIKE ('%RATA%')  
		OR	@PP_D_USUARIO LIKE ('%RUIN%') OR	@PP_D_USUARIO LIKE ('%SEXO%')
					BEGIN
						SET @PP_INCONVENIENTE= 1
					END
				ELSE
					BEGIN
						SET @PP_INCONVENIENTE= 0
					END									
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_ASIGNAR_D_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_ASIGNAR_D_USUARIO]
GO
-- EXECUTE [dbo].[PG_ASIGNAR_D_USUARIO] 0,139,99999
-- EXECUTE [dbo].[PG_ASIGNAR_D_USUARIO] 0,139,12602	,''
-- EXECUTE [dbo].[PG_ASIGNAR_D_USUARIO] 0,139,13164	,''
-- EXECUTE [dbo].[PG_ASIGNAR_D_USUARIO] 0,139,12424	,''
CREATE PROCEDURE [dbo].[PG_ASIGNAR_D_USUARIO]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_EMPLEADO_PEARL			INT	,
	@PP_D_USUARIO					NVARCHAR(150)	OUTPUT
AS
	--==========================================	--==========================================
	-- PARA ASIGNAR LAS VARIACIONES DE NOMBRE DE USUARIO
DECLARE @VP_D_USUARIO_1 VARCHAR(30),  @VP_D_USUARIO_2 VARCHAR(30), @VP_D_USUARIO_3 VARCHAR(30),
		@VP_D_USUARIO_4 VARCHAR(30),  @VP_D_USUARIO_5 VARCHAR(30), 
		@VP_S_APELLIDO_P VARCHAR(30), @VP_S_APELLIDO_M VARCHAR(30)
	--==========================================	--==========================================
	-- PARA UTILIZAR EN EL CURSOR
	DECLARE @VP_CU_D_USUARIO_FINAL NVARCHAR(MAX)='',	@VP_EXISTE	INT=0,	@VP_INCONVENIENTE	INT=0		
	--==========================================	--==========================================
	-- PARA ALMACENAR LOS D_USUARIOS
	DECLARE @Tablausuario TABLE	( TA_D_USUARIO VARCHAR(250) )
	--==========================================	--==========================================	
	--==============================================================================================================================
	SELECT	TOP  (1)
	@VP_D_USUARIO_1=(	CASE WHEN CHARINDEX(' ',EP_NOMBRE)=0 
			THEN EP_NOMBRE		END		),
	@VP_D_USUARIO_2=(	CASE WHEN CHARINDEX(' ',EP_NOMBRE)<>0 
			THEN SUBSTRING( EP_NOMBRE,1,(CHARINDEX(' ',EP_NOMBRE))-1)	END		),
	@VP_D_USUARIO_3=(	CASE WHEN CHARINDEX(' ',EP_NOMBRE)<>0 
			THEN SUBSTRING( EP_NOMBRE,(CHARINDEX(' ',EP_NOMBRE))+1,LEN(EP_NOMBRE))	END	),
	@VP_D_USUARIO_4=(	CASE WHEN CHARINDEX(' ',EP_NOMBRE)<>0 
			THEN SUBSTRING( EP_NOMBRE,1,1)	
						+	SUBSTRING( EP_NOMBRE,(CHARINDEX(' ',EP_NOMBRE))+1,LEN(EP_NOMBRE))	END		),
	@VP_D_USUARIO_5=(	CASE WHEN CHARINDEX(' ',EP_NOMBRE)<>0 
			THEN SUBSTRING( EP_NOMBRE,1,(CHARINDEX(' ',EP_NOMBRE))-1)
						+	SUBSTRING( EP_NOMBRE,(CHARINDEX(' ',EP_NOMBRE))+1,1)	END	),
	@VP_S_APELLIDO_P=SUBSTRING(EP_APELLIDO_PATERNO,1,1),
	@VP_S_APELLIDO_M=SUBSTRING(EP_APELLIDO_MATERNO,1,1)
	FROM	HOWE.DBO.VISTA_GAFETES
	WHERE	EN_NUM_EMP=@PP_K_EMPLEADO_PEARL
	IF @@ROWCOUNT>0 
	BEGIN
		--==============================================================================================================================		
		--==============================================================================================================================		
		--==============================================================================================================================		
			IF NOT(@VP_D_USUARIO_1 IS NULL)
			BEGIN
				INSERT INTO		@Tablausuario (	TA_D_USUARIO )
				VALUES	(	@VP_D_USUARIO_1 + @VP_S_APELLIDO_P	),
						(	@VP_D_USUARIO_1 + @VP_S_APELLIDO_M	)
			END
			ELSE
			BEGIN
				INSERT INTO		@Tablausuario (	TA_D_USUARIO )
				VALUES	(	@VP_D_USUARIO_2 + @VP_S_APELLIDO_P	),		(	@VP_D_USUARIO_3 + @VP_S_APELLIDO_P	),
						(	@VP_D_USUARIO_4 + @VP_S_APELLIDO_P	),		(	@VP_D_USUARIO_5 + @VP_S_APELLIDO_P	),
						(	@VP_D_USUARIO_2 + @VP_S_APELLIDO_M	),		(	@VP_D_USUARIO_3 + @VP_S_APELLIDO_M	),		
						(	@VP_D_USUARIO_4 + @VP_S_APELLIDO_M	),		(	@VP_D_USUARIO_5 + @VP_S_APELLIDO_M	)
			END
				--==========================================	--==========================================
				DECLARE CU_Employee_Cursor CURSOR FOR  
					SELECT * FROM @Tablausuario
				OPEN			CU_Employee_Cursor  
				--==========================================	--==========================================
				FETCH NEXT FROM CU_Employee_Cursor INTO	@VP_CU_D_USUARIO_FINAL				
				WHILE @@FETCH_STATUS = 0
				BEGIN  
				   IF NOT(@VP_CU_D_USUARIO_FINAL IS NULL)
				   BEGIN
						EXECUTE	[dbo].[PG_SK_USUARIO_INCONVENIENTE]	@PP_K_SISTEMA_EXE , @PP_K_USUARIO_ACCION,
																	-- ===========================
																	@VP_CU_D_USUARIO_FINAL,	@VP_INCONVENIENTE			OUTPUT						
							--==========================================--==========================================
							--	SE VERIFICA SI EXISTE EL USUARIO EN EL SISTEMA
							IF(SELECT	COUNT(D_USUARIO_PEARL)	
										FROM BD_GENERAL.dbo.USUARIO_PEARL
										WHERE	LTRIM(RTRIM(UPPER(@VP_CU_D_USUARIO_FINAL)))=LTRIM(RTRIM(UPPER(D_USUARIO_PEARL))))>0
							BEGIN
								SET @VP_EXISTE=1
								BREAK
							END
							ELSE
							BEGIN
								SET @VP_EXISTE=0
							END
							--==========================================--==========================================					
						IF (@VP_INCONVENIENTE=0 AND @VP_EXISTE=0)
						BEGIN
							BREAK
						END
					END
				--==========================================	--==========================================
				FETCH NEXT FROM CU_Employee_Cursor INTO	@VP_CU_D_USUARIO_FINAL
				END
				CLOSE		CU_Employee_Cursor
				DEALLOCATE	CU_Employee_Cursor
		--==============================================================================================================================		
		--==============================================================================================================================		
		--==============================================================================================================================
	END
	ELSE
	BEGIN
		SET @VP_CU_D_USUARIO_FINAL='ASIGNAR_MANUALMENTE'
	END	
--==============================================================================================================================
	IF @VP_EXISTE <> 0	OR	@VP_INCONVENIENTE <> 0	OR @VP_CU_D_USUARIO_FINAL='' OR @VP_CU_D_USUARIO_FINAL IS NULL
	BEGIN
		SET @VP_CU_D_USUARIO_FINAL='ASIGNAR_MANUALMENTE'
	END
--==============================================================================================================================
	SET @PP_D_USUARIO = @VP_CU_D_USUARIO_FINAL
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USUARIO_PEARL_NUEVO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USUARIO_PEARL_NUEVO]
GO
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,99999
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,6666
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,12602
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,12424
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,5337
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,11879
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,14131
CREATE PROCEDURE [dbo].[PG_SK_USUARIO_PEARL_NUEVO]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_EMPLEADO_PEARL			INT
AS
DECLARE @VP_D_USUARIO		NVARCHAR(MAX)
DECLARE @VP_MENSAJE			NVARCHAR(MAX) = ''	, @VP_L_EXISTE		INT

	EXECUTE [DBO].[PG_RN_USUARIO_PEARL_EXISTS]	@PP_K_SISTEMA_EXE , @PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_EMPLEADO_PEARL, 
												@VP_MENSAJE			OUTPUT,
												@VP_L_EXISTE		OUTPUT

	IF @VP_MENSAJE=''
	BEGIN
		EXECUTE [dbo].[PG_ASIGNAR_D_USUARIO]	@PP_K_SISTEMA_EXE , @PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_EMPLEADO_PEARL,	@VP_D_USUARIO OUTPUT													
		-- ///////////////////////////////////////////
			SELECT	TOP  (1)
				EN_NUM_EMP AS EMPLEADO,
				@VP_D_USUARIO AS USUARIO,
				EP_NOMBRE AS NOMBRE,
				EP_APELLIDO_PATERNO AS APELLIDO_PATERNO,
				EP_APELLIDO_MATERNO AS APELLIDO_MATERNO,
				EN_NUM_DEPT AS K_DEPARTAMENTO,
				--==========================================
				(	CASE WHEN	@VP_D_USUARIO = 'ASIGNAR_MANUALMENTE'	THEN 'ASIGNAR_MANUALMENTE' 
					ELSE		@VP_D_USUARIO+'@PEARLLEATHER.COM.MX'	END)	AS CORREO,
				'Pass' + CONVERT(VARCHAR(10),EN_NUM_EMP)		AS [PASSWORD_PROVISIONAL],
				'' AS MENSAJE
			FROM HOWE.DBO.VISTA_GAFETES
			WHERE	EN_NUM_EMP=@PP_K_EMPLEADO_PEARL
	END
	ELSE
	BEGIN
		SELECT -1 AS EMPLEADO, @VP_MENSAJE AS MENSAJE
	END

GO

	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_USUARIO_PEARL]
GO
-- EXECUTE [dbo].[PG_IN_USUARIO_PEARL] 0,139,  11879 , 'EDITHL' , 'Password1' , '0' , 'EDITHL' , 30
-- EXECUTE [dbo].[PG_IN_USUARIO_PEARL] 0,139,  11879 , 'EDITHL' , 'Password1' , 'EDITHL' , '4' , 30 
CREATE PROCEDURE [dbo].[PG_IN_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
--	@PP_K_USUARIO_PEARL				INT,
	@PP_K_EMPLEADO_PEARL			INT,
	-- ===========================
	@PP_NOMBRE						VARCHAR(100),
	@PP_APELLIDO_PATERNO			VARCHAR(100),
	@PP_APELLIDO_MATERNO			VARCHAR(100),
	-- ===========================
	@PP_USUARIO						VARCHAR(50),
	@PP_PASSWORD					VARCHAR(15),
	-- ===========================
--	@PP_L_USUARIO_PEARL				INT,
	@PP_CORREO						VARCHAR(50),
	-- ===========================
	@PP_K_USUARIO_DEPARTAMENTO		INT,
	@PP_K_USUARIO_TIPO				INT
AS			
DECLARE @VP_MENSAJE								VARCHAR(500) = ''
DECLARE @VP_K_USUARIO_PEARL						INT = 0;	
DECLARE @VP_K_USUARIO_PEARL_EXISTE_PEARL		INT = 0;	
--DECLARE @VP_K_ADDRESS_USUARIO_PEARL	INT = 0;	
--DECLARE @VP_K_CONTACT_USUARIO_PEARL	INT = 0
	
BEGIN TRANSACTION 
BEGIN TRY
-- /////////////////////////////////////////////////////////////////////
	IF @PP_K_EMPLEADO_PEARL>0
		BEGIN
			SELECT  @VP_K_USUARIO_PEARL_EXISTE_PEARL=COUNT(K_EMPLEADO_PEARL)
			FROM	USUARIO_PEARL
			WHERE	K_EMPLEADO_PEARL=@PP_K_EMPLEADO_PEARL
			AND		K_EMPLEADO_PEARL>0
		END

	IF @VP_K_USUARIO_PEARL_EXISTE_PEARL>0
	BEGIN
		SET @VP_MENSAJE= 'EL USUARIO YA TIENE UN REGISTRO EN EL SISTEMA'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	--IF @PP_K_EMPLEADO_PEARL<1 AND @PP_L_EMPLEADO_PEARL=1
	--	SET @VP_MENSAJE= 'EL USUARIO YA TIENE UN REGISTRO EN EL SISTEMA'

	EXECUTE [BD_GENERAL].dbo.[PG_SK_CATALOGO_K_MAX_GET]		@PP_K_SISTEMA_EXE, 'BD_GENERAL',
															'USUARIO_PEARL', 'K_USUARIO_PEARL',
															@OU_K_TABLA_DISPONIBLE = @VP_K_USUARIO_PEARL	OUTPUT
	-- /////////////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_RN_USUARIO_PEARL_CLAVE_EXISTE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@VP_K_USUARIO_PEARL, 
															@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE<>''
	BEGIN
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	
	EXECUTE [dbo].[PG_RN_USUARIO_PEARL_UNIQUE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@VP_K_USUARIO_PEARL, @PP_USUARIO, @PP_CORREO,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	
	-- //////////////////////////////////////////////////////////////
	IF @VP_MENSAJE<>''
	BEGIN
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	--============================================================================
	--======================================INSERTAR EL USUARIO_PEARL
	--============================================================================
		INSERT INTO USUARIO_PEARL
			(	[K_USUARIO_PEARL]			,
				-- =========================
				[D_USUARIO_PEARL]			,
				-- ===========================
				[NOMBRE]					,
				[APELLIDO_PATERNO]			,
				[APELLIDO_MATERNO]			,
				-- ===========================
				[PASSWORD_USUARIO_PEARL]	,		--[L_CORREO_PEARL]	,
				[CORREO_USUARIO_PEARL]		,
				[K_USUARIO_DEPARTAMENTO]	,		
				[K_USUARIO_TIPO]	,
				-- =========================
				[K_EMPLEADO_PEARL]			,		--[L_USUARIO_PEARL],		
				-- =========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_USUARIO_PEARL			, 
				-- ===========================
				@PP_USUARIO					,
				-- ===========================
				@PP_NOMBRE					,
				@PP_APELLIDO_PATERNO		,
				@PP_APELLIDO_MATERNO		,
				-- ===========================
				@PP_PASSWORD				,		--@PP_L_CORREO				,
				@PP_CORREO					,		
				@PP_K_USUARIO_DEPARTAMENTO	,
				@PP_K_USUARIO_TIPO			,
				-- ============================
				@PP_K_EMPLEADO_PEARL		,		--@PP_L_USUARIO_PEARL,
				-- ============================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

		IF @@ROWCOUNT = 0
		BEGIN
			SET @VP_MENSAJE='El USUARIO_PEARL no fue ingresado(INTO). [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@VP_K_USUARIO_PEARL)+']'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
	--============================================================================
	--======================================INSERTAR EL USUARIO_PEARL EN BD DATA_02
	--====================================== POR GESTION DE PERMISOS EN PANTALLAS
	--====================================== CON CODIGO ANTERIOR
	--============================================================================
		DECLARE @VP_TIPO_DATA_02		VARCHAR(10)
		SELECT	@VP_TIPO_DATA_02	= S_USUARIO_TIPO 
		FROM	USUARIO_TIPO
		WHERE	K_USUARIO_TIPO	=	@PP_K_USUARIO_TIPO
		
		INSERT INTO	[DATA_02].[dbo].[users_pearl]
		(	
			[nombre]
		    ,[apellido]		,[usuario]
			,[contrasena]	,[correo]
			,[tipo]			,[tema]
			,[K_USUARIO_PEARL]
		)
		VALUES
		(
			 @PP_NOMBRE
			,@PP_APELLIDO_PATERNO	,@PP_USUARIO
			,@PP_PASSWORD			,@PP_CORREO
			,@VP_TIPO_DATA_02		,'Flat Nature.isl'
			,@VP_K_USUARIO_PEARL
		)

		IF @@ROWCOUNT = 0
		BEGIN
			SET @VP_MENSAJE='El USUARIO_PEARL no fue ingresado(INTO) en DATA. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@VP_K_USUARIO_PEARL)+']'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
	--============================================================================
-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	-- Ocurrió un error, deshacemos los cambios
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH	

	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
	BEGIN
		SET		@VP_MENSAJE = 'No es posible [Insertar] el [USUARIO_PEARL]: ' + @VP_MENSAJE 
	END

	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_USUARIO_PEARL AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_INUP_USUARIO_PERMISOS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_INUP_USUARIO_PERMISOS]
GO
-- EXECUTE [dbo].[PG_INUP_USUARIO_PERMISOS] 0, 139, 139, '23/31/51/52/53'
CREATE PROCEDURE [dbo].[PG_INUP_USUARIO_PERMISOS]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PERMISOS			INT,
	-- ===========================
	@PP_PERMISOS_ARRAY				NVARCHAR(MAX)
AS			

DECLARE @VP_MENSAJE				VARCHAR(500) = ''
DECLARE @VP_K_USUARIO_PEARL			INT = 0;	
--DECLARE @VP_K_ADDRESS_USUARIO_PEARL	INT = 0;	
--DECLARE @VP_K_CONTACT_USUARIO_PEARL	INT = 0
	
BEGIN TRANSACTION 
BEGIN TRY
-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
	BEGIN		
	--============================================================================
	--======================================ELIMINAR PERMISOS
	--============================================================================
	DELETE	FROM USUARIO_PERMISOS
	WHERE	K_USUARIO_PEARL=@PP_K_USUARIO_PERMISOS
	--============================================================================
	--======================================INSERTAR PERMISOS
	--============================================================================
	-----=====================================================
	-- SE HACE UN CURSOR PARA OBTENER CADA UNO DE LOS PERMISOS
	-- SE DECLARA LA TABLA DONDE SE ALMACENARAN LOS REGISTROS OBTENIDOS DEL ARRAY.	
		DECLARE @TBL_USUARIO_PERMISOS TABLE 
				(
				K_SISTEMA		INT
				)
		SET NOCOUNT ON
				
				DECLARE @VP_POSICION_K_SISTEMA		INT
				DECLARE @VP_VALOR_K_SISTEMA			INT
								
				--COLOCAMOS UN SEPARADOR AL FINAL DE LOS PARAMETROS PARA QUE FUNCIONE BIEN NUESTRO CODIGO
				SET	@PP_PERMISOS_ARRAY=@PP_PERMISOS_ARRAY + '/'		
			
				--HACEMOS UN BUCLE QUE SE REPITE MIENTRAS HAYA SEPARADORES, PATINDEX BUSCA UN PATRON EN UNA CADENA Y NOS DEVUELVE SU POSICION
				WHILE patindex('%/%' , @PP_PERMISOS_ARRAY) <> 0
					BEGIN
						SELECT @VP_POSICION_K_SISTEMA	=	patindex('%/%' , @PP_PERMISOS_ARRAY)
						
						--BUSCAMOS LA POSICION DE LA PRIMERA Y OBTENEMOS LOS CARACTERES HASTA ESA POSICION
						SELECT @VP_VALOR_K_SISTEMA		= LEFT(@PP_PERMISOS_ARRAY, @VP_POSICION_K_SISTEMA - 1)
						
						--SE HACE EL INSERT DEL REGISTRO EN LA TABLA, AQUI HARÁ UN INSERT POR CADA UNO DE LOS VALORES ENCONTRADOS EN EL ARRAY.
								INSERT	INTO	@TBL_USUARIO_PERMISOS
								VALUES	(
											@VP_VALOR_K_SISTEMA
										)																								
						--REEMPLAZAMOS LO PROCESADO CON NADA CON LA FUNCION STUFF
						SELECT @PP_PERMISOS_ARRAY			= STUFF(@PP_PERMISOS_ARRAY, 1, @VP_POSICION_K_SISTEMA, '')
				END
				
				DECLARE @VP_N_K_SISTEMA INT = 0
				SELECT @VP_N_K_SISTEMA = COUNT(K_SISTEMA) FROM @TBL_USUARIO_PERMISOS
				SET NOCOUNT OFF
		-- ---------------SI NO HAY PIELES SELECCIONADAS GENERAMOS UN ERROR DE TRANSACCION
				IF @VP_N_K_SISTEMA IS NULL
					RAISERROR ('No se recibió ningún [PERMISO]. Debe seleccionar uno como mínimo.', 16, 1 )
		
			DECLARE @VP_CU_K_SISTEMA			INT

			DECLARE CU_CURSOR CURSOR LOCAL FOR
				SELECT K_SISTEMA FROM @TBL_USUARIO_PERMISOS
			OPEN CU_CURSOR
					FETCH NEXT FROM CU_CURSOR INTO @VP_CU_K_SISTEMA
					WHILE @@FETCH_STATUS = 0
					BEGIN
					----------------------------------------------------	
					-- AQUI REALIZARA LOS INSERT DE LOS PERMISOS DEL USUARIO
						INSERT INTO USUARIO_PERMISOS
							(	[K_USUARIO_PEARL]			,
								-- =========================
								[K_SISTEMA_TAG]				)
						VALUES	
							(	@PP_K_USUARIO_PERMISOS		, 
								-- ===========================
								@VP_CU_K_SISTEMA			)
						
							IF @@ROWCOUNT = 0
								BEGIN
									SET @VP_MENSAJE='No se insertaron los permisos de usuario(INTO). [K_SISTEMA#'+CONVERT(VARCHAR(10),@VP_CU_K_SISTEMA)+']'
									RAISERROR (@VP_MENSAJE, 16, 1 )
								END				

					FETCH NEXT FROM CU_CURSOR INTO @VP_CU_K_SISTEMA
					END
			CLOSE CU_CURSOR
			DEALLOCATE CU_CURSOR
	-----=====================================================
	END
-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	-- Ocurrió un error, deshacemos los cambios
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH	

	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
	BEGIN
		SET		@VP_MENSAJE = 'No es posible [Insertar] los [PERMISOS]: ' + @VP_MENSAJE 
	END

	SELECT	@VP_MENSAJE AS MENSAJE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_USUARIO_PEARL]
GO
-- EXECUTE [dbo].[PG_UP_USUARIO_PEARL] 0,139,  11879 , 'EDITHL' , 'Password1' , '0' , 'EDITHL' , 30
-- EXECUTE [dbo].[PG_UP_USUARIO_PEARL] 0,139,  11879 , 'EDITHL' , 'Password1' , 'EDITHL' , '4' , 30
CREATE PROCEDURE [dbo].[PG_UP_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL				INT,
	@PP_K_EMPLEADO_PEARL			INT,
	-- ===========================
	@PP_NOMBRE						VARCHAR(100),
	@PP_APELLIDO_PATERNO			VARCHAR(100),
	@PP_APELLIDO_MATERNO			VARCHAR(100),
	-- ===========================
	@PP_USUARIO						VARCHAR(50),
	@PP_PASSWORD					VARCHAR(15),
	-- ===========================
	@PP_CORREO						VARCHAR(50),
	-- ===========================
	@PP_K_USUARIO_DEPARTAMENTO		INT,
	@PP_K_USUARIO_TIPO				INT
--	@PP_L_USUARIO_PEARL				INT,
AS			

DECLARE @VP_MENSAJE								VARCHAR(500) = ''
--DECLARE @VP_K_USUARIO_PEARL						INT = 0;	
--DECLARE @VP_K_USUARIO_PEARL_EXISTE_PEARL		INT = 0;	
--DECLARE @VP_K_ADDRESS_USUARIO_PEARL	INT = 0;	
--DECLARE @VP_K_CONTACT_USUARIO_PEARL	INT = 0	
BEGIN TRANSACTION 
BEGIN TRY
-- /////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_RN_USUARIO_PEARL_UNIQUE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_USUARIO_PEARL, @PP_USUARIO, @PP_CORREO,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- //////////////////////////////////////////////////////////////
	IF @VP_MENSAJE<>''
	BEGIN
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END		
	--============================================================================
	--======================================UPDATE EL USUARIO_PEARL
	--============================================================================
	UPDATE USUARIO_PEARL
	SET
		[D_USUARIO_PEARL]			= @PP_USUARIO					,
		-- =========================-- ===========================	,
		[NOMBRE]					= @PP_NOMBRE					,
		[APELLIDO_PATERNO]			= @PP_APELLIDO_PATERNO			,
		[APELLIDO_MATERNO]			= @PP_APELLIDO_MATERNO			,
		-- =========================-- ===========================	,
		[PASSWORD_USUARIO_PEARL]	= @PP_PASSWORD					,
		[CORREO_USUARIO_PEARL]		= @PP_CORREO					,
		[K_USUARIO_DEPARTAMENTO]	= @PP_K_USUARIO_DEPARTAMENTO	,
		[K_USUARIO_TIPO]			= @PP_K_USUARIO_TIPO			,
		-- =========================-- ==========================	,
		[K_EMPLEADO_PEARL]			= @PP_K_EMPLEADO_PEARL			,
		-- =========================-- ========================
		[F_CAMBIO]					= GETDATE(), 
		[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION
	WHERE   [K_USUARIO_PEARL]			= @PP_K_USUARIO_PEARL
	AND		[K_EMPLEADO_PEARL]			= @PP_K_EMPLEADO_PEARL					

	IF @@ROWCOUNT = 0
	BEGIN
		SET @VP_MENSAJE='El USUARIO_PEARL no fue modificado(UP). [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+']'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	--============================================================================
	--======================================ACTUALIZAR EL USUARIO_PEARL EN BD DATA_02
	--====================================== POR GESTION DE PERMISOS EN PANTALLAS
	--====================================== CON CODIGO ANTERIOR
	--============================================================================
		DECLARE @VP_TIPO_DATA_02		VARCHAR(10)
		SELECT	@VP_TIPO_DATA_02	= S_USUARIO_TIPO 
		FROM	USUARIO_TIPO
		WHERE	K_USUARIO_TIPO	=	@PP_K_USUARIO_TIPO
						
		UPDATE	[DATA_02].[dbo].[users_pearl]
		SET
			[nombre]			=  @PP_NOMBRE
		    ,[apellido]			=  @PP_APELLIDO_PATERNO	
			,[usuario]			=  @PP_USUARIO
			,[contrasena]		=  @PP_PASSWORD			
			,[correo]			=  @PP_CORREO
			,[tipo]				=  @VP_TIPO_DATA_02		
			,[tema]				=  'Flat Nature.isl'		
		WHERE	K_USUARIO_PEARL	=	@PP_K_USUARIO_PEARL			

		IF @@ROWCOUNT = 0
		BEGIN
			SET @VP_MENSAJE='El USUARIO_PEARL no fue ingresado(INTO) en DATA. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+']'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
	--============================================================================
-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	-- Ocurrió un error, deshacemos los cambios
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH	

	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
	BEGIN
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [USUARIO_PEARL]: ' + @VP_MENSAJE 
	END

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_USUARIO_PEARL AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
--	EXECUTE [dbo].[PG_DL_USUARIO_PEARL] 0,139,380,2,2
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_USUARIO_PEARL]
GO
CREATE PROCEDURE [dbo].[PG_DL_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL				INT
AS
DECLARE @VP_MENSAJE				VARCHAR(300) = ''
--DECLARE @PP_K_ADDRESS_USUARIO_PEARL			INT
--DECLARE @PP_K_CONTACT_USUARIO_PEARL			INT
BEGIN TRANSACTION 
BEGIN TRY
--/////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
	BEGIN
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_DELETE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_USUARIO_PEARL, 
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	END
	--////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
	BEGIN		
		UPDATE	USUARIO_PEARL
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_USUARIO_PEARL=@PP_K_USUARIO_PEARL

		IF @@ROWCOUNT = 0
			BEGIN
				SET @VP_MENSAJE='El USUARIO_PEARL no fue modificado(DL). [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+']'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END		
	END
	
	IF @VP_MENSAJE=''
		DELETE	FROM USUARIO_PERMISOS
		WHERE	K_USUARIO_PEARL=@PP_K_USUARIO_PEARL

		--IF @@ROWCOUNT = 0
		--	BEGIN
		--		SET @VP_MENSAJE='The USUARIO_PERMITS was not delete. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+']'
		--	END
-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	-- Ocurrió un error, deshacemos los cambios
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH	

	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
	BEGIN
		SET		@VP_MENSAJE = 'No es posible [Eliminar] el [USUARIO_PEARL]: ' + @VP_MENSAJE 
	END

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_USUARIO_PEARL AS CLAVE
	-- //////////////////////////////////////////////////////////////
	
	-- //////////////////////////////////////////////////////////////	
GO


-- =============================================================================================================================================================================================================
-- =============================================================================================================================================================================================================
-- =============================================================================================================================================================================================================
-- =============================================================================================================================================================================================================
-- =============================================================================================================================================================================================================
-- =============================================================================================================================================================================================================


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / SEEK USUARIO POR D_USUARIO
-- // PROCEDIMIENTOS PARA LA FORMA DE LOGIN	20200623
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USUARIO_EXIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USUARIO_EXIST]
GO
-- EXECUTE [dbo].[PG_SK_USUARIO_EXIST] 'SISTEMAS'
-- EXECUTE [dbo].[PG_SK_USUARIO_EXIST] 'ALEJANDROD'
-- EXECUTE [dbo].[PG_SK_USUARIO_EXIST] 'ALEJANDRO'	
CREATE PROCEDURE [dbo].[PG_SK_USUARIO_EXIST]
	--@PP_K_SISTEMA_EXE				INT,
	--@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_USUARIO					VARCHAR(50)
AS
-- =========================================	
	DECLARE @VP_K_CODIGO INTEGER
	DECLARE @PP_K_USUARIO INTEGER
	DECLARE @VP_MENSAJE VARCHAR(500)

	SELECT	@PP_K_USUARIO=(K_USUARIO_PEARL)
	FROM	USUARIO_PEARL
	WHERE	D_USUARIO_PEARL=@PP_D_USUARIO

	IF @PP_K_USUARIO IS NULL OR @PP_K_USUARIO=-1
		BEGIN
			SET		@VP_MENSAJE			= 'Nombre de [Usuario] inválido'	---'Invalid [USER] name.'
			SET		@VP_K_CODIGO		=-10			
		END
	
	SELECT	@VP_MENSAJE			AS MENSAJE,
			@VP_K_CODIGO		AS USUARIO_CODIGO
-- /////////////////////////////////////////////////////////////////////
GO

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / SEEK USUARIO POR D_USUARIO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USUARIO_LOGIN]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USUARIO_LOGIN]
GO
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'SISTEMAS','m@ster++'
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'ALEJANDROD','11111111'
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'ALEJANDROD','111111'
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'ALEJANDROD','XXX'		
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'VIVIANAC','123450'		
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'ALEJANDRO','11111111'
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'ROSARIOM','DEREK10'
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'PLG','9plg'
-- EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'ADRIANC','Password02'
CREATE PROCEDURE [dbo].[PG_SK_USUARIO_LOGIN]
	--@PP_K_SISTEMA_EXE				INT,
	--@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_USUARIO					VARCHAR(50),
	@PP_PASSWORD					VARCHAR(50)
AS
-- =========================================	
	DECLARE	 @VP_MENSAJE			VARCHAR(500)
			,@PP_K_USUARIO			INTEGER
			-- ===========================
			,@VP_K_CODIGO			INTEGER
			,@VP_NOMBRE_APELLIDO	VARCHAR(100)
			-- ===========================
			,@VP_TEMA				VARCHAR(100)
			,@VP_D_USUARIO			VARCHAR(100)
			,@VP_D_USUARIO_TIPO		VARCHAR(100)
			,@VP_S_USUARIO_TIPO		VARCHAR(100)
			-- ===========================
			,@VP_K_EMPLEADO_PEARL	INTEGER
			,@VP_EXISTE_EMPLEADO	INTEGER

BEGIN TRANSACTION 
BEGIN TRY
	SELECT	 @PP_K_USUARIO			= K_USUARIO_PEARL
			,@VP_K_EMPLEADO_PEARL	= K_EMPLEADO_PEARL
	FROM	USUARIO_PEARL
	WHERE	D_USUARIO_PEARL			= @PP_D_USUARIO
	AND		L_BORRADO				<> 1
	
	---- ========================================================================================
	--	PRIMERO SE VERIFICA QUE EL USUARIO NO SE ENCUENTRE ELIMINADO...
	IF @PP_K_USUARIO IS NULL
	BEGIN
		SET		@VP_K_CODIGO		=-10
		SET		@VP_NOMBRE_APELLIDO	=NULL
		SET		@VP_TEMA			=NULL
		SET		@VP_D_USUARIO		=NULL
		SET		@VP_D_USUARIO_TIPO	=NULL
		SET		@VP_S_USUARIO_TIPO	=NULL
		--SET		@VP_MENSAJE			= 'The [User] was down...'	---'Invalid [USER] name.'
		SET		@VP_MENSAJE			= 'Invalid User: ['+ UPPER(@PP_D_USUARIO) +']'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END

	---- ========================================================================================
	--	SE VERIFICA QUE EL USUARIO TENGA ALTA EN LA EMPRESA, LOS QUE TIENEN VALOR [0], SON AQUELLOS QUE SON GENERICOS O FORANEOS...
	IF @VP_K_EMPLEADO_PEARL	<> 0
	BEGIN	
		--IF @VP_K_EMPLEADO_PEARL	<> -1
		IF (	@VP_K_EMPLEADO_PEARL	<> -1	AND @VP_K_EMPLEADO_PEARL NOT IN (13710))
		BEGIN
			SELECT  @VP_EXISTE_EMPLEADO=	COUNT(EN_NUM_EMP)
			FROM    USUARIO_PEARL
			LEFT JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL
			WHERE	EN_NUM_EMP	=	@VP_K_EMPLEADO_PEARL	--K_EMPLEADO_PEARL

			IF @VP_EXISTE_EMPLEADO= 0
			BEGIN
				SET		@VP_K_CODIGO		=-10
				SET		@VP_NOMBRE_APELLIDO	=NULL
				SET		@VP_TEMA			=NULL
				SET		@VP_D_USUARIO		=NULL
				SET		@VP_D_USUARIO_TIPO	=NULL
				SET		@VP_S_USUARIO_TIPO	=NULL
				--SET		@VP_MENSAJE			= 'Hubo un Problema con la cuenta de [Usuario] informe a Sistemas...'	---'Invalid [USER] name.'
				SET		@VP_MENSAJE			= 'There was a problem with the [User] account report to Systems ...'	---'Invalid [USER] name.'
				
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
		END
	END

	--IF @PP_K_USUARIO IS NULL OR @PP_K_USUARIO=-1
	--	BEGIN
	--		SET		@VP_K_CODIGO		=-10
	--		SET		@VP_NOMBRE_APELLIDO	=NULL
	--		SET		@VP_TEMA			=NULL
	--		SET		@VP_D_USUARIO		=NULL
	--		SET		@VP_D_USUARIO_TIPO	=NULL
	--		SET		@VP_S_USUARIO_TIPO	=NULL
	--		--SET		@VP_MENSAJE			= 'Nombre de [Usuario] inválido...'	---'Invalid [USER] name.'
	--		SET		@VP_MENSAJE			= 'Invalid User: ['+ UPPER(@PP_D_USUARIO)+']'
			
	--		RAISERROR (@VP_MENSAJE, 16, 1 )
	--	END
	--ELSE
	--	BEGIN
		SELECT	@VP_K_CODIGO		=	K_USUARIO_PEARL,
				
				@VP_NOMBRE_APELLIDO	=	CONCAT((
												CASE 
												WHEN CHARINDEX(' ',NOMBRE)=0  THEN NOMBRE
												WHEN CHARINDEX(' ',NOMBRE)<>0 THEN SUBSTRING( NOMBRE,1,(CHARINDEX(' ',NOMBRE))-1)
												END),' ',APELLIDO_PATERNO),
				@VP_TEMA			=TEMA_USUARIO_PEARL,
				@VP_D_USUARIO		=lower(D_USUARIO_PEARL),
				@VP_D_USUARIO_TIPO	=D_USUARIO_TIPO,
				@VP_S_USUARIO_TIPO	=S_USUARIO_TIPO
		FROM	USUARIO_PEARL, USUARIO_TIPO
		WHERE	D_USUARIO_PEARL							= @PP_D_USUARIO
		AND		LTRIM(RTRIM(PASSWORD_USUARIO_PEARL))	= LTRIM(RTRIM(@PP_PASSWORD))
		--=======================================================
		AND		USUARIO_PEARL.K_USUARIO_TIPO=USUARIO_TIPO.K_USUARIO_TIPO

		IF	@VP_K_CODIGO IS NULL
		BEGIN
			SET		@VP_K_CODIGO		=-100
			SET		@VP_NOMBRE_APELLIDO	=NULL
			SET		@VP_TEMA			=NULL
			SET		@VP_D_USUARIO		=NULL
			SET		@VP_D_USUARIO_TIPO	=NULL
			SET		@VP_S_USUARIO_TIPO	=NULL
			--SET		@VP_MENSAJE			= '[PASSWORD] no válido, vuelva a intentar...'
			SET		@VP_MENSAJE			= 'Invalid [PASSWORD], please try again...'				
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		--END

		------ ========================================================================================
		----	SE VERIFICA QUE EL PASSWORD NO CONTENGA LA PALABRA "PASS"...
		IF	UPPER(@PP_PASSWORD) LIKE '%PASS%'
		BEGIN
			--SET @VP_MENSAJE='El [PASSWORD] no puede contener el texto PASS, verifique y vuelva a intenar...'
			SET @VP_MENSAJE='It´s necessary change the [PASSWORD] cannot contain the [PASS] text...'
			SET @VP_K_CODIGO=-100

			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		
	-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
		BEGIN
			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
		END

	SELECT	@VP_MENSAJE			AS MENSAJE,
			@VP_K_CODIGO		AS USUARIO_CODIGO,	
			@VP_NOMBRE_APELLIDO	AS NOMBRE_APELLIDO,
			@VP_TEMA			AS USUARIO_TEMA,
			@VP_D_USUARIO		AS D_USUARIO,
			@VP_S_USUARIO_TIPO	AS USUARIO_TIPO,
			@VP_D_USUARIO_TIPO	AS D_USUARIO_TIPO

	-- //////////////////////////////////////////////////////////////
GO

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / USUARIO POR D_USUARIO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_USUARIO_LOGIN]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_USUARIO_LOGIN]
GO
-- EXECUTE [dbo].[PG_UP_USUARIO_LOGIN] 'ALEJANDROD','XXX','YYY'
CREATE PROCEDURE [dbo].[PG_UP_USUARIO_LOGIN]
	--@PP_K_SISTEMA_EXE				INT,
	--@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_USUARIO					VARCHAR(50),
	@PP_PASSWORD_OLD				VARCHAR(50),
	@PP_PASSWORD_NEW				VARCHAR(50)
AS
-- =========================================	
	DECLARE  @PP_K_USUARIO			INTEGER
			,@VP_MENSAJE			VARCHAR(500)
			,@VP_K_CODIGO			INTEGER
			,@VP_K_EMPLEADO_PEARL	INTEGER
			,@VP_EXISTE_EMPLEADO	INTEGER

BEGIN TRANSACTION 
BEGIN TRY
	---- ========================================================================================
	--	PRIMERO SE VERIFICA QUE EXISTA EL USUARIO...
	SELECT	 @PP_K_USUARIO			= K_USUARIO_PEARL
			,@VP_K_EMPLEADO_PEARL	= K_EMPLEADO_PEARL
	FROM	USUARIO_PEARL
	WHERE	D_USUARIO_PEARL			= @PP_D_USUARIO
	
	IF @PP_K_USUARIO IS NULL OR @PP_K_USUARIO=-1
	BEGIN
		--SET		@VP_MENSAJE			= 'USUARIO Inválido: ['+UPPER(@PP_D_USUARIO)+']'
		SET		@VP_MENSAJE			= 'Invalid User: ['+UPPER(@PP_D_USUARIO)+']'
		SET		@VP_K_CODIGO		=-10

		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	ELSE
	BEGIN

		---- ========================================================================================
	--	SE VERIFICA QUE EL USUARIO TENGA ALTA EN LA EMPRESA, LOS QUE TIENEN VALOR [0], SON AQUELLOS QUE SON GENERICOS O FORANEOS...
	IF @VP_K_EMPLEADO_PEARL	<> 0
	BEGIN	
		IF (	@VP_K_EMPLEADO_PEARL	<> -1	AND @VP_K_EMPLEADO_PEARL NOT IN (13710))
		BEGIN			
			SELECT  @VP_EXISTE_EMPLEADO=	COUNT(EN_NUM_EMP)
			FROM    USUARIO_PEARL
			LEFT JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL
			WHERE	EN_NUM_EMP	=	@VP_K_EMPLEADO_PEARL	--K_EMPLEADO_PEARL

			IF @VP_EXISTE_EMPLEADO= 0
			BEGIN
				SET		@VP_K_CODIGO		=-10
				--SET		@VP_MENSAJE			= 'Hubo un Problema con la cuenta de [Usuario] informe a Sistemas...'	---'Invalid [USER] name.'
				SET		@VP_MENSAJE			= 'There was a problem with the [User] account report to Systems ...'	---'Invalid [USER] name.'
				
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
		END
	END	
		------ ========================================================================================
		----	SE VERIFICA QUE EL EMPLEADO NO TENGA BAJA EN LA EMPRESA...
		--SELECT  @VP_EXISTE_EMPLEADO	= COUNT(EN_NUM_EMP)
		--FROM    USUARIO_PEARL
		--LEFT JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP	= K_EMPLEADO_PEARL
		--WHERE	EN_NUM_EMP			= @VP_K_EMPLEADO_PEARL

		--IF @VP_EXISTE_EMPLEADO= 0
		--BEGIN
		--	--SET		@VP_MENSAJE			= 'Hubo un Problema con la cuenta de [Usuario] informe a Sistemas...'	---'Invalid [USER] name.'
		--	SET		@VP_MENSAJE			= 'There was a problem with the [User] account report to Systems ...'	---'Invalid [USER] name.'
		--	SET		@VP_K_CODIGO		=-10
			
		--	RAISERROR (@VP_MENSAJE, 16, 1 )
		--END

		---- ========================================================================================
		--	SE VERIFICA EL PASSWORD ACTUAL ANTES DE REALIZAR EL CAMBIO...
		SELECT	@VP_K_CODIGO			= K_USUARIO_PEARL
		FROM	USUARIO_PEARL, USUARIO_TIPO
		WHERE	D_USUARIO_PEARL			= @PP_D_USUARIO
		AND		PASSWORD_USUARIO_PEARL	= @PP_PASSWORD_OLD

		IF	@VP_K_CODIGO IS NULL
		BEGIN
			--SET		@VP_MENSAJE			= 'El valor del [PASSWORD] actual no es correcto, vuelva a intentar...'
			SET		@VP_MENSAJE			= 'The current [PASSWORD] value is not correct, please try again ...'
			SET		@VP_K_CODIGO		=-100

			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		ELSE
		BEGIN
			------ ========================================================================================
			----	SE VERIFICA QUE EL PASSWORD NO CONTENGA LA PALABRA "PASS"...
			IF	UPPER(@PP_PASSWORD_NEW) LIKE '%PASS%'
			BEGIN
				--SET @VP_MENSAJE='El [PASSWORD] no puede contener el texto PASS, verifique y vuelva a intenar...'
				SET @VP_MENSAJE='The [NEW PASSWORD] cannot contain the [PASS] text, please check and try again...'
				SET @VP_K_CODIGO=-500

				RAISERROR (@VP_MENSAJE, 16, 1 )
			END

			UPDATE	USUARIO_PEARL
			SET		PASSWORD_USUARIO_PEARL	= @PP_PASSWORD_NEW
			WHERE	K_USUARIO_PEARL			= @VP_K_CODIGO
			AND		D_USUARIO_PEARL			= @PP_D_USUARIO		
						
			IF @@ROWCOUNT > 0
			BEGIN
				--SET @VP_MENSAJE='El [PASSWORD] fue cambiado correctamente...'
				SET @VP_MENSAJE='The [PASSWORD] was changed correctly...'
				SET @VP_K_CODIGO=0
			END		
		END
	END
	-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
		BEGIN
			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
		END

	SELECT	@VP_MENSAJE			AS MENSAJE,
			@VP_K_CODIGO		AS USUARIO_CODIGO
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / UPDATE THEME
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_THEME]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_THEME]
GO
-- EXECUTE [dbo].[PG_UP_THEME] 139,'Red Planet.isl'
CREATE PROCEDURE [dbo].[PG_UP_THEME]
	--@PP_K_SISTEMA_EXE				INT,
	--@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO					INT,
	@PP_THEME						VARCHAR(50)
AS
-- =========================================	
	DECLARE @VP_MENSAJE VARCHAR(500)
	UPDATE	USUARIO_PEARL
	SET		TEMA_USUARIO_PEARL	= @PP_THEME
	WHERE	K_USUARIO_PEARL		= @PP_K_USUARIO		
-- /////////////////////////////////////////////////////////////////////
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////