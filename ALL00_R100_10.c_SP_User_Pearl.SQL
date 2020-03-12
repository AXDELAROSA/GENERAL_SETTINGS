-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	[DATA_02Pruebas]
-- // MODULO:			USERS_PEARL / Folio Transaccion
-- // OPERACION:		LIBERACION / STORED PROCEDURES
-- //////////////////////////////////////////////////////////////
-- // Autor:			FEG
-- // Fecha creación:	11/FEB/2020
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL] 
GO


-- EXECUTE [dbo].[PG_SK_USER_PEARL] 0,0,  '' ,'123450'

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT /  
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USER_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USER_PEARL]
GO


CREATE PROCEDURE [dbo].[PG_SK_USER_PEARL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_USER					VARCHAR(50),
	@PP_PASSWORD				VARCHAR(20)
AS

	-- ///////////////////////////////////////////
		--SELECT * FROM	DATA_02.DBO.USERS_PEARL  WHERE contrasena  = 'password1'

	SELECT	ISNULL(CODIGO, 0)		AS CODIGO,
			ISNULL(NOMBRE, '')		AS NOMBRE,
			ISNULL(APELLIDO, '')	AS APELLIDO,
			ISNULL(USUARIO, '')		AS USUARIO,
			ISNULL(CONTRASENA, '')	AS CONTRASENA,
			ISNULL(CORREO, '')		AS CORREO,
			ISNULL(TIPO, '')		AS TIPO,
			ISNULL(TEMA, '')		AS TEMA
	-- =====================
	FROM	DATA_02.DBO.USERS_PEARL 
	WHERE	LTRIM(RTRIM(contrasena)) = ( CASE	WHEN @PP_PASSWORD = ''	THEN contrasena
							ELSE @PP_PASSWORD			END		)
	AND		LTRIM(RTRIM(usuario))	=	( CASE	WHEN @PP_USER = ''		THEN usuario
							ELSE @PP_USER				END		)
	-- =====================

	-----////////////////////////////////////////////////////////////////
	-- ////////////////////////////////////////////////////////////////////
GO


