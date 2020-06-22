-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		BD_GENERAL
-- // MODULE:			SISTEMA
-- // OPERATION:		PROCEDIMIENTOS ESPECIFICOS
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200615
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- /// PARA LOS SP ALTA DE NUEVAS FORMAS EN LA BD PASAR A LA LINEA
-- /// 169 APROXIMADAMENTE. ( #ALTAFORMAS )
-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE USUARIO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_SISTEMA_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_SISTEMA_TAG]
GO

CREATE PROCEDURE [dbo].[PG_LI_SISTEMA_TAG]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL				INT,
	@PP_K_GRUPO_TAG					INT
AS
	-- =========================================
	SELECT DISTINCT		SISTEMA_TAG.K_GRUPO_TAG,
						SISTEMA_TAG.K_SISTEMA_TAG,
						D_SISTEMA_TAG,
						D_SISTEMA_TAG_MENU
	FROM				SISTEMA_TAG
	WHERE		SISTEMA_TAG.K_GRUPO_TAG=@PP_K_GRUPO_TAG
	AND			K_GRUPO_TAG<>0
	AND			K_SISTEMA_TAG<>0
	AND			L_SISTEMA_TAG=1
	AND			L_BORRADO=0
	ORDER BY	K_GRUPO_TAG,K_SISTEMA_TAG
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE MENU_EXPLORER
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_SISTEMA_TAG_MENU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_SISTEMA_TAG_MENU]
GO

-- EXECUTE [dbo].[PG_LI_SISTEMA_TAG_MENU] 0,139,139,60
-- EXECUTE [dbo].[PG_LI_SISTEMA_TAG_MENU] 0,139,139,20
CREATE PROCEDURE [dbo].[PG_LI_SISTEMA_TAG_MENU]
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
	FROM				SISTEMA_TAG
	WHERE		SISTEMA_TAG.K_GRUPO_TAG=@PP_K_GRUPO_TAG
	AND			K_GRUPO_TAG<>0
	AND			K_SISTEMA_TAG<>0
	AND			L_SISTEMA_TAG=1
	AND			L_BORRADO=0
	ORDER BY	K_GRUPO_TAG,K_SISTEMA_TAG
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE USUARIO
-- // SE UTILIZA EN LA FORMA DE MENU_EXPLORER
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_GRUPO_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_GRUPO_TAG]
GO

-- EXECUTE [dbo].[PG_LI_GRUPO_TAG] 0,139,139
CREATE PROCEDURE [dbo].[PG_LI_GRUPO_TAG]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_USUARIO_PEARL			INT
AS
	-- =========================================
	SELECT		GRUPO_TAG.K_GRUPO_TAG,
				D_GRUPO_TAG
	FROM		GRUPO_TAG 
	WHERE		K_GRUPO_TAG<>0
	AND			L_GRUPO_TAG=1
	AND			L_BORRADO=0
	ORDER BY	K_GRUPO_TAG
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE MENU_EXPLORER
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_SISTEMA_TAG_MENU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_SISTEMA_TAG_MENU]
GO
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,139,004,999
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,139,004,120
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,138,004,999
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,138,004,120
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,139,'PPMS #003',999
CREATE PROCEDURE [dbo].[PG_SK_SISTEMA_TAG_MENU]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_SISTEMA					VARCHAR(100),
	@PP_VERSION						INT
AS
	DECLARE @PP_K_SISTEMA	INT
	SET @PP_K_SISTEMA = RIGHT(@PP_D_SISTEMA,3)
	
	IF @PP_VERSION < 999
		BEGIN
			SELECT		SISTEMA_TAG.K_SISTEMA_TAG,
						D_SISTEMA_TAG	AS D_FORMA,
						R_SISTEMA_TAG	AS RUTA_FORMA,
						L_ARCHIVO_TAG	AS TIPO_FORMA 
			FROM		SISTEMA_TAG
			LEFT JOIN	USUARIO_PERMISOS	ON SISTEMA_TAG.K_SISTEMA_TAG=USUARIO_PERMISOS.K_SISTEMA_TAG
			LEFT JOIN	USUARIO_PEARL		ON USUARIO_PERMISOS.K_USUARIO_PEARL=USUARIO_PEARL.K_USUARIO_PEARL
			WHERE		SISTEMA_TAG.K_SISTEMA_TAG=@PP_K_SISTEMA
			AND			USUARIO_PEARL.K_USUARIO_PEARL=@PP_K_USUARIO_ACCION
			AND			L_SISTEMA_TAG<>0
			AND			SISTEMA_TAG.L_BORRADO=0
		END
	ELSE
		BEGIN
			SELECT		SISTEMA_TAG.K_SISTEMA_TAG,
						D_SISTEMA_TAG	AS D_FORMA,
						R_SISTEMA_TAG	AS RUTA_FORMA,
						L_ARCHIVO_TAG	AS TIPO_FORMA 
			FROM		SISTEMA_TAG
			WHERE		SISTEMA_TAG.K_SISTEMA_TAG=@PP_K_SISTEMA
			AND			L_SISTEMA_TAG<>0
			AND			SISTEMA_TAG.L_BORRADO=0
		END
	-- /////////////////////////////////////////////////////////////////////
