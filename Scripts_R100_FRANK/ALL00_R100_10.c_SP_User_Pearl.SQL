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


-- EXECUTE [dbo].[PG_SK_USER_PEARL] 0,0,  '' ,'1234567'
-- EXECUTE [dbo].[PG_SK_USER_PEARL] 0,0,  '' ,'74123'
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
		--SELECT * FROM USUARIO_PEARL WHERE PASSWORD_USUARIO_PEARL  = 'password1'

		--SELECT UPPER(LEFT('HOLA',1))+LOWER(SUBSTRING('HOLA',2,LEN('HOLA')))

	SELECT	ISNULL(K_USUARIO_PEARL, 0)				AS CODIGO,
			-- ===========================
			--ISNULL(NOMBRE, '')						AS NOMBRE,
			 (CASE	WHEN CHARINDEX(' ',NOMBRE) = 0  THEN UPPER(LEFT(NOMBRE,1))+LOWER(SUBSTRING(NOMBRE,2,LEN(NOMBRE)))
					WHEN CHARINDEX(' ',NOMBRE) <> 0 AND  K_USUARIO_PEARL <> 47 THEN UPPER(LEFT(SUBSTRING( NOMBRE, 1, CHARINDEX(' ', NOMBRE)-1),1))+LOWER(SUBSTRING(SUBSTRING( NOMBRE, 1, CHARINDEX(' ', NOMBRE)-1),2,LEN(SUBSTRING( NOMBRE, 1, CHARINDEX(' ', NOMBRE)-1)))) 
					WHEN CHARINDEX(' ',NOMBRE) <> 0 AND  K_USUARIO_PEARL = 47 THEN UPPER(LEFT(SUBSTRING( NOMBRE, CHARINDEX(' ', NOMBRE) + 1, 20),1))+LOWER(SUBSTRING(SUBSTRING( NOMBRE, CHARINDEX(' ', NOMBRE) + 1, 20),2,LEN(SUBSTRING( NOMBRE, CHARINDEX(' ', NOMBRE) + 1, 20)))) 
											END)	AS NOMBRE,
			-- ===========================
			--ISNULL(APELLIDO_PATERNO, '')			AS APELLIDO,
			 (CASE	WHEN K_USUARIO_PEARL <> 86		THEN UPPER(LEFT(APELLIDO_PATERNO,1))+LOWER(SUBSTRING(APELLIDO_PATERNO,2,LEN(APELLIDO_PATERNO)))
					WHEN K_USUARIO_PEARL = 86		THEN UPPER(LEFT(SUBSTRING( NOMBRE, CHARINDEX(' ', NOMBRE) + 1, 20),1))+LOWER(SUBSTRING(SUBSTRING( NOMBRE, CHARINDEX(' ', NOMBRE) + 1, 20),2,LEN(SUBSTRING( NOMBRE, CHARINDEX(' ', NOMBRE) + 1, 20)))) 
											END)	AS APELLIDO,
			-- ===========================
			ISNULL(D_USUARIO_PEARL, '')			AS USUARIO,
			ISNULL(PASSWORD_USUARIO_PEARL, '')	AS CONTRASENA,
			ISNULL(CORREO_USUARIO_PEARL, '')	AS CORREO,
			ISNULL(K_USUARIO_TIPO, '')			AS TIPO,
			ISNULL(TEMA_USUARIO_PEARL, '')		AS TEMA
	-- ===========================
	FROM	USUARIO_PEARL 
	-- ===========================
	WHERE	LTRIM(RTRIM(PASSWORD_USUARIO_PEARL)) = ( CASE	WHEN @PP_PASSWORD = ''	THEN PASSWORD_USUARIO_PEARL
							ELSE @PP_PASSWORD			END		)
	AND		LTRIM(RTRIM(D_USUARIO_PEARL))	=	( CASE	WHEN @PP_USER = ''		THEN D_USUARIO_PEARL
							ELSE @PP_USER				END		)
	-- =====================

	-----////////////////////////////////////////////////////////////////
	-- ////////////////////////////////////////////////////////////////////
GO