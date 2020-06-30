-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	[BD_GENERAL]
-- // MODULO:			[REGLAS DE NOGOCIO GRUPO APROBADORES]
-- // OPERACION:		LIBERACION / STORED PROCEDURES
-- //////////////////////////////////////////////////////////////
-- // Autor:			FEG
-- // Fecha creación:	30/JUN/2020
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL] 
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_MQU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_MQU]
GO

--	EXEC [PG_RN_VALIDA_USUARIO_MQU] 0,0,144

CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_MQU]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_CODIGO_USUARIO			INT
	-- ===========================		
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 
	
	-- /////////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		IF NOT EXISTS(	SELECT	K_GRUPO_APROBADOR 
					FROM	BD_GENERAL.DBO.[GRUPO_APROBADOR] 
					WHERE	K_USUARIO = @PP_CODIGO_USUARIO	
					AND		D_GRUPO_APROBADOR = 'AUTORIZAR SALIDA MQU'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 21 --  MQU SALIDA
				)
			BEGIN
				SET @VP_RESULTADO =  'No es posible transferir: Usuario  <NO AUTORIZADO>...' 
			END
	-- /////////////////////////////////////////////////////
	
	SELECT @VP_RESULTADO AS MENSAJE

	-- /////////////////////////////////////////////////////
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_TRANSFERIR_ORDEN_COMPLETA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_TRANSFERIR_ORDEN_COMPLETA]
GO

--	EXEC [PG_RN_VALIDA_USUARIO_TRANSFERIR_ORDEN_COMPLETA] 0,0, 70

CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_TRANSFERIR_ORDEN_COMPLETA]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_CODIGO_USUARIO			INT
	-- ===========================		
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 
	
	-- /////////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		IF NOT EXISTS(	SELECT	K_GRUPO_APROBADOR 
					FROM	BD_GENERAL.DBO.[GRUPO_APROBADOR] 
					WHERE	K_USUARIO = @PP_CODIGO_USUARIO	
					AND		D_GRUPO_APROBADOR = 'TRANSFERIR ORDEN'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 61 --  TRANSFERIR ORDEN COMPLETA
				)
			BEGIN
				SET @VP_RESULTADO =  'No es posible transferir: Usuario  <NO AUTORIZADO>...' 
			END
	-- /////////////////////////////////////////////////////
	
	SELECT @VP_RESULTADO AS MENSAJE

	-- /////////////////////////////////////////////////////
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_TRANSFERIR_ORDEN_TX7]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_TRANSFERIR_ORDEN_TX7]
GO

--	EXEC [PG_RN_VALIDA_USUARIO_TRANSFERIR_ORDEN_TX7] 0,0, 70

CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_TRANSFERIR_ORDEN_TX7]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_CODIGO_USUARIO			INT
	-- ===========================		
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 
	
	-- /////////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		IF NOT EXISTS(	SELECT	K_GRUPO_APROBADOR 
					FROM	BD_GENERAL.DBO.[GRUPO_APROBADOR] 
					WHERE	K_USUARIO = @PP_CODIGO_USUARIO	
					AND		D_GRUPO_APROBADOR = 'TRANSFERIR ORDEN'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 62 --  TRANSFERIR ORDEN TX7
				)
			BEGIN
				SET @VP_RESULTADO =  'No es posible transferir: Usuario  <NO AUTORIZADO>...' 
			END
	-- /////////////////////////////////////////////////////
	
	SELECT @VP_RESULTADO AS MENSAJE

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_REPORTE_INCOMING_INSPECTION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_REPORTE_INCOMING_INSPECTION]
GO

--	EXEC [PG_RN_VALIDA_USUARIO_REPORTE_INCOMING_INSPECTION] 0,0, 47

CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_REPORTE_INCOMING_INSPECTION]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_CODIGO_USUARIO			INT
	-- ===========================		
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 
	
	-- /////////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		IF NOT EXISTS(	SELECT	K_GRUPO_APROBADOR 
					FROM	BD_GENERAL.DBO.[GRUPO_APROBADOR] 
					WHERE	K_USUARIO = @PP_CODIGO_USUARIO	
					AND		D_GRUPO_APROBADOR = 'REPORTE INCOMING INSPECTION'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 81 --  MODIFCAR ESTATUS REPORTE
				)
			BEGIN
				SET @VP_RESULTADO =  'No es posible transferir: Usuario  <NO AUTORIZADO>...' 
			END
	-- /////////////////////////////////////////////////////
	
	SELECT @VP_RESULTADO AS MENSAJE

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_PRODUCCION_SELECCIONAR_KITS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_PRODUCCION_SELECCIONAR_KITS]
GO

--	EXEC [PG_RN_VALIDA_USUARIO_PRODUCCION_SELECCIONAR_KITS] 0,0, 49

CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_PRODUCCION_SELECCIONAR_KITS]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_CODIGO_USUARIO			INT
	-- ===========================		
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 
	
	-- /////////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		IF NOT EXISTS(	SELECT	K_GRUPO_APROBADOR 
					FROM	BD_GENERAL.DBO.[GRUPO_APROBADOR] 
					WHERE	K_USUARIO = @PP_CODIGO_USUARIO	
					AND		D_GRUPO_APROBADOR = 'PRODUCCION SELECCIONAR KITS'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 101 --  SELECCIONAR TODO
				)
			BEGIN
				SET @VP_RESULTADO =  'No es posible transferir: Usuario  <NO AUTORIZADO>...' 
			END
	-- /////////////////////////////////////////////////////
	
	SELECT @VP_RESULTADO AS MENSAJE

	-- /////////////////////////////////////////////////////
GO



-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
