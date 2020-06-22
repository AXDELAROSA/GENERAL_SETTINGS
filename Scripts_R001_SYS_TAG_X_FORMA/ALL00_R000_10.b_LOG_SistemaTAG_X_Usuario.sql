-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20200306
-- // MODULO:			
-- // OPERACION:		LIBERACION / 
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL] 
GO

-- //////////////////////////////////////////////////////////////
-- SELECT * FROM VERSION_SYS

-- EXECUTE [dbo].[PG_LI_VERSION_SYS] 0,0,0, '11/NOV/2019', -1, -1, -1, 'TEST'

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////


--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_VERSION_SYS]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_LI_VERSION_SYS]
--GO
---- EXECUTE [PG_LI_VERSION_SYS] 0,139,'',-1,NULL,NULL
--CREATE PROCEDURE [dbo].[PG_LI_VERSION_SYS]
--	@PP_K_SISTEMA_EXE				INT,
--	@PP_K_USUARIO_ACCION			INT,
--	-- ===========================
--	@PP_BUSCAR						VARCHAR(200),
--	@PP_K_USUARIO					INT,
--	@PP_F_INIT						DATE,
--	@PP_F_FINISH					DATE
--AS
--	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
--	DECLARE @VP_K_FOLIO				INT

--	EXECUTE [BD_GENERAL].DBO.[PG_RN_OBTENER_ID_X_REFERENCIA]			
--												@PP_BUSCAR,	@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
--	-- ===========================================
----	SELECT * FROM DATA_02Pruebas.dbo.users_pearl
----	SELECT * FROM VERSION_SYS
--	DECLARE @VP_LI_N_REGISTROS		INT	=	5000
--	-- ===========================================

--	SELECT	TOP (@VP_LI_N_REGISTROS)
--			USUARIO,
--			VERSION_SYS.*
--	FROM	VERSION_SYS
----			,DATA_02Pruebas.dbo.users_pearl
--	INNER JOIN	DATA_02Pruebas.dbo.users_pearl ON VERSION_SYS.K_USUARIO=USERS_PEARL.CODIGO
--			-- ===========================================
--	AND		(	D_VERSION_SYS		LIKE '%'+@PP_BUSCAR+'%'
--			OR  S_VERSION_SYS		LIKE '%'+@PP_BUSCAR+'%'
--				-- ===========================================
--			OR  USUARIO				LIKE '%'+@PP_BUSCAR+'%'	 )
--			-- ===========================================
--	AND		( @PP_K_USUARIO=-1				OR @PP_K_USUARIO=VERSION_SYS.K_USUARIO )
--			-- ===========================================
--	AND		( @PP_F_INIT IS NULL		OR	@PP_F_INIT<=F_VERSION_SYS_EVENTO)
--	AND		( @PP_F_FINISH IS NULL		OR	@PP_F_INIT>=F_VERSION_SYS_EVENTO)
--			-- =============================
--	ORDER BY F_VERSION_SYS_EVENTO DESC, K_VERSION_SYS DESC

--	-- ========================================
--GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_VERSION_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_VERSION_SYS]
GO
-- EXECUTE [dbo].[PG_IN_VERSION_SYS] 0,140,'IT-002','378','1'
-- SELECT * FROM VERSION_SYS
CREATE PROCEDURE [dbo].[PG_IN_VERSION_SYS]
	@PP_K_SISTEMA_EXE				[INT],
	@PP_K_USUARIO					[INT],
	-- ===========================================
	@PP_D_VERSION_SYS				[VARCHAR](50),		-- COMPUTER_NAME
	@PP_S_VERSION_SYS				[VARCHAR](50),		-- VERSION_SYSTEM
	@PP_S_BD_SYS					[VARCHAR](50)		-- BD_DEBUG_SYSTEM
AS
	-- ========================================
	--INSERT INTO VERSION_SYS
	--(	
	--	--[K_VERSION_SYS],
	--	[F_VERSION_SYS_EVENTO],
	--	[K_USUARIO],				[D_VERSION_SYS],
	--	[S_VERSION_SYS],			[S_BD_SYS]	
	--)
	--VALUES	
	--(	
	--	--@PP_K_VERSION_SYS,			
	--	GETDATE(),
	--	@PP_K_USUARIO,				@PP_D_VERSION_SYS,
	--	@PP_S_VERSION_SYS,			@PP_S_BD_SYS
	--)
	DECLARE @PP_DATOS VARCHAR (100)
					--	COMPUTER_NAME		VERSION_SYSTEM		BD_DEBUG_SYSTEM
	SET @PP_DATOS = (@PP_D_VERSION_SYS+' / '+@PP_S_VERSION_SYS+' / '+@PP_S_BD_SYS)

	--SE INSERTARÁ EL LOG EN UNA SOLA TABLA DE BITACORA. SE QUITA LA TABLA DE LOG_VERSION EL DÍA 20200615
	-- ========================================
	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO,
													-- ===========================================
													2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'LOG_VERSION_SYS',
													@PP_DATOS,
													-- ===========================================
													'[PG_IN_VERSION_SYS] COMPUTER_NAME , VERSION_SYSTEM, BD_DEBUG_SYSTEM',	-- @PP_STORED_PROCEDURE		[VARCHAR] (100),
													0, 0, 	-- @PP_K_FOLIO_1, @PP_K_FOLIO_2, 
													-- ===========================================			
													-- === DATOS A INSERTAR Y TIPO DE DATO
													0, 0,								-- [INT],	[INT]										
													'', '' ,							-- [VARCHAR](100), [VARCHAR](100), 
													0.00, 0.00,							-- DECIMAL(19,4), DECIMAL(19,4),												  
													-- ===========================================			
													-- === @PP_VALOR_ DE LOS DATOS A INSERTAR DEL 1 al 6
													'', '',								-- [INT],	[INT]					
													'', '', 							-- [VARCHAR](100), [VARCHAR](100), 
													'', ''								-- DECIMAL(19,4), DECIMAL(19,4),
GO

-- //////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////
