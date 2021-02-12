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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PR_IN_ACEPTAR_TRANSFERENCIA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PR_IN_ACEPTAR_TRANSFERENCIA]
GO
	--	 EXECUTE [DBO].[PR_IN_ACEPTAR_TRANSFERENCIA]	0,139,'XXX','IT-002','66666','TRANS','AUTORIZA'
CREATE PROCEDURE [dbo].[PR_IN_ACEPTAR_TRANSFERENCIA]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================,
	@PP_PASSWORD				VARCHAR(50),
	@PP_COMPUTER_NAME			VARCHAR(50),
	@PP_JOB_NO					VARCHAR(10),
	@PP_SCREEN					VARCHAR(50),
	@PP_MOVIMIENTO				VARCHAR(50)
AS
DECLARE @VP_MENSAJE	VARCHAR(MAX)

BEGIN TRANSACTION 
BEGIN TRY
	-- ///////////////////////////////////////////
	--EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'ALEJANDROD','111111'
	--
	--SELECT * FROM	USUARIO_PEARL

	DECLARE	 @VP_USUARIO_EXISTE		INT	= 0
			,@VP_USER_ACTION		VARCHAR(50)

	IF @PP_PASSWORD='32147'				--MARLENNES
	BEGIN
		SET	@VP_USUARIO_EXISTE	= 162
		SET @VP_USER_ACTION		= 'MARLENNES'
	END
	ELSE IF @PP_PASSWORD='12369'		--TERESAJ
	BEGIN
		SET	@VP_USUARIO_EXISTE	= 132	
		SET @VP_USER_ACTION		= 'TERESAJ'
	END

	--=======================================================
	IF @VP_USUARIO_EXISTE <> 0
	BEGIN
		DECLARE @VP_FECHA_INT    INT = FORMAT(CAST(GETDATE() AS DATE), N'yyyyMMdd');
		DECLARE @VP_HORA_INT	INT = FORMAT(CAST(GETDATE() AS TIME(0)), N'hhmmss');

			IF @PP_K_SISTEMA_EXE	= 0
			BEGIN
				INSERT INTO DATA_02Pruebas.DBO.PEARL_LOG
				(	cdate,				ctime,				[user_name],
					computer,			screen_opt,			jobno,
					movement,			detail			)
				VALUES
				(	@VP_FECHA_INT,		@VP_HORA_INT,		@VP_USER_ACTION,
					@PP_COMPUTER_NAME,	@PP_SCREEN,			@PP_JOB_NO,
					@PP_MOVIMIENTO,		''		)

				IF @@ROWCOUNT = 0
				BEGIN
					RAISERROR ('Registro no insertado.(TEST)', 16, 1 )
				END
			END
			ELSE
			BEGIN
				INSERT INTO DATA_02.DBO.PEARL_LOG
				(	cdate,				ctime,				[user_name],
					computer,			screen_opt,			jobno,
					movement,			detail			)
				VALUES
				(	@VP_FECHA_INT,		@VP_HORA_INT,		@VP_USER_ACTION,
					@PP_COMPUTER_NAME,	@PP_SCREEN,			@PP_JOB_NO,
					@PP_MOVIMIENTO,		''		)

				IF @@ROWCOUNT = 0
				BEGIN
					RAISERROR ('Registro no insertado.(LIVE)', 16, 1 )
				END
			END
	END
	ELSE
	BEGIN
		RAISERROR ('Los datos del Usuario no son correctos o no tienes permisos para realizar la acción soilictada.', 16, 1 )
	END


	-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
		BEGIN
			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
		END

	SELECT	@VP_MENSAJE AS MENSAJE
	-- //////////////////////////////////////////////////////////////
GO


