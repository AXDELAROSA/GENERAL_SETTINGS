-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COMPRAS
-- // MODULE:			USUARIO_PEARL
-- // OPERATION:		REGLAS DE NEGOCIO
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200327
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_UNIQUE
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_USUARIO_PEARL_UNIQUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_UNIQUE]
GO


CREATE PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_UNIQUE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_USUARIO_PEARL					[INT],	
	@PP_D_USUARIO_PEARL					[VARCHAR] (250),
	@PP_CORREO_USUARIO_PEARL			[VARCHAR] (25),
		-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (500)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(500) = ''
		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
	BEGIN	
		DECLARE @VP_N_USUARIO_PEARL_X_D_USUARIO_PEARL			INT
		
		SELECT	@VP_N_USUARIO_PEARL_X_D_USUARIO_PEARL =		COUNT	(USUARIO_PEARL.K_USUARIO_PEARL)
												FROM	USUARIO_PEARL
												WHERE	USUARIO_PEARL.K_USUARIO_PEARL<>@PP_K_USUARIO_PEARL
												AND		USUARIO_PEARL.D_USUARIO_PEARL=@PP_D_USUARIO_PEARL										
		-- =============================
			IF @VP_N_USUARIO_PEARL_X_D_USUARIO_PEARL>0
			BEGIN
				--SET @VP_RESULTADO =  'There are already [USUARIO_PEARLS] with that Description ['+@PP_D_USUARIO_PEARL+'].'
				SET @VP_RESULTADO =  'Ya existen [USUARIOS_PEARLS] con el Nombre de Usuario ['+@PP_D_USUARIO_PEARL+'].'
			END
	END			

	-- ///////////////////////////////////////////
	--IF @VP_RESULTADO=''
	--BEGIN	
	--	DECLARE @VP_N_USUARIO_PEARL_X_CORREO_USUARIO_PEARL		INT = 0

	--	IF @PP_CORREO_USUARIO_PEARL=''			-- SOLAMENTE APLICA LA VALIDACION CUANDO EL CORREO_USUARIO_PEARL NO VIENE VACIO
	--	BEGIN 
	--		SET		@VP_N_USUARIO_PEARL_X_CORREO_USUARIO_PEARL =		0
	--	END
	--END
	--ELSE
	--BEGIN
	--		SELECT	@VP_N_USUARIO_PEARL_X_CORREO_USUARIO_PEARL =		COUNT	(USUARIO_PEARL.K_USUARIO_PEARL)
	--											FROM	USUARIO_PEARL
	--											WHERE	USUARIO_PEARL.K_USUARIO_PEARL<>@PP_K_USUARIO_PEARL
	--											AND		USUARIO_PEARL.CORREO_USUARIO_PEARL=@PP_CORREO_USUARIO_PEARL	
	--											AND		@PP_CORREO_USUARIO_PEARL<>''			
		
	--		IF @VP_N_USUARIO_PEARL_X_CORREO_USUARIO_PEARL>0
	--		BEGIN
	--			--SET @VP_RESULTADO =  'There are already [USUARIO_PEARLS] with that RFC ['+@PP_CORREO_USUARIO_PEARL+'].' 
	--			SET @VP_RESULTADO =  'Ya existen [USUARIOS_PEARLS] con el E-Mail ['+@PP_CORREO_USUARIO_PEARL+'].' 
	--		END
	--END		
	-- ///////////////////////////////////////////
	
	IF @VP_RESULTADO<>''
	BEGIN
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //UNI//'
	END
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_USUARIO_PEARL_ITS_DELETEABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_ITS_DELETEABLE]
GO

CREATE PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_ITS_DELETEABLE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_USUARIO_PEARL						[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO				VARCHAR(300) = ''
		
-- /////////////////////////////////////////////////////

	DECLARE @VP_N_FACTURA_X_USUARIO_PEARL		INT = 0
	-- EN EL CASO DEL USUARIO PEARL APLICARÍA LA VALIDACIÓN DE NO BORRAR EL USUARIO SI TIENE CARGADAS FACTURAS A SU NOMBRE.
	-- EL BORRADO SERÍA LÓGICO PARA QUE NO PIERDA LAS REFERENCIAS INCLUIDAS EN EL MISMO.
/*
	-- ADR: FALTA AGREGAR EL CODIGO QUE VALIDE ESTE CASO.
	SELECT	@VP_N_FACTURA_X_USUARIO_PEARL =		COUNT	(USUARIO_PEARL.K_USUARIO_PEARL)
											FROM	USUARIO_PEARL,FACTURA
											WHERE	PLANTA.K_USUARIO_PEARL=USUARIO_PEARL.K_USUARIO_PEARL	
											AND		USUARIO_PEARL.K_USUARIO_PEARL=@PP_K_USUARIO_PEARL										
*/
	-- =============================

	IF @VP_RESULTADO=''
		IF @VP_N_FACTURA_X_USUARIO_PEARL>0
			SET @VP_RESULTADO =  'There are [INVOICE] assigned.' 
		
	-- /////////////////////////////////////////////////////

	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_EXISTS
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_USUARIO_PEARL_EXISTS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_EXISTS]
GO