GO
--SELECT LEFT('PPMS #001',LEN(D_SISTEMA_TAG)-3)
--SELECT LEN(D_SISTEMA_TAG) FROM SISTEMA_TAG
--SELECT RIGHT('PPMS #013',3)

-- //////////////////////////////////////////////////////////////
-- /// LOS SP DE LA PARTE ALTA CORRESPONDE A LOS PERMISOS DE 
-- /// USUARIOS, DE AQUI HACIA ABAJO SON DE LA FORMA DE SISTEMA
-- /// PARA DAR DE ALTA LAS NUEVAS FORMAS EN LA BD Y EN EL
-- /// MENÚ EXPLORER.	( #ALTAFORMAS )
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE SISTEMA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_SISTEMA]
GO

--	execute [dbo].[PG_LI_SISTEMA] 0,139,''
CREATE PROCEDURE [dbo].[PG_LI_SISTEMA]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ==============================================
	@PP_BUSCAR							VARCHAR(200)
	-- ==============================================
AS
	DECLARE @VP_MENSAJE					VARCHAR(300) = ''
	DECLARE @VP_L_APLICAR_MAX_ROWS		INT = 0
	-- ///////////////////////////////////////////
	SELECT	TOP (1000)
			-- =====================
			K_SISTEMA_TAG,
			D_SISTEMA_TAG_MENU,			D_SISTEMA_TAG,
			R_SISTEMA_TAG,				C_SISTEMA_TAG,
			S_GRUPO_TAG,				K_IMAGEN_SISTEMA_TAG,
			(	CASE
				WHEN	L_SISTEMA_TAG=0		THEN	'NO'
				WHEN	L_SISTEMA_TAG>=1	THEN	'SI'
			END ) AS L_SISTEMA_TAG
			-- =====================
	FROM	SISTEMA_TAG, GRUPO_TAG		
			-- =====================
	WHERE	SISTEMA_TAG.K_GRUPO_TAG=GRUPO_TAG.K_GRUPO_TAG
			-- =====================
	AND		( SISTEMA_TAG.L_BORRADO=0 )
			-- =====================		
	-- COMENTADO PARA PRUEBAS
	AND		( K_SISTEMA_TAG > 0 )
	ORDER BY GRUPO_TAG.K_GRUPO_TAG ASC,D_SISTEMA_TAG_MENU DESC
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_SISTEMA]
GO
-- EXECUTE [dbo].[PG_SK_SISTEMA] 0,139,21
-- EXECUTE [dbo].[PG_SK_SISTEMA] 0,139,69
CREATE PROCEDURE [dbo].[PG_SK_SISTEMA]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_SISTEMA						INT
AS
	-- =========================================
	SELECT	TOP (1)
			-- =====================
				K_SISTEMA_TAG,
				D_SISTEMA_TAG_MENU,			D_SISTEMA_TAG,
				R_SISTEMA_TAG,				C_SISTEMA_TAG,
				L_ARCHIVO_TAG,				L_SISTEMA_TAG,
				GRUPO_TAG.K_GRUPO_TAG,		S_GRUPO_TAG,
				K_IMAGEN_SISTEMA_TAG				
			-- =====================
	FROM		SISTEMA_TAG, GRUPO_TAG		
			-- =====================
	WHERE		SISTEMA_TAG.K_GRUPO_TAG=GRUPO_TAG.K_GRUPO_TAG
			-- =====================
	AND		( SISTEMA_TAG.L_BORRADO=0 )
			-- =====================
	AND		( K_SISTEMA_TAG > 0 )
	AND		K_SISTEMA_TAG=@PP_K_SISTEMA
	--ORDER BY GRUPO_TAG.K_GRUPO_TAG ASC,D_SISTEMA_TAG_MENU DESC
	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_SISTEMA]
GO

CREATE PROCEDURE [dbo].[PG_IN_SISTEMA]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_SISTEMA_TAG_MENU			VARCHAR(100),
	@PP_D_SISTEMA_TAG				VARCHAR(100),
	@PP_C_SISTEMA_TAG				VARCHAR(255),
	@PP_R_SISTEMA_TAG				VARCHAR(255),
	-- ===============================
	@PP_K_GRUPO_TAG					INT,
	@PP_L_ARCHIVO_TAG				INT,
	@PP_L_SISTEMA_TAG				INT,
	@PP_K_IMAGEN_SISTEMA_TAG		INT
