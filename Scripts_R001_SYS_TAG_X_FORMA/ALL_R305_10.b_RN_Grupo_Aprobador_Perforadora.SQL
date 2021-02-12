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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_VALIDA_USUARIO_AUTORIZAR_PERFORADORA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_AUTORIZAR_PERFORADORA]
GO
--			EXEC [PG_RN_VALIDA_USUARIO_AUTORIZAR_PERFORADORA] 0,0, 3566
--			EXEC [PG_RN_VALIDA_USUARIO_AUTORIZAR_PERFORADORA] 0,0, 8022
--			EXEC [PG_RN_VALIDA_USUARIO_AUTORIZAR_PERFORADORA] 0,0, 13164
CREATE PROCEDURE [dbo].[PG_RN_VALIDA_USUARIO_AUTORIZAR_PERFORADORA]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_EMPLEADO_PEARL			INT
	-- ===========================		
AS
	DECLARE @VP_MENSAJE	VARCHAR(MAX)
BEGIN TRANSACTION
BEGIN TRY
	DECLARE  @VP_RESULTADO			VARCHAR(300) = '' 
			,@VP_EXISTE_EMPLEADO	INT
			,@VP_NM_EMPLEADO_PEARL	INT
	-- /////////////////////////////////////////////////////
	
	SELECT	@VP_EXISTE_EMPLEADO	= COUNT(EN_NUM_EMP)--* 
	--SELECT	* 
	FROM	HOWE.DBO.VISTA_GAFETES
	WHERE	EN_NUM_EMP			= @PP_EMPLEADO_PEARL
	--WHERE	EN_NUM_EMP			IN	(119,3566,5520,8186,9820,11811)
	
	-- /////////////////////////////////////////////////////
	IF @VP_EXISTE_EMPLEADO	<= 0
	BEGIN
		RAISERROR('No se encontró información para el usuario. Verifique y vuelva a intentar.',	16, 1 )
	END

	DECLARE @VP_TABLA_USUARIOS	TABLE
	(	K_EMPLEADO_PEARL	INT NOT NULL,
		AP_EMPLEADO_PEARL	VARCHAR(250),
		NM_EMPLEADO_PEARL	VARCHAR(250)
	)

	SET NOCOUNT ON
	INSERT INTO	@VP_TABLA_USUARIOS
	VALUES	(	119,		'TORRES',		'OSCAR'		),
			(	3566,		'MATA',			'MILTON'	),
			(	5520,		'PEREZ',		'NICOLAS'	),
			(	8186,		'LEDEZMA',		'LUZ'		),
			(	9820,		'PEREZ',		'MARY'		),
			(	11811,		'MARTINEZ',		'JOSUE'		)
	SET NOCOUNT OFF

	SELECT	@VP_NM_EMPLEADO_PEARL	= COUNT(K_EMPLEADO_PEARL)
	FROM	@VP_TABLA_USUARIOS
	WHERE	K_EMPLEADO_PEARL	= @PP_EMPLEADO_PEARL

	IF @VP_NM_EMPLEADO_PEARL<=0
	BEGIN
		RAISERROR('Usuario no Autorizado para realizar la acción. Verifique y vuelva a intentar.',	16, 1 )
	END	
	-- /////////////////////////////////////////////////////
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
	ELSE
	BEGIN
		SET	@VP_MENSAJE = ''
	END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_EMPLEADO_PEARL AS CLAVE
	-- /////////////////////////////////////////////////////
GO
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
