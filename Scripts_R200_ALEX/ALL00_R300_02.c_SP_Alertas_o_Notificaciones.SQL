-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	[BD_GENERAL]
-- // MODULO:			MENU
-- // OPERACION:		VERIFICAR NOTIFICACIONES
-- //////////////////////////////////////////////////////////////
-- // Autor:			AX
-- // Fecha creación:	20210621
-- ////////////////////////////////////////////////////////////// 

 USE [BD_GENERAL] 
GO

-- //////////////////////////////////////////////////////////////
-- /////////////		CONTENIDO DEL SP
--	[PG_LI_NOTIFICACION_PANTALLA]
--	[PG_SK_NOTIFICACION_PANTALLA]

-- //////////////////////////////////////////////////////////////
-- //	STORED PROCEDURE ---> PARA MOSTRAR ALERTAS 
-- //	DE ORDENES PENDIENTES (RMA-PES).
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_NOTIFICACION_PANTALLA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_NOTIFICACION_PANTALLA]
GO
--		 EXECUTE [dbo].[PG_LI_NOTIFICACION_PANTALLA] 0,139
--		 EXECUTE [dbo].[PG_LI_NOTIFICACION_PANTALLA] 0,43
--		 EXECUTE [dbo].[PG_LI_NOTIFICACION_PANTALLA] 0,47
CREATE PROCEDURE [dbo].[PG_LI_NOTIFICACION_PANTALLA]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT
	-- ===========================
AS
		SELECT	*
		FROM	NOTIFICACION_PANTALLA	(NOLOCK)
		WHERE	K_ESTATUS_NOTIFICACION_PANTALLA	IN	( 1 )

	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //	STORED PROCEDURE ---> PARA MOSTRAR ALERTAS 
-- //	DE ORDENES PENDIENTES (RMA-PES).
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_NOTIFICACION_PANTALLA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_NOTIFICACION_PANTALLA]
GO
--		 EXECUTE [dbo].[PG_SK_NOTIFICACION_PANTALLA] 0,43, 97, 9703
--		 EXECUTE [dbo].[PG_SK_NOTIFICACION_PANTALLA] 0,47, 97, 9703
--		 EXECUTE [dbo].[PG_SK_NOTIFICACION_PANTALLA] 0,139, 97, 9703
CREATE PROCEDURE [dbo].[PG_SK_NOTIFICACION_PANTALLA]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_PANTALLA					INT,
	@PP_K_GRUPO_APROBADOR			INT
AS

	IF	@PP_K_PANTALLA	= 64
	BEGIN

		EXECUTE	[COMPRAS].[dbo].[PG_SK_ALERTAS_64]			@PP_K_SISTEMA_EXE,		@PP_K_USUARIO_ACCION,
															@PP_K_GRUPO_APROBADOR

	END
	
	IF @PP_K_PANTALLA	= 97
	BEGIN

		EXECUTE	[DATA_02].[dbo].[PG_SK_NOTIFICACION_RMA]	@PP_K_SISTEMA_EXE,		@PP_K_USUARIO_ACCION,
															@PP_K_GRUPO_APROBADOR

	END

	-- ////////////////////////////////////////////////////////////////////
GO