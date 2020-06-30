-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	[BD_GENERAL]
-- // MODULO:			[ACCIONES EN FORMAS]
-- // OPERACION:		LIBERACION / STORED PROCEDURES
-- //////////////////////////////////////////////////////////////
-- // Autor:			FEG
-- // Fecha creación:	26/JUN/2020
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL] 
GO

-- //////////////////////////////////////////////////////////////






-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_SISTEMA_CONTROL_PERMISO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_SISTEMA_CONTROL_PERMISO]
GO
/*
	EXEC [PG_RN_SISTEMA_CONTROL_PERMISO] 0,64, 'frmHides', 'TextBox3', 1
*/
CREATE PROCEDURE [dbo].[PG_RN_SISTEMA_CONTROL_PERMISO]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================	
	@PP_FORMA					VARCHAR(100),
	@PP_BOTON					VARCHAR(50),
	@PP_TIPO_FORMA				INT -- #0 Principal #1 secundaria
	-- ===========================		
AS

	DECLARE @VP_RESULTADO		VARCHAR(300) = '' 
	
	-- /////////////////////////////////////////////////////
	/*
		SELECT * FROM SISTEMA_TAG  
		SELECT * FROM SUB_SISTEMA_TAG 
		select * from SISTEMA_CONTROL
		select * from SISTEMA_CONTROL_PERMISO

		--DELETE SISTEMA_CONTROL_PERMISO WHERE K_USUARIO = 144 AND K_SISTEMA_CONTROL = 2
	*/
	IF @PP_TIPO_FORMA = 0
		BEGIN
			IF NOT EXISTS(	SELECT	K_SISTEMA_CONTROL_PERMISO 
						FROM	SISTEMA_CONTROL_PERMISO
						INNER JOIN SISTEMA_CONTROL ON SISTEMA_CONTROL.K_SISTEMA_CONTROL = SISTEMA_CONTROL_PERMISO.K_SISTEMA_CONTROL
						INNER JOIN SISTEMA_TAG ON SISTEMA_TAG.K_SISTEMA_TAG = SISTEMA_CONTROL.K_SISTEMA_TAG
						WHERE	K_USUARIO = @PP_K_USUARIO_ACCION	
						AND		D_SISTEMA_TAG = @PP_FORMA
						AND		D_SISTEMA_CONTROL = @PP_BOTON
					)
				BEGIN
					SET @VP_RESULTADO =  'Usuario  <NO AUTORIZADO>...' 
				END
		END
	ELSE
		BEGIN
			IF NOT EXISTS(	SELECT	K_SISTEMA_CONTROL_PERMISO 
						FROM	SISTEMA_CONTROL_PERMISO
						INNER JOIN SISTEMA_CONTROL ON SISTEMA_CONTROL.K_SISTEMA_CONTROL = SISTEMA_CONTROL_PERMISO.K_SISTEMA_CONTROL
						INNER JOIN SUB_SISTEMA_TAG ON SUB_SISTEMA_TAG.K_SUB_SISTEMA_TAG = SISTEMA_CONTROL.K_SISTEMA_TAG
						WHERE	K_USUARIO = @PP_K_USUARIO_ACCION	
						AND		D_SUB_SISTEMA_TAG = @PP_FORMA
						AND		D_SISTEMA_CONTROL = @PP_BOTON
					)
				BEGIN
					SET @VP_RESULTADO =  'Usuario  <NO AUTORIZADO>...' 
				END
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
