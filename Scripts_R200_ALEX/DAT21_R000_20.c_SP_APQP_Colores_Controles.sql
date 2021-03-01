-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		BD_GENERAL
-- // MODULE:			APQP_MODEL
-- // OPERATION:		SP
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210219
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_APQP_COLOR_CONTROL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_APQP_COLOR_CONTROL]
GO
--		 EXECUTE [dbo].[PG_SK_APQP_COLOR_CONTROL] 0,139,'TEAM'
CREATE PROCEDURE [dbo].[PG_SK_APQP_COLOR_CONTROL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_CONTROL						VARCHAR(200)
AS
--		COLORES QUE NO SE DEBEN UTILIZAR POR LOS TEMAS DE INFRAGISTICS.
--		GRIS CLARO, NEGRO, VERDE LIMON, VERDE CLARO, PALEGREEN, AZUL MARINO, GRIS RATA, CAFÉ,  ROJO, AZUL CLARO
	DECLARE  @VP_BACK				VARCHAR(300) = ''
			,@VP_FORE				VARCHAR(300) = ''
	-- =========================================	-- =========================================
		-- //////////////////////////////////////////////////////////////	
	IF @PP_CONTROL	= 'INDX' 
	BEGIN
		SET @VP_BACK	= 'GOLD'
		SET @VP_FORE	= 'BLACK'
	END	

	ELSE IF @PP_CONTROL	= 'TEAM' 
	BEGIN
		SET @VP_BACK	= 'CORNFLOWERBLUE'
		SET @VP_FORE	= 'WHITE'
	END	
	
	ELSE IF @PP_CONTROL	= 'TOOL' 
	BEGIN
		SET @VP_BACK	= 'PALEGOLDENROD'
		SET @VP_FORE	= 'BLACK'
	END	

	ELSE IF @PP_CONTROL	= 'QUAL' 
	BEGIN
		SET @VP_BACK	= 'SEAGREEN'
		SET @VP_FORE	= 'WHITE'
	END	
	
	ELSE IF @PP_CONTROL	= 'FLOOR' 
	BEGIN
		SET @VP_BACK	= 'SANDYBROWN'
		SET @VP_FORE	= 'BLACK'
	END	
	
	ELSE IF @PP_CONTROL	= 'FLOW' 
	BEGIN
		SET @VP_BACK	= 'THISTLE'
		SET @VP_FORE	= 'BLACK'
	END	

	ELSE IF @PP_CONTROL	= 'PFMEA' 
	BEGIN
		SET @VP_BACK	= 'YELLOW'
		SET @VP_FORE	= 'BLACK'
	END	

	ELSE IF @PP_CONTROL	= 'CONTROL' 
	BEGIN
		SET @VP_BACK	= 'VIOLET'
		SET @VP_FORE	= 'BLACK'
	END	
		
	ELSE IF @PP_CONTROL	= 'RISK' 
	BEGIN
		SET @VP_BACK	= 'TOMATO'
		SET @VP_FORE	= 'BLACK'
	END	
	
	SELECT @VP_BACK	AS BACK, @VP_FORE AS FORE
	-- //////////////////////////////////////////////////////////////	
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////