CREATE PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_EXISTS]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_USUARIO_PEARL					[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT,
	@OU_L_RESULTADO						[INT]				OUTPUT
AS

	DECLARE @VP_RESULTADO				VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////
	DECLARE @VP_K_USUARIO_PEARL			INT
	DECLARE @VP_L_BORRADO				INT

	SELECT	@VP_K_USUARIO_PEARL	=	COUNT(EN_NUM_EMP)
	FROM	HOWE.dbo.VISTA_GAFETES 
	WHERE	EN_NUM_EMP=@PP_K_USUARIO_PEARL
	-- ===========================

	IF @VP_K_USUARIO_PEARL=0
	BEGIN
			--SET @VP_RESULTADO =  'The [USUARIO_PEARL] does not exist.' 
			SET @VP_RESULTADO =  'El [USUARIO_PEARL] no existe en la Base de datos de RH.'
			SET @OU_L_RESULTADO	=	@VP_K_USUARIO_PEARL	-- @VP_K_USUARIO_PEARL=0	NO EXISTE EN BD
	END
	
	IF @VP_RESULTADO=''
	BEGIN
		SET @VP_K_USUARIO_PEARL = -1

		SELECT	@VP_K_USUARIO_PEARL =	USUARIO_PEARL.K_USUARIO_PEARL,
				@VP_L_BORRADO	=		USUARIO_PEARL.L_BORRADO
										FROM	USUARIO_PEARL
										WHERE	USUARIO_PEARL.K_EMPLEADO_PEARL=@PP_K_USUARIO_PEARL
		-- ===========================

		IF @VP_K_USUARIO_PEARL<>-1
		BEGIN
			IF @VP_L_BORRADO=1
			BEGIN
				--SET @VP_RESULTADO =  'The [USUARIO_PEARL] was down.' 
				SET @VP_RESULTADO =  'El [USUARIO_PEARL] fue dado de baja.' 
			END
			ELSE
			BEGIN
				SET @VP_RESULTADO =  'El [USUARIO_PEARL] ya existe.' 
			END
		END
		ELSE
		BEGIN
			SET @OU_L_RESULTADO	=	@VP_K_USUARIO_PEARL	-- @VP_K_USUARIO_PEARL=-1	NO EXISTE EN EL SISTEMA
		END
	END				
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_EXISTE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_USUARIO_PEARL_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_EXISTE]
GO


CREATE PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_EXISTE]
	--  @PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================		
	@PP_K_USUARIO_PEARL				INT,
	-- ===========================		
	@OU_RESULTADO_VALIDACION		VARCHAR(300)	OUTPUT
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 
	
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_USUARIO_PEARL		INT
	DECLARE @VP_L_BORRADO			INT


	SELECT	@VP_K_USUARIO_PEARL =	USUARIO_PEARL.K_USUARIO_PEARL,
			@VP_L_BORRADO	=		USUARIO_PEARL.L_BORRADO
									FROM	USUARIO_PEARL
									WHERE	USUARIO_PEARL.K_USUARIO_PEARL=@PP_K_USUARIO_PEARL

	-- ===========================

	IF @VP_RESULTADO=''
		IF ( @VP_K_USUARIO_PEARL IS NULL )
			SET @VP_RESULTADO =  'El registro para el [USUARIO_PEARL] no existe.' 

	-- ===========================

	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  'El [USUARIO_PEARL] fue dado de baja.' 
		
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_CLAVE_EXISTE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_USUARIO_PEARL_CLAVE_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_CLAVE_EXISTE]
GO


CREATE PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_CLAVE_EXISTE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_USUARIO_PEARL			INT,
	-- ===========================		
	@OU_RESULTADO_VALIDACION	VARCHAR(300)	OUTPUT
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO='' 
		BEGIN

		DECLARE @VP_EXISTE_CLAVE	INT

		SELECT	@VP_EXISTE_CLAVE =	COUNT(K_USUARIO_PEARL)
									FROM	USUARIO_PEARL 
									WHERE	K_USUARIO_PEARL=@PP_K_USUARIO_PEARL
										
		IF @VP_EXISTE_CLAVE>0
			SET @VP_RESULTADO =  'El folio/identificador no está disponible.' 

		END	
		
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_DELETE
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_USUARIO_PEARL_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_DELETE]
GO


CREATE PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_DELETE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_USUARIO_PEARL					[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO				VARCHAR(300) = ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_EXISTE]				@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_K_USUARIO_PEARL,	 
																@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_ITS_DELETEABLE]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_K_USUARIO_PEARL,	 
																@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DEL//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_USUARIO_PEARL_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_INSERT]
GO


CREATE PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_INSERT]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_USUARIO_PEARL					[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO				VARCHAR(300) = ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_EXISTS]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_USUARIO_PEARL,	 
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT

	-- ///////////////////////////////////////////
	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //INS//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_UPDATE
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_USUARIO_PEARL_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_UPDATE]
GO


CREATE PROCEDURE [dbo].[PG_RN_USUARIO_PEARL_UPDATE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_USUARIO_PEARL						[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO				VARCHAR(300) = ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_USUARIO_PEARL_EXISTS]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_USUARIO_PEARL,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////
	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //UPD//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
