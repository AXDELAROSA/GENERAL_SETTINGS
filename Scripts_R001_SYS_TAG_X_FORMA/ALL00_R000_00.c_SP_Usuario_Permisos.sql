-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COMPRAS
-- // MODULE:			USUARIO_PEARL
-- // OPERATION:		SP'S
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200324
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_USUARIO_PEARL]
GO

-- EXECUTE [dbo].[PG_LI_USUARIO_PEARL] 0,139,''
CREATE PROCEDURE [dbo].[PG_LI_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_COMODIN						VARCHAR(10)
AS
--	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
--	DECLARE @VP_L_APLICAR_MAX_ROWS	INT=1		
	-- ///////////////////////////////////////////
	--DECLARE @VP_LI_N_REGISTROS	INT=5000
	-- =========================================	
--	
--	DECLARE @VP_K_FOLIO				INT
--
--	EXECUTE [BD_GENERAL].DBO.[PG_RN_OBTENER_ID_X_REFERENCIA]			
--											@PP_BUSCAR,	@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
	-- =========================================
		
--	IF @VP_MENSAJE<>''
	SELECT	TOP (5000)
			K_USUARIO_PEARL AS K_CODIGO,
			EN_NUM_EMP AS K_EMPLEADO,
			EP_APELLIDO_PATERNO AS APELLIDO_PATERNO,
			EP_APELLIDO_MATERNO AS APELLIDO_MATERNO,
			EP_NOMBRE AS NOMBRE,
			D_USUARIO_PEARL AS USUARIO,
			--CORREO_USUARIO_PEARL AS CORREO,
			(	CASE 
					WHEN CHARINDEX('@',CORREO_USUARIO_PEARL)<>1 THEN SUBSTRING( CORREO_USUARIO_PEARL,1,(CHARINDEX('@',CORREO_USUARIO_PEARL))-1)
					WHEN CHARINDEX('@',CORREO_USUARIO_PEARL)=1  THEN 'SIN CORREO'	
				END	) AS CORREO,
			(	CASE 
					WHEN CHARINDEX('@',CORREO_USUARIO_PEARL)<>1 THEN 1
					WHEN CHARINDEX('@',CORREO_USUARIO_PEARL)=1  THEN 0
				END	) AS L_CORREO,
			K_USUARIO_TIPO AS K_USUARIO_TIPO,
			PASSWORD_USUARIO_PEARL AS [PASSWORD],
			TEMA_USUARIO_PEARL AS TEMA
	FROM    USUARIO_PEARL
	INNER JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL
	WHERE	L_BORRADO<>1
	ORDER BY EP_APELLIDO_PATERNO ASC
	-- /////////////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USUARIO_PEARL]
GO

-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL] 0,139,139
CREATE PROCEDURE [dbo].[PG_SK_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_CODIGO					VARCHAR(10)
AS
--	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
--	DECLARE @VP_L_APLICAR_MAX_ROWS	INT=1		
	-- ///////////////////////////////////////////
	--DECLARE @VP_LI_N_REGISTROS	INT=5000
	-- =========================================	
--	

--	IF @VP_MENSAJE<>''
	SELECT	TOP (1)
			K_USUARIO_PEARL AS K_CODIGO,
			EN_NUM_EMP AS K_EMPLEADO,
			EP_APELLIDO_PATERNO AS APELLIDO_PATERNO,
			EP_APELLIDO_MATERNO AS APELLIDO_MATERNO,
			EP_NOMBRE AS NOMBRE,
			D_USUARIO_PEARL AS USUARIO,
			--CORREO_USUARIO_PEARL AS CORREO,
			(	CASE 
					WHEN CHARINDEX('@',CORREO_USUARIO_PEARL)<>1 THEN SUBSTRING( CORREO_USUARIO_PEARL,1,(CHARINDEX('@',CORREO_USUARIO_PEARL))-1)
					WHEN CHARINDEX('@',CORREO_USUARIO_PEARL)=1  THEN 'SIN CORREO'	
				END	) AS CORREO,
			(	CASE 
					WHEN CHARINDEX('@',CORREO_USUARIO_PEARL)<>1 THEN 1
					WHEN CHARINDEX('@',CORREO_USUARIO_PEARL)=1  THEN 0
				END	) AS L_CORREO,
			K_USUARIO_TIPO AS K_USUARIO_TIPO,
			PASSWORD_USUARIO_PEARL AS [PASSWORD],
			TEMA_USUARIO_PEARL AS TEMA
	FROM    USUARIO_PEARL
	INNER JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL
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
	@PP_EXISTE					INT				OUTPUT
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
		OR	@PP_D_USUARIO LIKE ('%KOJO%') OR	@PP_D_USUARIO LIKE ('%KAKA%') OR	@PP_D_USUARIO LIKE ('%KULO%')  
		OR	@PP_D_USUARIO LIKE ('%MAME%') OR	@PP_D_USUARIO LIKE ('%MAMO%') OR	@PP_D_USUARIO LIKE ('%MEAR%')  
		OR	@PP_D_USUARIO LIKE ('%MEAS%') OR	@PP_D_USUARIO LIKE ('%MEON%') OR	@PP_D_USUARIO LIKE ('%MIAR%')  
		OR	@PP_D_USUARIO LIKE ('%MION%') OR	@PP_D_USUARIO LIKE ('%MOCO%') OR	@PP_D_USUARIO LIKE ('%MULA%')  
		OR	@PP_D_USUARIO LIKE ('%NACA%') OR	@PP_D_USUARIO LIKE ('%NACO%') OR	@PP_D_USUARIO LIKE ('%PEDA%')  
		OR	@PP_D_USUARIO LIKE ('%PEDO%') OR	@PP_D_USUARIO LIKE ('%PENE%') OR	@PP_D_USUARIO LIKE ('%PITO%')  
		OR	@PP_D_USUARIO LIKE ('%PUTA%')  
		OR	@PP_D_USUARIO LIKE ('%PUTO%') OR	@PP_D_USUARIO LIKE ('%QULO%') OR	@PP_D_USUARIO LIKE ('%RATA%')  
		OR	@PP_D_USUARIO LIKE ('%RUIN%') OR	@PP_D_USUARIO LIKE ('%SEXO%')
					BEGIN
						SET @PP_EXISTE= 1
					END
				ELSE
					BEGIN
						SET @PP_EXISTE= 0
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
DECLARE @VP_CU_D_USUARIO_FINAL NVARCHAR(MAX)='',	@VP_EXISTE	INT=1,	@VP_INCONVENIENTE	INT=1
		
	CREATE TABLE #Tablausuario ( D_USUARIO VARCHAR(250) )

	SELECT	TOP  (1)
		--==========================================
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
	FROM    USUARIO_PEARL
	INNER JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL
	WHERE	K_EMPLEADO_PEARL=@PP_K_EMPLEADO_PEARL		--12602

	IF @@ROWCOUNT<>0 
	BEGIN
	
	IF NOT(@VP_D_USUARIO_1 IS NULL)
	BEGIN
		INSERT INTO		#TABLAUSUARIO (	D_USUARIO )
		VALUES	(	@VP_D_USUARIO_1 + @VP_S_APELLIDO_P	),
				(	@VP_D_USUARIO_1 + @VP_S_APELLIDO_M	)
	END
	ELSE
	BEGIN
		INSERT INTO		#TABLAUSUARIO (	D_USUARIO )
		VALUES	(	@VP_D_USUARIO_2 + @VP_S_APELLIDO_P	),		(	@VP_D_USUARIO_3 + @VP_S_APELLIDO_P	),
				(	@VP_D_USUARIO_4 + @VP_S_APELLIDO_P	),		(	@VP_D_USUARIO_5 + @VP_S_APELLIDO_P	),
				(	@VP_D_USUARIO_2 + @VP_S_APELLIDO_M	),		(	@VP_D_USUARIO_3 + @VP_S_APELLIDO_M	),		
				(	@VP_D_USUARIO_4 + @VP_S_APELLIDO_M	),		(	@VP_D_USUARIO_5 + @VP_S_APELLIDO_M	)
	END
				
		DECLARE Employee_Cursor CURSOR FOR  
		SELECT * FROM #TABLAUSUARIO
		OPEN Employee_Cursor;  
		FETCH NEXT FROM Employee_Cursor INTO	@VP_CU_D_USUARIO_FINAL				
		WHILE @@FETCH_STATUS = 0
		   BEGIN  
		   IF NOT(@VP_CU_D_USUARIO_FINAL IS NULL)
		   BEGIN
				EXECUTE	[dbo].[PG_SK_USUARIO_INCONVENIENTE]	@PP_K_SISTEMA_EXE , @PP_K_USUARIO_ACCION,
															-- ===========================
															@PP_D_USUARIO,	@VP_EXISTE			OUTPUT

					IF(SELECT	COUNT(D_USUARIO_PEARL)	
								FROM BD_GENERAL.dbo.USUARIO_PEARL
								WHERE	LTRIM(RTRIM(UPPER(@VP_CU_D_USUARIO_FINAL)))=LTRIM(RTRIM(UPPER(D_USUARIO_PEARL))))>0
						BEGIN
							SET @VP_EXISTE=1
						END
					ELSE
						BEGIN
							SET @VP_EXISTE=0
						END
			
				IF (@VP_INCONVENIENTE=0 AND @VP_EXISTE=0)
				BEGIN
					BREAK
				END
			END
			  FETCH NEXT FROM Employee_Cursor INTO	@VP_CU_D_USUARIO_FINAL
		   END
		CLOSE Employee_Cursor
		DEALLOCATE Employee_Cursor
	END
	ELSE
	BEGIN
	SET @VP_CU_D_USUARIO_FINAL='ASIGNAR_MANUALMENTE'
	END
	
	IF @VP_EXISTE <> 0	OR	@VP_INCONVENIENTE <> 0	OR @VP_CU_D_USUARIO_FINAL='' OR @VP_CU_D_USUARIO_FINAL IS NULL
	BEGIN
		SET @VP_CU_D_USUARIO_FINAL='ASIGNAR_MANUALMENTE'
	END
	
	--SELECT @VP_CU_D_USUARIO_FINAL
	SET @PP_D_USUARIO = @VP_CU_D_USUARIO_FINAL
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USUARIO_PEARL_NUEVO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USUARIO_PEARL_NUEVO]
GO