AS			
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- /////////////////////////////////////////////////////////////////////	
	DECLARE @VP_K_SISTEMA		INT = 0	
	EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_K_SISTEMA_EXE, 'BD_GENERAL',
												'SISTEMA_TAG', 'K_SISTEMA_TAG',
												@OU_K_TABLA_DISPONIBLE = @VP_K_SISTEMA			OUTPUT
	-- ==================================
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_SISTEMA_TAG_INSERT]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@VP_K_SISTEMA,
													@PP_D_SISTEMA_TAG, @PP_D_SISTEMA_TAG_MENU,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT															
	-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		BEGIN
		DECLARE @VP_SIGLAS VARCHAR(10)
		SET @VP_SIGLAS = '#'+RIGHT('000' + Ltrim(Rtrim(@VP_K_SISTEMA)),3)
		INSERT INTO SISTEMA_TAG
			(	K_SISTEMA_TAG,			
				D_SISTEMA_TAG,			D_SISTEMA_TAG_MENU, 
				S_SISTEMA_TAG,			O_SISTEMA_TAG,
				C_SISTEMA_TAG,			R_SISTEMA_TAG,
				L_SISTEMA_TAG,			K_GRUPO_TAG	,
				L_ARCHIVO_TAG,			K_IMAGEN_SISTEMA_TAG,
				-- =============================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@VP_K_SISTEMA,		
				@PP_D_SISTEMA_TAG,		@PP_D_SISTEMA_TAG_MENU,	
				@VP_SIGLAS,				@VP_K_SISTEMA,
				@PP_C_SISTEMA_TAG,		@PP_R_SISTEMA_TAG,
				@PP_L_SISTEMA_TAG,		@PP_K_GRUPO_TAG	,
				@PP_L_ARCHIVO_TAG,		@PP_K_IMAGEN_SISTEMA_TAG,
				-- =============================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )
		END
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
		BEGIN		
		SET		@VP_MENSAJE = 'No es posible insertar el [SISTEMA]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIS.'+CONVERT(VARCHAR(10),@VP_K_SISTEMA)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_SISTEMA AS CLAVE	
	-- //////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'INSERT',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_IN_SISTEMA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@VP_K_SISTEMA, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													--0, 0, @PP_C_SISTEMA, '', 0.00, 0.00,
													0, 0, '', @VP_MENSAJE, 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '@VP_MENSAJE', '', ''
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_SISTEMA]
GO

CREATE PROCEDURE [dbo].[PG_UP_SISTEMA]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_K_SISTEMA_TAG				INT,
	@PP_D_SISTEMA_TAG_MENU			VARCHAR(100),
	@PP_D_SISTEMA_TAG				VARCHAR(100),
	@PP_C_SISTEMA_TAG				VARCHAR(255),
	@PP_R_SISTEMA_TAG				VARCHAR(255),
	-- ===============================
	@PP_K_GRUPO_TAG					INT,
	@PP_L_ARCHIVO_TAG				INT,
	@PP_L_SISTEMA_TAG				INT,
	@PP_K_IMAGEN_SISTEMA_TAG		INT
AS			
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_SISTEMA_TAG_UPDATE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_SISTEMA_TAG, 
													@PP_D_SISTEMA_TAG, @PP_D_SISTEMA_TAG_MENU,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE=''
		BEGIN
		UPDATE	SISTEMA_TAG
		SET		
				[D_SISTEMA_TAG]				= @PP_D_SISTEMA_TAG,
				[D_SISTEMA_TAG_MENU]		= @PP_D_SISTEMA_TAG_MENU,	
				[C_SISTEMA_TAG]				= @PP_C_SISTEMA_TAG,
				[R_SISTEMA_TAG]				= @PP_R_SISTEMA_TAG,
				[K_GRUPO_TAG]				= @PP_K_GRUPO_TAG,
				[L_ARCHIVO_TAG]				= @PP_L_ARCHIVO_TAG,
				[L_SISTEMA_TAG]				= @PP_L_SISTEMA_TAG,
				[K_IMAGEN_SISTEMA_TAG]		= @PP_K_IMAGEN_SISTEMA_TAG,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG
		END			
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
		BEGIN		
		SET		@VP_MENSAJE = 'No es posible actualizar el [SISTEMA]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIS.'+CONVERT(VARCHAR(10),@PP_K_SISTEMA_TAG)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'		
		END	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_SISTEMA_TAG AS CLAVE
	-- //////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
													@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'UPDATE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_UP_SISTEMA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_SISTEMA_TAG, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													--0, 0, @PP_C_SISTEMA, '', 0.00, 0.00,
													0, 0, '', @VP_MENSAJE, 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '@VP_MENSAJE', '', ''
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_SISTEMA]
GO

CREATE PROCEDURE [dbo].[PG_DL_SISTEMA]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_SISTEMA_TAG			INT
AS
	DECLARE @VP_MENSAJE		VARCHAR(300) = ''
	-- //////////////////////////////////////////////	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_SISTEMA_TAG_DELETE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_SISTEMA_TAG, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- //////////////////////////////////////////////	
	IF @VP_MENSAJE=''
		BEGIN
		UPDATE	SISTEMA_TAG
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG
		END
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
		BEGIN		
		SET		@VP_MENSAJE = 'No es posible borrar el [SISTEMA]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIS.'+CONVERT(VARCHAR(10),@PP_K_SISTEMA_TAG)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		END	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_SISTEMA_TAG AS CLAVE
	-- /////////////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
													@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'DELETE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_DL_SISTEMA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_SISTEMA_TAG, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''
	-- /////////////////////////////////////////////////////////////////////
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////