----		SELECT * FROM DATA_02.DBO.PEARL_LOG
---- //////////////////////////////////////////////////////////////
---- // STORED PROCEDURE ---> SELECT /  
---- //////////////////////////////////////////////////////////////
----	 SE UTILIZA EN LA FORMA DE Transferencias, para verificar los usuarios autorizados.
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PR_IN_ACEPTAR_TRANSFERENCIA]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PR_IN_ACEPTAR_TRANSFERENCIA]
--GO
----	EXECUTE [DBO].[PR_IN_ACEPTAR_TRANSFERENCIA]	0,139,'ALEJANDROD','XXX','IT-002','66666','TRANS','AUTORIZA'
--CREATE PROCEDURE [dbo].[PR_IN_ACEPTAR_TRANSFERENCIA]
--	@PP_K_SISTEMA_EXE			INT,
--	@PP_K_USUARIO_ACCION		INT,
--	-- ===========================
--	@PP_USER_ACTION				VARCHAR(25),
--	@PP_PASSWORD				VARCHAR(50),
--	@PP_COMPUTER_NAME			VARCHAR(50),
--	@PP_JOB_NO					VARCHAR(10),
--	@PP_SCREEN					VARCHAR(50),
--	@PP_MOVIMIENTO				VARCHAR(50)
--AS
--DECLARE @VP_MENSAJE	VARCHAR(MAX)

--BEGIN TRANSACTION 
--BEGIN TRY
--	-- ///////////////////////////////////////////
--	--EXECUTE [dbo].[PG_SK_USUARIO_LOGIN] 'ALEJANDROD','111111'
--	--
--	--SELECT * FROM	USUARIO_PEARL

--	DECLARE @VP_USUARIO_EXISTE		INT

--	SELECT	@VP_USUARIO_EXISTE	=	K_USUARIO_PEARL
--	FROM	USUARIO_PEARL, USUARIO_TIPO
--	WHERE	D_USUARIO_PEARL=		@PP_USER_ACTION
--	AND		PASSWORD_USUARIO_PEARL=	@PP_PASSWORD
--	--=======================================================
--	AND		USUARIO_PEARL.K_USUARIO_TIPO=USUARIO_TIPO.K_USUARIO_TIPO


--	IF @VP_USUARIO_EXISTE	IN (86,132,140,162)			---,139)
--	BEGIN
--		DECLARE @VP_FECHA_INT    INT = FORMAT(CAST(GETDATE() AS DATE), N'yyyyMMdd');
--		DECLARE @VP_HORA_INT	INT = FORMAT(CAST(GETDATE() AS TIME(0)), N'hhmmss');

--			IF @PP_K_SISTEMA_EXE	= 0
--			BEGIN
--				INSERT INTO DATA_02Pruebas.DBO.PEARL_LOG
--				(	cdate,				ctime,				[user_name],
--					computer,			screen_opt,			jobno,
--					movement,			detail			)
--				VALUES
--				(	@VP_FECHA_INT,		@VP_HORA_INT,		@PP_USER_ACTION,
--					@PP_COMPUTER_NAME,	@PP_SCREEN,			@PP_JOB_NO,
--					@PP_MOVIMIENTO,		''		)

--				IF @@ROWCOUNT = 0
--				BEGIN
--					RAISERROR ('Registro no insertado.(TEST)', 16, 1 )
--				END
--			END
--			ELSE
--			BEGIN
--				INSERT INTO DATA_02.DBO.PEARL_LOG
--				(	cdate,				ctime,				[user_name],
--					computer,			screen_opt,			jobno,
--					movement,			detail			)
--				VALUES
--				(	@VP_FECHA_INT,		@VP_HORA_INT,		@PP_USER_ACTION,
--					@PP_COMPUTER_NAME,	@PP_SCREEN,			@PP_JOB_NO,
--					@PP_MOVIMIENTO,		''		)

--				IF @@ROWCOUNT = 0
--				BEGIN
--					RAISERROR ('Registro no insertado.(LIVE)', 16, 1 )
--				END
--			END
--	END
--	ELSE
--	BEGIN
--		RAISERROR ('Los datos del Usuario no son correctos o no tienes permisos para realizar la acción soilictada.', 16, 1 )
--	END


--	-- /////////////////////////////////////////////////////////////////////
--COMMIT TRANSACTION 
--END TRY

--BEGIN CATCH
--	/* Ocurrió un error, deshacemos los cambios*/ 
--	ROLLBACK TRANSACTION
--	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
--	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
--	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
--END CATCH
	
--	IF @VP_MENSAJE<>''
--		BEGIN
--			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
--		END

--	SELECT	@VP_MENSAJE AS MENSAJE, @PP_USER_ACTION AS CLAVE
--	-- //////////////////////////////////////////////////////////////
--GO