-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,99999
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,12424
-- EXECUTE [dbo].[PG_SK_USUARIO_PEARL_NUEVO] 0,139,12602
-- 
CREATE PROCEDURE [dbo].[PG_SK_USUARIO_PEARL_NUEVO]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_EMPLEADO_PEARL			INT
AS
DECLARE @VP_D_USUARIO		NVARCHAR(MAX)
DECLARE @VP_MENSAJE			NVARCHAR(MAX) = ''	, @VP_L_EXISTE		INT
--BEGIN TRY
	EXECUTE [DBO].[PG_RN_USUARIO_PEARL_EXISTS]	@PP_K_SISTEMA_EXE , @PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_EMPLEADO_PEARL, 
												@VP_MENSAJE			OUTPUT,
												@VP_L_EXISTE		OUTPUT
--IF ( SELECT	COUNT(K_USUARIO_PEARL) 
--	FROM	USUARIO_PEARL 
--	WHERE	K_EMPLEADO_PEARL = @PP_K_EMPLEADO_PEARL 
--	AND		L_USUARIO_PEARL = 1 ) > 0 
--BEGIN
--SET @VP_MENSAJE=''
--END
	IF @VP_MENSAJE=''
	BEGIN
		EXECUTE [dbo].[PG_ASIGNAR_D_USUARIO]	@PP_K_SISTEMA_EXE , @PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_EMPLEADO_PEARL,	@VP_D_USUARIO OUTPUT
													
		-- ///////////////////////////////////////////
			SELECT	TOP  (1)
