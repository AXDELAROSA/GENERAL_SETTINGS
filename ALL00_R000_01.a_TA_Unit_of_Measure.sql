-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			ALL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200207
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02Pruebas]
GO

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UNIT_OF_MEASURE]') AND type in (N'U'))
	DROP TABLE [dbo].[UNIT_OF_MEASURE]
GO

-- //////////////////////////////////////////////////////////////
-- // UNIT_OF_MEASURE
-- // SE AGREGA TABLA PARA RELACIONAR UOM CON SU DESCRIPCIÓN
-- // CORRESPONDIENTE. ADEMÁS DE PERMITIR LA ACTUALIZACIÓN DE
-- // LOS REGISTROS EXISTENTES EN TODAS LAS TABLAS DESDE UNA 
-- // VISTA GENERAL.
-- //////////////////////////////////////////////////////////////
--	SELECT * FROM UNIT_OF_MEASURE

CREATE TABLE [dbo].[UNIT_OF_MEASURE] (
	[K_UNIT_OF_MEASURE]					[INT]				NOT NULL,
	[D_UNIT_OF_MEASURE]					[VARCHAR]	(250)	NOT NULL,
	[S_UNIT_OF_MEASURE]					[VARCHAR]	(10)	NOT NULL,
	[O_UNIT_OF_MEASURE]					[INT]				NOT NULL,
	[C_UNIT_OF_MEASURE]					[VARCHAR]	(500)	NOT NULL,
	[L_UNIT_OF_MEASURE]					[INT]				NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_UNIT_OF_MEASURE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_UNIT_OF_MEASURE]
GO

CREATE PROCEDURE [dbo].[PG_CI_UNIT_OF_MEASURE]
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_UNIT_OF_MEASURE		INT,
	@PP_D_UNIT_OF_MEASURE		VARCHAR(100),
	@PP_S_UNIT_OF_MEASURE		VARCHAR(10),
	@PP_O_UNIT_OF_MEASURE		INT,
	@PP_C_UNIT_OF_MEASURE		VARCHAR(255),
	@PP_L_UNIT_OF_MEASURE		INT
AS	
	-- ===============================
	DECLARE @VP_K_EXIST	INT

	SELECT	@VP_K_EXIST =	K_UNIT_OF_MEASURE
							FROM	UNIT_OF_MEASURE
							WHERE	K_UNIT_OF_MEASURE=@PP_K_UNIT_OF_MEASURE

	-- ===============================

	IF @VP_K_EXIST IS NULL
		INSERT INTO UNIT_OF_MEASURE	
			(	K_UNIT_OF_MEASURE,				D_UNIT_OF_MEASURE, 
				S_UNIT_OF_MEASURE,				O_UNIT_OF_MEASURE,
				C_UNIT_OF_MEASURE,
				L_UNIT_OF_MEASURE				)		
		VALUES	
			(	@PP_K_UNIT_OF_MEASURE,			@PP_D_UNIT_OF_MEASURE,	
				@PP_S_UNIT_OF_MEASURE,			@PP_O_UNIT_OF_MEASURE,
				@PP_C_UNIT_OF_MEASURE,
				@PP_L_UNIT_OF_MEASURE			)
	ELSE
		UPDATE	UNIT_OF_MEASURE
		SET		D_UNIT_OF_MEASURE	= @PP_D_UNIT_OF_MEASURE,	
				S_UNIT_OF_MEASURE	= @PP_S_UNIT_OF_MEASURE,			
				O_UNIT_OF_MEASURE	= @PP_O_UNIT_OF_MEASURE,
				C_UNIT_OF_MEASURE	= @PP_C_UNIT_OF_MEASURE,
				L_UNIT_OF_MEASURE	= @PP_L_UNIT_OF_MEASURE	
		WHERE	K_UNIT_OF_MEASURE=@PP_K_UNIT_OF_MEASURE

	-- =========================================================
GO

-- ===============================================
SET NOCOUNT ON
-- ===============================================

--EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE] 0, 0, 'NOT AVAILABLE!',		'??',   1,  '', 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE] 0, 1, 'EACHES',				'EA', 10, '', 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE] 0, 2, 'SQUARE METERS',		'SM', 20, '', 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE] 0, 3, 'SQUARE FEET',			'SF', 30, '', 1		
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_UNIT_OF_MEASURE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_UNIT_OF_MEASURE]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////