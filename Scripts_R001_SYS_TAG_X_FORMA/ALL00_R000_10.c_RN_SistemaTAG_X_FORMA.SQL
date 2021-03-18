-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		BD_GENERAL
-- // MODULE:			SISTEMA
-- // OPERATION:		REGLAS DE ACCIONES
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200615
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL] 
GO

-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_EXISTE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_SISTEMA_TAG_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_EXISTE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_SISTEMA_TAG			INT,
	-- ===========================		
	@OU_RESULTADO_VALIDACION	VARCHAR(300)	OUTPUT
AS
	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 	
	-- /////////////////////////////////////////////////////
	DECLARE @VP_K_SISTEMA_TAG		INT
	DECLARE @VP_L_BORRADO		INT
			
	SELECT	@VP_K_SISTEMA_TAG	=	K_SISTEMA_TAG,
			@VP_L_BORRADO		=	SISTEMA_TAG.L_BORRADO
									FROM	SISTEMA_TAG
									WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG
	-- ===========================
	IF @VP_RESULTADO=''
		IF ( @VP_K_SISTEMA_TAG IS NULL )
			SET @VP_RESULTADO =  'El registro para el [SISTEMA_TAG] no existe.' 
	-- ===========================
	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  'El [SISTEMA_TAG] fue dado de baja.' 		
	-- /////////////////////////////////////////////////////	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_CLAVE_EXISTE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_SISTEMA_TAG_CLAVE_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_CLAVE_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_CLAVE_EXISTE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_SISTEMA_TAG					INT,
	-- ===========================		
	@OU_RESULTADO_VALIDACION	VARCHAR(300)	OUTPUT
AS
	DECLARE @VP_RESULTADO		VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO='' 
		BEGIN
		DECLARE @VP_EXISTE_CLAVE	INT
		SELECT	@VP_EXISTE_CLAVE =	COUNT(K_SISTEMA_TAG)
									FROM	SISTEMA_TAG 
									WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG
										
		IF @VP_EXISTE_CLAVE>0
			SET @VP_RESULTADO =  'El folio/identificador no está disponible.' 
		END	
		
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_DESCRIPCION_EXISTE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_SISTEMA_TAG_DESCRIPCION_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_DESCRIPCION_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_DESCRIPCION_EXISTE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_SISTEMA_TAG			INT,	
	@PP_D_SISTEMA_TAG			VARCHAR (150),
	@PP_D_SISTEMA_TAG_MENU		VARCHAR (150),
	-- ===========================		
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS	
	DECLARE @VP_RESULTADO		VARCHAR(300)= ''		
	DECLARE @VP_EXISTE_DESC		INT
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO='' 
		BEGIN
			SELECT @VP_EXISTE_DESC =	COUNT(D_SISTEMA_TAG)
										FROM SISTEMA_TAG  
										WHERE D_SISTEMA_TAG =	@PP_D_SISTEMA_TAG
										AND K_SISTEMA_TAG <>@PP_K_SISTEMA_TAG
			IF @VP_EXISTE_DESC > 0
				SET	@VP_RESULTADO = @VP_RESULTADO	+ CHAR(13)+CHAR(10) + @PP_D_SISTEMA_TAG 
													+ ' ya existe.'
		END
	IF @VP_RESULTADO='' 
		BEGIN
			SELECT @VP_EXISTE_DESC =	COUNT(D_SISTEMA_TAG_MENU)
										FROM SISTEMA_TAG  
										WHERE D_SISTEMA_TAG_MENU =	@PP_D_SISTEMA_TAG_MENU
										AND K_SISTEMA_TAG <>@PP_K_SISTEMA_TAG
			IF @VP_EXISTE_DESC > 0
				SET	@VP_RESULTADO = @VP_RESULTADO	+ CHAR(13)+CHAR(10) + @PP_D_SISTEMA_TAG_MENU 
													+ ' ya existe en el Menú Explorer'
		END						
	-- ///////////////////////////////////////////	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DESC//'	
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO

-- ===========================================================================================
-- ===========================================================================================
-- == REGLAS DE NEGOCIO BASICAS (INSERT / UPDATE / DELETE)
-- ===========================================================================================
-- ===========================================================================================

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN // VALIDACION INSERT
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_SISTEMA_TAG_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_INSERT]
GO

CREATE PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_INSERT]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_SISTEMA_TAG			INT,
	@PP_D_SISTEMA_TAG			VARCHAR(150),
	@PP_D_SISTEMA_TAG_MENU		VARCHAR(150),
	-- ===========================		
	@OU_RESULTADO_VALIDACION	VARCHAR(300)	OUTPUT
AS
	DECLARE @VP_RESULTADO		VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	--IF @VP_RESULTADO=''
	--	EXECUTE [dbo].[PG_RN_DATA_ACCESO_INSERT]		--  @PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
	--													1, -- @PP_K_DATA_SISTEMA,	
	--													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////
	--IF @VP_RESULTADO=''
	--	EXECUTE [dbo].[PG_RN_SISTEMA_TAG_DESCRIPCION_EXISTE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--															@PP_K_SISTEMA_TAG, 
	--															@PP_D_SISTEMA_TAG, @PP_D_SISTEMA_TAG_MENU,
	--															@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //INS//'	
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN // VALIDACION UPDATE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_SISTEMA_TAG_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_UPDATE]
GO

CREATE PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_UPDATE]
	--  @PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================		
	@PP_K_SISTEMA_TAG				INT,
	@PP_D_SISTEMA_TAG				VARCHAR(150),	
	@PP_D_SISTEMA_TAG_MENU			VARCHAR(150),	
	-- ===========================		
	@OU_RESULTADO_VALIDACION		VARCHAR(300)	OUTPUT
AS
	DECLARE @VP_RESULTADO			VARCHAR(300) = ''	
	-- ///////////////////////////////////////////
	--IF @VP_RESULTADO=''
	--	EXECUTE [dbo].[PG_RN_DATA_ACCESO_UPDATE]		--  @PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
	--													11, -- @PP_K_DATA_SISTEMA,	
	--													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT		
	-- ///////////////////////////////////////////	
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_SISTEMA_TAG_EXISTE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_SISTEMA_TAG,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////
	--IF @VP_RESULTADO=''
	--	EXECUTE [dbo].[PG_RN_SISTEMA_TAG_DESCRIPCION_EXISTE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--															@PP_K_SISTEMA_TAG, 
	--															@PP_D_SISTEMA_TAG, @PP_D_SISTEMA_TAG_MENU,
	--															@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //UPD//'	
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN // VALIDACION DELETE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_SISTEMA_TAG_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_DELETE]
GO

CREATE PROCEDURE [dbo].[PG_RN_SISTEMA_TAG_DELETE]
	--  @PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================		
	@PP_K_SISTEMA_TAG						INT,
	-- ===========================		
	@OU_RESULTADO_VALIDACION		VARCHAR(300)	OUTPUT
AS
	DECLARE @VP_RESULTADO			VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	--IF @VP_RESULTADO=''
	--	EXECUTE [dbo].[PG_RN_DATA_ACCESO_DELETE]		--  @PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
	--													1, -- @PP_K_DATA_SISTEMA,	
	--													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_SISTEMA_TAG_EXISTE]				--  @PP_L_DEBUG, 
														@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_SISTEMA_TAG, 
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DEL//'	
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////