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
sELECT * FROM USUARIO_PEARL WHERE K_USUARIO_PEARL = 173
UPDATE USUARIO_PEARL
SET	PASSWORD_USUARIO_PEARL = '7422'
WHERE K_USUARIO_PEARL = 173
-- //////////////////////////////////////////////////////////////
-- ///////			CONTENIDO DEL SP
--	[PG_SK_USER_PEARL]
--	[PG_SK_USER_PEARL_AUTORIZAR_COMPATIBLE]
-- //////////////////////////////////////////////////////////////

-- EXECUTE [dbo].[PG_SK_USER_PEARL] 0,0,  '' ,'1234567'
-- EXECUTE [dbo].[PG_SK_USER_PEARL] 0,0,  'PEDROS' ,'7422'
-- EXECUTE [dbo].[PG_SK_USER_PEARL] 0,0,  'jorgej' ,'1803'
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


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT /  
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_USER_PEARL_AUTORIZAR_COMPATIBLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_USER_PEARL_AUTORIZAR_COMPATIBLE]
GO
--		EXECUTE	 [dbo].[PG_SK_USER_PEARL_AUTORIZAR_COMPATIBLE] 0,139, 'JORGEJ', '1803', 'MRD'
--		EXECUTE	 [dbo].[PG_SK_USER_PEARL_AUTORIZAR_COMPATIBLE] 0,139, 'VIVIANAC', '170906', 'MRD'
CREATE PROCEDURE [dbo].[PG_SK_USER_PEARL_AUTORIZAR_COMPATIBLE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_USER					VARCHAR(50),
	@PP_PASSWORD				VARCHAR(50),
	@PP_TIPO_TRANSACCION		VARCHAR(50)
AS
	DECLARE	@VP_K_CODIGO		INT
			,@VP_NOMBRE			VARCHAR(500)
			,@VP_APELLIDO		VARCHAR(500)
	-- ///////////////////////////////////////////
		SELECT	@VP_K_CODIGO	= K_USUARIO_PEARL,
				@VP_NOMBRE		= NOMBRE,
				@VP_APELLIDO	= APELLIDO_PATERNO				
		FROM	USUARIO_PEARL		(NOLOCK)
		WHERE	LTRIM(RTRIM(PASSWORD_USUARIO_PEARL))	= @PP_PASSWORD
		AND		LTRIM(RTRIM(D_USUARIO_PEARL))			= @PP_USER
	
		DECLARE @VP_GRUPO_APROBADOR INT = 21

		IF @PP_TIPO_TRANSACCION <> 'Cuarentena'
			SET	@VP_GRUPO_APROBADOR = 30
	
	IF (	SELECT	COUNT(K_GRUPO_APROBADOR) 
			FROM	GRUPO_APROBADOR	
			WHERE	K_TIPO_GRUPO_APROBADOR		IN (21,30)	--= @VP_GRUPO_APROBADOR
			AND		K_USUARIO					= @VP_K_CODIGO
			AND		K_ESTATUS_GRUPO_APROBADOR	= 1		) > 0
	BEGIN
		SELECT @VP_NOMBRE + ' ' + @VP_APELLIDO AS MENSAJE
	END
	ELSE
	BEGIN
		SELECT ' '	AS MENSAJE
	END
		-----////////////////////////////////////////////////////////////////
	-- ////////////////////////////////////////////////////////////////////
GO