--				K_USUARIO_PEARL AS CODIGO,
				EN_NUM_EMP AS EMPLEADO,
				D_USUARIO_PEARL AS USUARIO,
				EP_NOMBRE AS NOMBRE,
				EP_APELLIDO_PATERNO AS APELLIDO_PATERNO,
				EP_APELLIDO_MATERNO AS APELLIDO_MATERNO,
				--==========================================
			--	(	CASE WHEN	@VP_D_USUARIO = 'ASIGNAR_MANUALMENTE'	THEN '@PEARLLEATHER.COM.MX' 
			--		ELSE		@VP_D_USUARIO+'@PEARLLEATHER.COM.MX'	END)	AS CORREO,
			--	@VP_D_USUARIO AS USUARIO,
				--==========================================
				--USUARIO_TIPO AS TIPO,
				'Password1' AS [PASSWORD],
				--PASSWORD_USUARIO_PEARL AS [PASSWORD],
				TEMA_USUARIO_PEARL AS TEMA,
				'' AS MENSAJE
			FROM    USUARIO_PEARL
			INNER JOIN HOWE.DBO.VISTA_GAFETES ON EN_NUM_EMP=K_EMPLEADO_PEARL
			WHERE	K_EMPLEADO_PEARL=@PP_K_EMPLEADO_PEARL
			ORDER BY EP_APELLIDO_PATERNO ASC
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

