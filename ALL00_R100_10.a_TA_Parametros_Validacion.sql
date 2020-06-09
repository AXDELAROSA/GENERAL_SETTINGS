-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	BD_GENERAL
-- // MODULO:			FOLIOS TRANSACCION
-- // OPERACION:		LIBERACION / TABLAS
-- //////////////////////////////////////////////////////////////
-- // Autor:			FEG
-- // Fecha creación:	9/JUN/2020
-- ////////////////////////////////////////////////////////////// 

USE BD_GENERAL
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PARAMETRO_VALIDACION]') AND type in (N'U'))
	DROP TABLE [dbo].[PARAMETRO_VALIDACION]
GO


-- //////////////////////////////////////////////////////////////
-- // PARAMETRO_VALIDACION
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[PARAMETRO_VALIDACION] (
	[K_PARAMETRO_VALIDACION]	[INT]				NOT NULL,
	[D_PARAMETRO_VALIDACION]	[VARCHAR] (100)		NOT NULL,
	[S_PARAMETRO_VALIDACION]	[VARCHAR] (10)		NOT NULL,
	[VALOR_DECIMAL]				DECIMAL(8,4)		NOT NULL DEFAULT 0.00,
	[VALOR_ENTERO]				INT					NOT NULL DEFAULT 0,
	[VALOR_VARCHAR]				VARCHAR(255)		NOT NULL DEFAULT '',
	[O_PARAMETRO_VALIDACION]	[INT]				NOT NULL,
	[C_PARAMETRO_VALIDACION]	[VARCHAR] (255)		NOT NULL,
	[L_PARAMETRO_VALIDACION]	[INT]				NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[PARAMETRO_VALIDACION]
	ADD CONSTRAINT [PK_PARAMETRO_VALIDACION]
		PRIMARY KEY CLUSTERED ([K_PARAMETRO_VALIDACION])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_PARAMETRO_VALIDACION_01_DESCRIPCION] 
	   ON [dbo].[PARAMETRO_VALIDACION] ( [D_PARAMETRO_VALIDACION] )
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_PARAMETRO_VALIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_PARAMETRO_VALIDACION]
GO


CREATE PROCEDURE [dbo].[PG_CI_PARAMETRO_VALIDACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_PARAMETRO_VALIDACION		INT,
	@PP_D_PARAMETRO_VALIDACION		VARCHAR(100),
	@PP_S_PARAMETRO_VALIDACION		VARCHAR(10),
	@PP_VALOR_DECIMAL				DECIMAL(8,4),
	@PP_VALOR_ENTERO				INT,
	@PP_VALOR_VARCHAR				VARCHAR(255),
	@PP_O_PARAMETRO_VALIDACION		INT,
	@PP_C_PARAMETRO_VALIDACION		VARCHAR(255),
	@PP_L_PARAMETRO_VALIDACION		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_PARAMETRO_VALIDACION
							FROM	PARAMETRO_VALIDACION
							WHERE	K_PARAMETRO_VALIDACION=@PP_K_PARAMETRO_VALIDACION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO PARAMETRO_VALIDACION	
			(	K_PARAMETRO_VALIDACION,				D_PARAMETRO_VALIDACION, 
				S_PARAMETRO_VALIDACION,				VALOR_DECIMAL,
				VALOR_ENTERO,						VALOR_VARCHAR,
				O_PARAMETRO_VALIDACION,				C_PARAMETRO_VALIDACION,
				L_PARAMETRO_VALIDACION				)		
		VALUES	
			(	@PP_K_PARAMETRO_VALIDACION,			@PP_D_PARAMETRO_VALIDACION,	
				@PP_S_PARAMETRO_VALIDACION,			@PP_VALOR_DECIMAL,	
				@PP_VALOR_ENTERO,					@PP_VALOR_VARCHAR,
				@PP_O_PARAMETRO_VALIDACION,			@PP_C_PARAMETRO_VALIDACION,
				@PP_L_PARAMETRO_VALIDACION			)
	ELSE
		UPDATE	PARAMETRO_VALIDACION
		SET		D_PARAMETRO_VALIDACION	= @PP_D_PARAMETRO_VALIDACION,	
				S_PARAMETRO_VALIDACION	= @PP_S_PARAMETRO_VALIDACION,
				VALOR_DECIMAL			= @PP_VALOR_DECIMAL,
				VALOR_ENTERO			= @PP_VALOR_ENTERO,
				VALOR_VARCHAR			= @PP_VALOR_VARCHAR,			
				O_PARAMETRO_VALIDACION	= @PP_O_PARAMETRO_VALIDACION,
				C_PARAMETRO_VALIDACION	= @PP_C_PARAMETRO_VALIDACION,
				L_PARAMETRO_VALIDACION	= @PP_L_PARAMETRO_VALIDACION	
		WHERE	K_PARAMETRO_VALIDACION=@PP_K_PARAMETRO_VALIDACION

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_PARAMETRO_VALIDACION] 0, 0, 1, 'PORCENTAJE_MINIMO_BUENO',		'PTJ_MIN_BUE', 30, 0, '', 1, '', 1
EXECUTE [dbo].[PG_CI_PARAMETRO_VALIDACION] 0, 0, 2, 'PORCENTAJE_MINIMO_REGULAR',	'PTJ_MIN_REG', 30, 0, '', 1, '', 1
EXECUTE [dbo].[PG_CI_PARAMETRO_VALIDACION] 0, 0, 3, 'PORCENTAJE_MINIMO_MALO',		'PTJ_MIN_MAL', 30, 0, '', 1, '', 1

EXECUTE [dbo].[PG_CI_PARAMETRO_VALIDACION] 0, 0, 4, 'PORCENTAJE_MAXIMO_BUENO',		'PTJ_MAX_BUE', 35, 0, '', 1, '', 1
EXECUTE [dbo].[PG_CI_PARAMETRO_VALIDACION] 0, 0, 5, 'PORCENTAJE_MAXIMO_REGULAR',	'PTJ_MAX_REG', 35, 0, '', 1, '', 1
EXECUTE [dbo].[PG_CI_PARAMETRO_VALIDACION] 0, 0, 6, 'PORCENTAJE_MAXIMO_MALO',		'PTJ_MAX_MAL', 35, 0, '', 1, '', 1

EXECUTE [dbo].[PG_CI_PARAMETRO_VALIDACION] 0, 0, 7, 'SQF_EXTRA_MINIMO',				'SQF_EXT_MIN', 50, 0, '', 1, '', 1
EXECUTE [dbo].[PG_CI_PARAMETRO_VALIDACION] 0, 0, 8, 'SQF_EXTRA_MAXIMO',				'SQF_EXT_MAX', 100, 0, '', 1, '', 1
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================

GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
