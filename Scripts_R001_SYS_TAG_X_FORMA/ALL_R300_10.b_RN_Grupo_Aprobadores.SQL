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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_GRUPO_LEER_TICKET_PIEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_GRUPO_LEER_TICKET_PIEL]
GO
/*
	EXEC [PG_RN_GRUPO_LEER_TICKET_PIEL] 0,0, 144
*/
CREATE PROCEDURE [dbo].[PG_RN_GRUPO_LEER_TICKET_PIEL]
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
					AND		D_GRUPO_APROBADOR = 'LEER TICKES DE PIEL'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 450 --  LEER TICKET
				)
			BEGIN
				SET @VP_RESULTADO =  'Usuario  <NO AUTORIZADO>...' 
			END

	-- /////////////////////////////////////////////////////
	SELECT @VP_RESULTADO AS MENSAJE
	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_GRUPO_UP_DL_ORDEN_PLANNING]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_GRUPO_UP_DL_ORDEN_PLANNING]
GO
/*
	EXEC [PG_RN_GRUPO_UP_DL_ORDEN_PLANNING] 0,0, 144
*/
CREATE PROCEDURE [dbo].[PG_RN_GRUPO_UP_DL_ORDEN_PLANNING]
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
					AND		D_GRUPO_APROBADOR = 'MODIFICAR/ELIMINAR ORDEN EN PLANNING'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 400 --  MODIFICAR/ELIMANAR ORDEN
				)
			BEGIN
				SET @VP_RESULTADO =  'Usuario  <NO AUTORIZADO>...' 
			END

	-- /////////////////////////////////////////////////////
	SELECT @VP_RESULTADO AS MENSAJE
	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_GRUPO_QA_MODIFICAR_INSPECCION_MATERIAL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_GRUPO_QA_MODIFICAR_INSPECCION_MATERIAL]
GO
/*
	EXEC [PG_RN_GRUPO_QA_MODIFICAR_INSPECCION_MATERIAL] 0,0, 'FRANCISCOE', 'FR@NC15C03'
*/
CREATE PROCEDURE [dbo].[PG_RN_GRUPO_QA_MODIFICAR_INSPECCION_MATERIAL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_D_USUARIO				VARCHAR(150),
	@PP_PASSWORD				VARCHAR(150)
	-- ===========================		
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 
	
	-- /////////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		IF NOT EXISTS(	SELECT	K_GRUPO_APROBADOR 
					FROM	BD_GENERAL.DBO.[GRUPO_APROBADOR] 
					INNER	JOIN USUARIO_PEARL ON [GRUPO_APROBADOR].K_USUARIO = USUARIO_PEARL.K_USUARIO_PEARL
					WHERE	D_USUARIO_PEARL = @PP_D_USUARIO	
					AND		S_GRUPO_APROBADOR = @PP_PASSWORD
					AND		D_GRUPO_APROBADOR = 'QA MODIFICAR INSPECCION MATERIAL'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 150 --  MODIFICAR INSPECCION MATERIAL QA
				)
			BEGIN
				SET @VP_RESULTADO =  'Usuario  <NO AUTORIZADO>...' 
			END
	-- /////////////////////////////////////////////////////
	
	SELECT @VP_RESULTADO AS MENSAJE

	-- /////////////////////////////////////////////////////
GO



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
--	USE BD_GENERAL
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_MRD]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_MRD]
GO

--	EXEC [PG_RN_VALIDA_USUARIO_MRD] 0,0,144

CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_MRD]
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
					AND		D_GRUPO_APROBADOR = 'AUTORIZAR SALIDA MRD'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 30 --  MQU SALIDA
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



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_ABRIR_ORDEN_COMPLETA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_ABRIR_ORDEN_COMPLETA]
GO

--	EXEC [PG_RN_VALIDA_USUARIO_ABRIR_ORDEN_COMPLETA] 0,0, 144

CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_ABRIR_ORDEN_COMPLETA]
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
					AND		K_TIPO_GRUPO_APROBADOR = 102 -- ABRIR ORDEN
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
-- USE BD_GENERAL
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_CERRAR_ORDEN]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_CERRAR_ORDEN]
GO

--	EXEC [PG_RN_VALIDA_USUARIO_CERRAR_ORDEN] 0,0, 144

CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_CERRAR_ORDEN]
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
					AND		D_GRUPO_APROBADOR = 'PRD CERRAR ORDEN'
					AND		K_ESTATUS_GRUPO_APROBADOR = 1 -- ACTIVO
					AND		K_TIPO_GRUPO_APROBADOR = 121 -- CERRAR ORDEN
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