-- EXECUTE [dbo].[PG_IN_USUARIO_PEARL] 0, 139,												

CREATE PROCEDURE [dbo].[PG_IN_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_USUARIO						VARCHAR(50),
	@PP_PASSWORD					VARCHAR(10),
	-- ===========================
	@PP_L_CORREO					INT,
	@PP_CORREO						VARCHAR(50),
	-- ===========================
	@PP_K_USUARIO_TIPO				INT
AS			

DECLARE @VP_MENSAJE				VARCHAR(500) = ''
DECLARE @VP_K_USUARIO_PEARL			INT = 0;	
--DECLARE @VP_K_ADDRESS_USUARIO_PEARL	INT = 0;	
--DECLARE @VP_K_CONTACT_USUARIO_PEARL	INT = 0
	
BEGIN TRANSACTION 
BEGIN TRY
-- /////////////////////////////////////////////////////////////////////

		EXECUTE [BD_GENERAL].dbo.[PG_SK_CATALOGO_K_MAX_GET]		@PP_K_SISTEMA_EXE, 'BD_GENERAL',
																'USUARIO_PEARL', 'K_USUARIO_PEARL',
																@OU_K_TABLA_DISPONIBLE = @VP_K_USUARIO_PEARL	OUTPUT
	-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_CLAVE_EXISTE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@VP_K_USUARIO_PEARL, 
																@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_UNIQUE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@VP_K_USUARIO_PEARL, @PP_USUARIO, @PP_CORREO,
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	
	-- //////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
	BEGIN		
	--============================================================================
	--======================================INSERTAR EL USUARIO_PEARL
	--============================================================================
		INSERT INTO USUARIO_PEARL
			(	[K_USUARIO_PEARL]			,
				-- =========================
				[D_USUARIO_PEARL]			,
				-- =========================
				[PASSWORD_USUARIO_PEARL]	,		[CORREO_USUARIO_PEARL]		,
				[K_USUARIO_DEPARTAMENTO]	,		[K_USUARIO_TIPO]			,
				-- =========================
				[K_EMPLEADO_PEARL]			,		
				-- =========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_USUARIO_PEARL, 
				@PP_USUARIO						,
				@PP_PASSWORD					,
				-- ===========================
				@PP_L_CORREO					,
				@PP_CORREO						,
				-- ===========================
				@PP_K_USUARIO_TIPO				,
				-- ============================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

			IF @@ROWCOUNT = 0
				BEGIN
					--DECLARE @VP_ERROR_1 VARCHAR(250)='THE USUARIO_PEARL WAS NOT INSERTED. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@VP_K_USUARIO_PEARL)+']'
					--RAISERROR (@VP_ERROR_1, 16, 1 ) --MENSAJE - Severity -State.
					SET @VP_MENSAJE='The USUARIO_PEARL was not inserted. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@VP_K_USUARIO_PEARL)+']'
				END
		
