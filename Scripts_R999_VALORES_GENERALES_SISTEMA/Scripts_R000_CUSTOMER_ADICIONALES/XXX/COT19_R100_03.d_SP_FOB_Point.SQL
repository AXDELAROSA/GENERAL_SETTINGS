-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			FOB_POINT
-- // OPERATION:		PROCEDIMIENTOS ESPECIFICOS
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20190903
-- ////////////////////////////////////////////////////////////// 

--USE [COT19_Cotizaciones_V9999_R0]
USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
--SELECT * FROM FOB_POINT
--EXECUTE [dbo].[PG_LI_FOB_POINT] 0,0010,139,  '' , -1 ,-1,-1

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_FOB_POINT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_FOB_POINT]
GO


CREATE PROCEDURE [dbo].[PG_LI_FOB_POINT]
	--  @PP_L_DEBUG							INT,
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ==============================================
	@PP_BUSCAR							VARCHAR(200),
	-- ==============================================
	@PP_K_STATUS_FOB_POINT				INT
	--@PP_K_COUNTRY						INT,
	--@PP_K_STATE_GEO_FOB_POINT			INT
AS

	DECLARE @VP_MENSAJE					VARCHAR(300) = ''
	DECLARE @VP_L_APLICAR_MAX_ROWS		INT = 0
	
	-- ///////////////////////////////////////////

	--IF @VP_MENSAJE=''
	--	EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	--  @PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
	--												11, -- @PP_K_DATA_SISTEMA,	
	--												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////

	DECLARE @VP_LI_N_REGISTROS	INT=5000

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_LISTADO_MAX_ROWS_PESADO_GET]		--  @PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--																	@VP_L_APLICAR_MAX_ROWS,		
	--																	@OU_MAXROWS = @VP_LI_N_REGISTROS		OUTPUT	
	-- =========================================		

	DECLARE @VP_K_FOLIO		INT

	EXECUTE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]		@PP_BUSCAR, 
														@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
	-- =========================================
	
	DECLARE @VP_L_VER_BORRADOS		INT		
	
	--EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]			--  @PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--												@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT
	-- =========================================

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0

	-- =========================================
		
	SELECT	TOP (@VP_LI_N_REGISTROS)
				FOB_POINT.*,
--				USERS_PEARL.USUARIO AS D_USUARIO_CAMBIO,	
			-- =====================
				D_STATUS_FOB_POINT, --D_STATE_GEO, D_COUNTRY,   
				S_STATUS_FOB_POINT --S_STATE_GEO, S_COUNTRY
			-- =====================
	FROM		--USERS_PEARL, 
				FOB_POINT			(NOLOCK) , 
				STATUS_FOB_POINT	(NOLOCK) ,
				COUNTRY				(NOLOCK) ,
				STATE_GEO			(NOLOCK) 		
			-- =====================
--	WHERE		FOB_POINT.K_USUARIO_CAMBIO=USERS_PEARL.CODIGO
			-- =====================
	WHERE		FOB_POINT.K_STATUS_FOB_POINT=STATUS_FOB_POINT.K_STATUS_FOB_POINT
	--AND			FOB_POINT.K_COUNTRY=COUNTRY.K_COUNTRY
	--AND			FOB_POINT.K_STATE_GEO_FOB_POINT=STATE_GEO.K_STATE_GEO
			-- =====================
	AND		(		FOB_POINT.D_FOB_POINT				LIKE '%'+@PP_BUSCAR+'%' 
				OR	FOB_POINT.C_FOB_POINT				LIKE '%'+@PP_BUSCAR+'%' 
				OR	FOB_POINT.K_FOB_POINT=@VP_K_FOLIO 
			)	
			-- =====================
	AND		( @PP_K_STATUS_FOB_POINT=-1			OR	FOB_POINT.K_STATUS_FOB_POINT=@PP_K_STATUS_FOB_POINT )
	--AND		( @PP_K_COUNTRY=-1					OR	FOB_POINT.K_COUNTRY=@PP_K_COUNTRY )
	--AND		( @PP_K_STATE_GEO_FOB_POINT=-1		OR	FOB_POINT.K_STATE_GEO_FOB_POINT=@PP_K_STATE_GEO_FOB_POINT )
			-- =====================
	AND		( FOB_POINT.L_BORRADO=0				OR	@VP_L_VER_BORRADOS=1 )	
			-- =====================		
	-- COMENTADO PARA PRUEBAS
	--AND		( K_FOB_POINT>0 )
	ORDER BY D_FOB_POINT 
			
	-- /////////////////////////////////////////////////////////////////////

	--EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
	--												@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--												-- ===========================================
	--												2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
	--												'SELECT',
	--												@VP_MENSAJE,
	--												-- ===========================================
	--												'[PG_LI_FOB_POINT]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
	--												0, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
	--												-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
	--												0, 0, @PP_BUSCAR, '' , 0.00, 0.00,
	--												-- === @PP_VALOR_1 al 6_DATO
	--												'', '', '@PP_BUSCAR', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_FOB_POINT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_FOB_POINT]
