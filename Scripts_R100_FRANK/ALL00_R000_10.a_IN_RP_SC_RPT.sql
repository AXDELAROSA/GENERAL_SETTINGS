-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		[BD_GENERAL]
-- // MODULE:			
-- // OPERATION:		
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			FEG			
-- // CREATION DATE:	18/02/2020
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- ////SP APUNTA A LA BASE DE DATOS DE PRODUCCION
-- //////////////////////////////////////////////////////////////
			
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_RP_SC_PRT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_RP_SC_PRT]
GO


CREATE PROCEDURE [dbo].[PG_IN_RP_SC_PRT]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_TAG_NO					INT,
	@PP_TYPE					INT
AS

	DECLARE @VP_MENSAJE VARCHAR(255) = ''

	-- ///////////////////////////////////////////
	
	IF @VP_MENSAJE = ''
		BEGIN
			INSERT INTO DATA_02.DBO.RP_SC_PRT (
								TAG, TYPE	) 
				VALUES (	@PP_TAG_NO, @PP_TYPE)


			IF @@ROWCOUNT = 0
			SET @VP_MENSAJE = 'ERROR: // INSERT RP_SC_PRT  // '

		END
	-- /////////////////////////////////////////////////////////////////////

	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible insert el [FOLIO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#FOL.'+CONVERT(VARCHAR(10),@PP_TAG_NO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_TAG_NO AS CLAVE
	
	-- //////////////////////////////////////////////////////////////

	EXECUTE BD_GENERAL.[dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'INSERT',
													'',
													-- ===========================================
													'[IN]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													0, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_TAG_NO, '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- ////////////////////////////////////////////////////////////////////
GO






-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////