--		RAISERROR ('ERROR DE PRUEBAS', 16, 1 ) --MENSAJE - Severity -State.
		IF @VP_MENSAJE=''
		BEGIN
		--============================================================================
		--======================================INSERTAR EL ADDRESS_USUARIO_PEARL
		--============================================================================
		INSERT INTO ADDRESS_USUARIO_PEARL
			(	[K_USUARIO_PEARL]			,
				[K_ADDRESS_USUARIO_PEARL]	,			
				[D_ADDRESS_USUARIO_PEARL_1],	[D_ADDRESS_USUARIO_PEARL_2]	,			
				[C_ADDRESS_USUARIO_PEARL]	,	[O_ADDRESS_USUARIO_PEARL]		,
				-- =======================
				[CITY]				,	[STATE_GEO]	,
				[POSTAL_CODE]		,
				[NUMBER_EXTERIOR]	,	[NUMBER_INSIDE]		,
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_USUARIO_PEARL			,
				@VP_K_ADDRESS_USUARIO_PEARL	,
				@PP_D_ADDRESS_USUARIO_PEARL_1	,	@PP_D_ADDRESS_USUARIO_PEARL_2	,		
				@PP_D_USUARIO_PEARL	,	10	,			
				-- ============================
				@PP_CITY			,		@PP_STATE_GEO		,
				@PP_POSTAL_CODE		,			
				@PP_NUMBER_EXTERIOR	,		@PP_NUMBER_INSIDE	,			
				-- ============================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
			IF @@ROWCOUNT = 0
				BEGIN
				DECLARE @VP_ERROR_1 VARCHAR(250)='The addres was not inserted.[USUARIO_PEARL#'+CONVERT(VARCHAR(10),@VP_K_USUARIO_PEARL)+' //ADDRESS#'+CONVERT(VARCHAR(10),@VP_K_ADDRESS_USUARIO_PEARL)+']'
					RAISERROR (@VP_ERROR_1, 16, 1 ) --MENSAJE - Severity -State.
				--	SET @VP_MENSAJE='The USUARIO_PEARL was not inserted. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@VP_K_USUARIO_PEARL)+']'
				END
		END

--		RAISERROR ('ERROR DE PRUEBAS 2', 16, 1 ) --MENSAJE - Severity -State.
		IF @VP_MENSAJE=''
		BEGIN
		--============================================================================
		--======================================INSERTAR EL CONTACT_USUARIO_PEARL
		--============================================================================
		INSERT INTO CONTACT_USUARIO_PEARL
			(	[K_USUARIO_PEARL]			,
				[K_CONTACT_USUARIO_PEARL]	,	[1_FIRST_NAME]		,
				[1_MIDDLE_NAME]		,	[2_FIRST_NAME]		,
				[2_MIDDLE_NAME]		,	[C_CONTACT_USUARIO_PEARL]	,
				-- ===========================
--				[1_EMAIL]			,	[1_PHONE]			,
--				[2_EMAIL]			,	[2_PHONE]			,
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_USUARIO_PEARL		,
				@VP_K_CONTACT_USUARIO_PEARL,	@PP_1_FIRST_NAME		,		
				@PP_1_MIDDLE_NAME	,	@PP_2_FIRST_NAME		,		
				@PP_2_MIDDLE_NAME	,	@PP_D_USUARIO_PEARL	,
				-- ============================	
--				@PP_1_EMAIL			,	@PP_1_PHONE				,	
--				@PP_2_EMAIL			,	@PP_2_PHONE				,	
				-- ============================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
			IF @@ROWCOUNT = 0
				BEGIN
				DECLARE @VP_ERROR_2 VARCHAR(250)='The contact was not inserted.[USUARIO_PEARL#'+CONVERT(VARCHAR(10),@VP_K_USUARIO_PEARL)+' //CONTACT#'+CONVERT(VARCHAR(10),@VP_K_CONTACT_USUARIO_PEARL)+']'
					RAISERROR (@VP_ERROR_2, 16, 1 ) --MENSAJE - Severity -State.
				--	SET @VP_MENSAJE='The USUARIO_PEARL was not inserted. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@VP_K_USUARIO_PEARL)+']'
				END
		END							