GO


CREATE PROCEDURE [dbo].[PG_SK_FOB_POINT]
	--  @PP_L_DEBUG							INT,
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_FOB_POINT						INT
AS

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		--EXECUTE [dbo].[PG_RN_DATA_ACCESO_SEEK]		--  @PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
		--											11, -- @PP_K_DATA_SISTEMA,	
		--											@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////
	
	DECLARE @VP_L_VER_BORRADOS		INT		
	
	--EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]			--  @PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--												@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT
	-- ///////////////////////////////////////////

	DECLARE @VP_LI_N_REGISTROS		INT = 5000

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0

	-- =========================================
		
	SELECT	TOP (@VP_LI_N_REGISTROS)
				FOB_POINT.*,
--				USERS_PEARL.USUARIO AS D_USUARIO_CAMBIO,	
			-- =====================
				D_STATUS_FOB_POINT, 
				S_STATUS_FOB_POINT
			-- =====================
	FROM		--USERS_PEARL, 
				FOB_POINT			(NOLOCK) , 
				STATUS_FOB_POINT	(NOLOCK) 
				--COUNTRY				(NOLOCK) ,
				--STATE_GEO			(NOLOCK) 		
			-- =====================
--	WHERE		FOB_POINT.K_USUARIO_CAMBIO=USERS_PEARL.CODIGO
			-- =====================
	WHERE		FOB_POINT.K_FOB_POINT=@PP_K_FOB_POINT
			-- =====================
		
	-----////////////////////////////////////////////////////////////////

	--EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
	--												@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--												-- ===========================================
	--												2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
	--												'SEEK',
	--												@VP_MENSAJE,
	--												-- ===========================================
	--												'[PG_SK_FOB_POINT]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
	--												@PP_K_FOB_POINT, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
	--												-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
	--												0, 0, '', '' , 0.00, 0.00,
	--												-- === @PP_VALOR_1 al 6_DATO
	--												'', '', '', '', '', ''

	-- ////////////////////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_FOB_POINT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_FOB_POINT]
GO


CREATE PROCEDURE [dbo].[PG_IN_FOB_POINT]
	--  @PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_FOB_POINT					VARCHAR(100),
	@PP_S_FOB_POINT					VARCHAR(10),
	@PP_C_FOB_POINT					VARCHAR(255),
	-- ===========================
	@PP_K_STATUS_FOB_POINT			INT
	--@PP_K_COUNTRY					INT,
	--@PP_K_STATE_GEO_FOB_POINT		INT
AS			

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	DECLARE @VP_K_FOB_POINT		INT = 0
	
	EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	--  @PP_L_DEBUG, 
												@PP_K_SISTEMA_EXE,
												'FOB_POINT', 
												@OU_K_TABLA_DISPONIBLE = @VP_K_FOB_POINT			OUTPUT
	-- ==================================

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_FOB_POINT_INSERT]			--  @PP_L_DEBUG, 
														@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@VP_K_FOB_POINT,@PP_D_FOB_POINT,
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
															
	-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		BEGIN	
		--DECLARE @VP_S_FOB_POINT VARCHAR(10) = LEFT(@PP_D_FOB_POINT,5)		
		INSERT INTO [FOB_POINT]	
			(	[K_FOB_POINT], [D_FOB_POINT],
				[S_FOB_POINT], [O_FOB_POINT],
				[C_FOB_POINT], [L_FOB_POINT],
				[K_STATUS_FOB_POINT],
				--[K_COUNTRY],
				--[K_STATE_GEO_FOB_POINT],
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@VP_K_FOB_POINT, @PP_D_FOB_POINT,
				@PP_S_FOB_POINT, 1, 
				@PP_C_FOB_POINT, 1,
				@PP_K_STATUS_FOB_POINT,
				--@PP_K_COUNTRY,
				--@PP_K_STATE_GEO_FOB_POINT,		
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )				
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible insertar el [FOB_POINT]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Pun.'+CONVERT(VARCHAR(10),@VP_K_FOB_POINT)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_FOB_POINT AS CLAVE
	
	-- //////////////////////////////////////////////////////////////

	--EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
	--												@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--												-- ===========================================
	--												3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
	--												'INSERT',
	--												@VP_MENSAJE,
	--												-- ===========================================
	--												'[PG_IN_FOB_POINT]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
	--												@VP_K_FOB_POINT, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
	--												-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
	--												--0, 0, @PP_C_FOB_POINT, '', 0.00, 0.00,
	--												0, 0, '', @VP_MENSAJE, 0.00, 0.00,
	--												-- === @PP_VALOR_1 al 6_DATO
	--												'', '', '', '@VP_MENSAJE', '', ''

	-- //////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_FOB_POINT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_FOB_POINT]
