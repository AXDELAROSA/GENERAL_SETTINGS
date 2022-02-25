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
--	[PG_SK_AUTORIZACION_ACTUALIZAR]

-- //////////////////////////////////////////////////////////////
-- //	STORED PROCEDURE ---> PARA MOSTRAR ALERTAS 
-- //	DE ORDENES PENDIENTES (RMA-PES).
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_AUTORIZACION_ACTUALIZAR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_AUTORIZACION_ACTUALIZAR]
GO
--		 EXECUTE [dbo].[PG_SK_AUTORIZACION_ACTUALIZAR] 0,139,	'IT-002'	,0
--		 EXECUTE [dbo].[PG_SK_AUTORIZACION_ACTUALIZAR] 0,139,	'MTR-TV'	,0
--		 EXECUTE [dbo].[PG_SK_AUTORIZACION_ACTUALIZAR] 1,88,	'IT-010'		,401
--		 EXECUTE [dbo].[PG_SK_AUTORIZACION_ACTUALIZAR] 1,88,	'IT-007'		,401
--		 EXECUTE [dbo].[PG_SK_AUTORIZACION_ACTUALIZAR] 1,88,	'rebajadora'	,401
CREATE PROCEDURE [dbo].[PG_SK_AUTORIZACION_ACTUALIZAR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_D_NOMBRE_EQUIPO				VARCHAR(250),
	@PP_VERSION_ACTUALIZAR			INT
AS

	DECLARE	 @VP_MENSAJE		NVARCHAR(MAX)
			,@VP_K_EXISTE		INT	= 0
			,@VP_VERSION_BD		INT	= 0
	
	SELECT	@VP_K_EXISTE	=	K_AUTORIZACION_ACTUALIZAR,
			@VP_VERSION_BD	=	VERSION_ACTUALIZAR
	FROM	AUTORIZACION_ACTUALIZAR		(NOLOCK)
	WHERE	D_NOMBRE_EQUIPO	= @PP_D_NOMBRE_EQUIPO

	IF @VP_K_EXISTE	> 0
	BEGIN
		SET	@VP_MENSAJE	= 'NO ACTUALIZAR'
	END
	ELSE
	BEGIN
		SET	@VP_MENSAJE	= ''
	END

	SELECT @VP_MENSAJE	AS MENSAJE, @VP_K_EXISTE AS CLAVE
	-- ////////////////////////////////////////////////////////////////////
GO