--	RAISERROR ('ERROR DE PRUEBAS 3', 16, 1 ) --MENSAJE - Severity -State.
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
		SET		@VP_MENSAJE = 'Not is possible [Insert] at [USUARIO_PEARL]: ' + @VP_MENSAJE 
	END

	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_USUARIO_PEARL AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////
-- EXECUTE [dbo].[PG_UP_USUARIO_PEARL] 0, 139,												
--				379,												
--				'TEST USUARIO_PEARL 3' , '' , 
--				'TEST200220IT' , 'TEST200201IT@TEST.USUARIO_PEARL' , '6660000000' , 30 , 
--				1,0,
--				1,
--				'CALLE USUARIO_PEARL' , 'COLONIA USUARIO_PEARL' , 'COMMENTS' , 
--				'CIUDAD USUARIO_PEARL', 'ESTADO USUARIO_PEARL' , '32000' , '123' , '-A',
--				1, 
--				'NOMBRE 1' , 'APELLIDO 1' , '' , '' , '' , 
--				'' , '' ,'' ,''			
/*											
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_USUARIO_PEARL]
GO

CREATE PROCEDURE [dbo].[PG_UP_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL					INT,
	@PP_D_USUARIO_PEARL					VARCHAR(250),
	@PP_C_USUARIO_PEARL					VARCHAR(255),
	-- ===========================
	@PP_RFC_USUARIO_PEARL					VARCHAR(13),
	@PP_EMAIL						VARCHAR(100),
	@PP_PHONE						VARCHAR(100),
	@PP_N_CREDIT_DAYS				INT,
	-- ===========================
	@PP_K_STATUS_USUARIO_PEARL				INT,
	@PP_K_CATEGORY_USUARIO_PEARL			INT,
	-- ============================-- ============================
	@PP_K_ADDRESS_USUARIO_PEARL			INT,
	@PP_D_ADDRESS_USUARIO_PEARL_1			VARCHAR (255) ,	-- STREET
	@PP_D_ADDRESS_USUARIO_PEARL_2			VARCHAR (255) ,	-- COLONY, FRACC, 
	-- ============================
	@PP_CITY						VARCHAR (100) ,
	@PP_STATE_GEO					VARCHAR (100),
	@PP_POSTAL_CODE					VARCHAR (10),
	@PP_NUMBER_EXTERIOR				VARCHAR (10),
	@PP_NUMBER_INSIDE				VARCHAR (10),
	-- ============================-- ============================
	@PP_K_CONTACT_USUARIO_PEARL			INT,
	@PP_1_FIRST_NAME				VARCHAR(255),
	@PP_1_MIDDLE_NAME				VARCHAR(255),
	@PP_2_FIRST_NAME				VARCHAR(255),
	@PP_2_MIDDLE_NAME				VARCHAR(255)
	-- ============================				
--	,@PP_1_EMAIL						VARCHAR(100),
--	@PP_1_PHONE						VARCHAR(25)	,
--	@PP_2_EMAIL						VARCHAR(100),
--	@PP_2_PHONE						VARCHAR(25)	
AS			
DECLARE @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_UPDATE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_USUARIO_PEARL, 
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_UNIQUE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_USUARIO_PEARL,@PP_D_USUARIO_PEARL, @PP_RFC_USUARIO_PEARL,
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
	BEGIN
		UPDATE	USUARIO_PEARL
		SET		
				[D_USUARIO_PEARL]						= @PP_D_USUARIO_PEARL,
				[C_USUARIO_PEARL]						= @PP_C_USUARIO_PEARL,
				-- ========================== -- ===========================
				[BUSINESS_NAME]					= @PP_D_USUARIO_PEARL,				--@PP_BUSINESS_NAME,
				[RFC_USUARIO_PEARL]					= @PP_RFC_USUARIO_PEARL,
				[EMAIL]							= @PP_EMAIL,
				[PHONE]							= @PP_PHONE,
				[N_CREDIT_DAYS]					= @PP_N_CREDIT_DAYS,
				-- ========================== -- ===========================
				[K_STATUS_USUARIO_PEARL]				= @PP_K_STATUS_USUARIO_PEARL,
				[K_CATEGORY_USUARIO_PEARL]				= @PP_K_CATEGORY_USUARIO_PEARL,		
				-- ========================== -- ============================
				[F_CAMBIO]						= GETDATE(), 
				[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
		WHERE	[K_USUARIO_PEARL]=@PP_K_USUARIO_PEARL
		IF @@ROWCOUNT = 0
			BEGIN
				SET @VP_MENSAJE='The USUARIO_PEARL was not updated. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+']'
			END
		
		IF @VP_MENSAJE=''
		BEGIN
			UPDATE	ADDRESS_USUARIO_PEARL
			SET
					[D_ADDRESS_USUARIO_PEARL_1]		= @PP_D_ADDRESS_USUARIO_PEARL_1	,	
					[D_ADDRESS_USUARIO_PEARL_2]		= @PP_D_ADDRESS_USUARIO_PEARL_2	,		
					[C_ADDRESS_USUARIO_PEARL]			= @PP_D_USUARIO_PEARL				,	
					-- =======================	= -- =========================
					[CITY]						= @PP_CITY			,		
					[STATE_GEO]					= @PP_STATE_GEO		,
					[POSTAL_CODE]				= @PP_POSTAL_CODE		,		
					[NUMBER_EXTERIOR]			= @PP_NUMBER_EXTERIOR	,		
					[NUMBER_INSIDE]				= @PP_NUMBER_INSIDE	,		
					-- ========================== -- ============================
					[F_CAMBIO]					= GETDATE(), 
					[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION
			WHERE	[K_ADDRESS_USUARIO_PEARL]=@PP_K_ADDRESS_USUARIO_PEARL			
			AND		[K_USUARIO_PEARL]=@PP_K_USUARIO_PEARL
			IF @@ROWCOUNT = 0
				BEGIN
				DECLARE @VP_ERROR_1 VARCHAR(250)='The address was not updated.[USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+' //ADDRESS#'+CONVERT(VARCHAR(10),@PP_K_ADDRESS_USUARIO_PEARL)+']'
					RAISERROR (@VP_ERROR_1, 16, 1 ) --MENSAJE - Severity -State.
				END
		END

		IF @VP_MENSAJE=''
		BEGIN
			UPDATE	CONTACT_USUARIO_PEARL
			SET													
					[1_FIRST_NAME]					= @PP_1_FIRST_NAME		,
					[1_MIDDLE_NAME]					= @PP_1_MIDDLE_NAME		,		
					[2_FIRST_NAME]					= @PP_2_FIRST_NAME		,		
					[2_MIDDLE_NAME]					= @PP_2_MIDDLE_NAME		,		
					[C_CONTACT_USUARIO_PEARL]				= @PP_D_USUARIO_PEARL			,		
					-- ========================== -- ============================
--					[1_EMAIL]						= @PP_1_EMAIL			,			
--					[1_PHONE]						= @PP_1_PHONE			,			
--					[2_EMAIL]						= @PP_2_EMAIL			,			
--					[2_PHONE]						= @PP_2_PHONE			,		
					-- ========================== -- ============================
					[F_CAMBIO]						= GETDATE()				, 
					[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
			WHERE	[K_CONTACT_USUARIO_PEARL]=@PP_K_CONTACT_USUARIO_PEARL			
			AND		[K_USUARIO_PEARL]=@PP_K_USUARIO_PEARL
			IF @@ROWCOUNT = 0
				BEGIN
				DECLARE @VP_ERROR_2 VARCHAR(250)='The contact was not updated.[USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+' //CONTACT# '+CONVERT(VARCHAR(10),@PP_K_CONTACT_USUARIO_PEARL)+']'
					RAISERROR (@VP_ERROR_2, 16, 1 ) --MENSAJE - Severity -State.
				END
		END	
	END
--	RAISERROR ('ERROR DE PRUEBAS 3', 16, 1 ) --MENSAJE - Severity -State.
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
		SET		@VP_MENSAJE = 'Not is possible [Update] at [USUARIO_PEARL]: ' + @VP_MENSAJE 
	END

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_USUARIO_PEARL AS CLAVE
	-- //////////////////////////////////////////////////////////////
	
GO
*/

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
/*
--	EXECUTE [dbo].[PG_DL_USUARIO_PEARL] 0,139,380,2,2
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_USUARIO_PEARL]
GO

CREATE PROCEDURE [dbo].[PG_DL_USUARIO_PEARL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL					INT
AS
DECLARE @VP_MENSAJE				VARCHAR(300) = ''
DECLARE @PP_K_ADDRESS_USUARIO_PEARL			INT
DECLARE @PP_K_CONTACT_USUARIO_PEARL			INT
BEGIN TRANSACTION 
BEGIN TRY
--/////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_DELETE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_USUARIO_PEARL, 
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	--////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
	
	SELECT	@PP_K_ADDRESS_USUARIO_PEARL=K_ADDRESS_USUARIO_PEARL,
			@PP_K_CONTACT_USUARIO_PEARL=K_CONTACT_USUARIO_PEARL
	FROM	USUARIO_PEARL
	LEFT JOIN ADDRESS_USUARIO_PEARL ON USUARIO_PEARL.K_USUARIO_PEARL= ADDRESS_USUARIO_PEARL.K_USUARIO_PEARL
	LEFT JOIN CONTACT_USUARIO_PEARL ON USUARIO_PEARL.K_USUARIO_PEARL= CONTACT_USUARIO_PEARL.K_USUARIO_PEARL
	WHERE USUARIO_PEARL.K_USUARIO_PEARL=@PP_K_USUARIO_PEARL
	
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
				SET @VP_MENSAJE='The USUARIO_PEARL was not updated. [USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+']'
			END
		IF @VP_MENSAJE=''
		BEGIN		
			UPDATE	ADDRESS_USUARIO_PEARL
			SET		
					[L_BORRADO]				= 1,
					-- ====================
					[F_BAJA]				= GETDATE(), 
					[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
			WHERE	K_ADDRESS_USUARIO_PEARL=@PP_K_ADDRESS_USUARIO_PEARL
			IF @@ROWCOUNT = 0
				BEGIN
				DECLARE @VP_ERROR_1 VARCHAR(250)='The address was not deleted.[USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+' //ADDRESS#'+CONVERT(VARCHAR(10),@PP_K_ADDRESS_USUARIO_PEARL)+']'
					RAISERROR (@VP_ERROR_1, 16, 1 ) --MENSAJE - Severity -State.
				END
		END

		IF @VP_MENSAJE=''
		BEGIN		
			UPDATE	CONTACT_USUARIO_PEARL
			SET		
					[L_BORRADO]				= 1,
					-- ====================
					[F_BAJA]				= GETDATE(), 
					[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
			WHERE	K_CONTACT_USUARIO_PEARL=@PP_K_CONTACT_USUARIO_PEARL		
			IF @@ROWCOUNT = 0
				BEGIN
				DECLARE @VP_ERROR_2 VARCHAR(250)='The contact was not updated.[USUARIO_PEARL#'+CONVERT(VARCHAR(10),@PP_K_USUARIO_PEARL)+' //CONTACT#'+CONVERT(VARCHAR(10),@PP_K_CONTACT_USUARIO_PEARL)+']'
					RAISERROR (@VP_ERROR_2, 16, 1 ) --MENSAJE - Severity -State.
				END
		END	
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
		SET		@VP_MENSAJE = 'Not is possible [Update] at [USUARIO_PEARL]: ' + @VP_MENSAJE 
	END

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_USUARIO_PEARL AS CLAVE
	-- //////////////////////////////////////////////////////////////
	
	-- //////////////////////////////////////////////////////////////	
GO

*/
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