GO

CREATE PROCEDURE [dbo].[PG_UP_FOB_POINT]
	--  @PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_K_FOB_POINT					INT,			
	@PP_D_FOB_POINT					VARCHAR(100),
	@PP_S_FOB_POINT					VARCHAR(10),
	@PP_C_FOB_POINT					VARCHAR(255),
	@PP_K_STATUS_FOB_POINT			INT
	--@PP_K_COUNTRY					INT,
	--@PP_K_STATE_GEO_FOB_POINT		INT
AS			

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_FOB_POINT_UPDATE]		--  @PP_L_DEBUG, 
													@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_FOB_POINT, @PP_D_FOB_POINT,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN
		--DECLARE @VP_S_FOB_POINT VARCHAR(10) = LEFT(@PP_D_FOB_POINT,5)		
		-- ==================================

		UPDATE	FOB_POINT
		SET		
				[D_FOB_POINT]				= @PP_D_FOB_POINT,					
				[S_FOB_POINT]				= @PP_S_FOB_POINT,					
				[C_FOB_POINT]				= @PP_C_FOB_POINT,
				[K_STATUS_FOB_POINT]		= @PP_K_STATUS_FOB_POINT,
				--[K_COUNTRY]					= @PP_K_COUNTRY,
				--[K_STATE_GEO_FOB_POINT]		= @PP_K_STATE_GEO_FOB_POINT,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_FOB_POINT=@PP_K_FOB_POINT

		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible actualizar el [FOB_POINT]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Pun.'+CONVERT(VARCHAR(10),@PP_K_FOB_POINT)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_FOB_POINT AS CLAVE

	-- //////////////////////////////////////////////////////////////

	--EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
	--												@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--												-- ===========================================
	--												3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
	--												'UPDATE',
	--												@VP_MENSAJE,
	--												-- ===========================================
	--												'[PG_UP_FOB_POINT]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
	--												@PP_K_FOB_POINT, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
	--												-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
	--												--0, 0, @PP_C_FOB_POINT, '', 0.00, 0.00,
	--												0, 0, '', @VP_MENSAJE, 0.00, 0.00,
	--												-- === @PP_VALOR_1 al 6_DATO
	--												'', '', '', '@VP_MENSAJE', '', ''

	-- //////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_FOB_POINT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_FOB_POINT]
GO


CREATE PROCEDURE [dbo].[PG_DL_FOB_POINT]
	--  @PP_L_DEBUG							INT,
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_FOB_POINT							INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''

	-- //////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_FOB_POINT_DELETE]				--  @PP_L_DEBUG, 
														@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_FOB_POINT, 
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- //////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	FOB_POINT
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_FOB_POINT=@PP_K_FOB_POINT

		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible borrar el [FOB_POINT]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Pun.'+CONVERT(VARCHAR(10),@PP_K_FOB_POINT)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_FOB_POINT AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	--EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
	--												@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--												-- ===========================================
	--												5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
	--												'DELETE',
	--												@VP_MENSAJE,
	--												-- ===========================================
	--												'[PG_DL_FOB_POINT]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
	--												@PP_K_FOB_POINT, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
	--												-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
	--												0, 0, '', '' , 0.00, 0.00,
	--												-- === @PP_VALOR_1 al 6_DATO
	--												'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
