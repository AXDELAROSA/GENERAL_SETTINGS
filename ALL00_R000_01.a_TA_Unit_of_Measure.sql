-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			ALL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200207
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UNIT_OF_MEASURE]') AND type in (N'U'))
	DROP TABLE [dbo].[UNIT_OF_MEASURE]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UNIT_CLASS]') AND type in (N'U'))
	DROP TABLE [dbo].[UNIT_CLASS]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CONVERT_UNIT_OF_MEASURE]') AND type in (N'U'))
	DROP TABLE [dbo].[CONVERT_UNIT_OF_MEASURE]
GO
-- ////////////////////////////////////////////////////////////////
-- //					CONVERT_UNIT_OF_MEASURE				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CONVERT_UNIT_OF_MEASURE] (
	[K_CONVERT_UNIT_OF_MEASURE]			[INT] IDENTITY (1,1) NOT NULL,
	[D_CONVERT_UNIT_OF_MEASURE]			[VARCHAR](100)	NOT NULL,
	[C_CONVERT_UNIT_OF_MEASURE]			[VARCHAR](255)	NOT NULL DEFAULT '',
	[S_CONVERT_UNIT_OF_MEASURE]			[VARCHAR](10)	NOT NULL,
	[O_CONVERT_UNIT_OF_MEASURE]			[INT]			NOT NULL DEFAULT 10,
	[L_CONVERT_UNIT_OF_MEASURE]			[INT]			NOT NULL DEFAULT 1,
	-- ===========================
	[K_UNIT_01]							[VARCHAR](100)	NOT NULL,
	[K_UNIT_02]							[VARCHAR](100)	NOT NULL,
	[TOTAL_CONVERT_PER_UNIT]			[DECIMAL](16,8)	NOT NULL,	-- TOTAL EN REALACIÓN [1 A 1] EJ: 1 in = 0.02778 yd
	[TOTAL_UNIT2_01]					[DECIMAL](16,2)	NOT NULL,
	[TOTAL_UNIT2_02]					[DECIMAL](16,2)	NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[CONVERT_UNIT_OF_MEASURE]
	ADD CONSTRAINT [PK_CONVERT_UNIT_OF_MEASURE]
		PRIMARY KEY CLUSTERED ([K_CONVERT_UNIT_OF_MEASURE])
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CONVERT_UNIT_OF_MEASURE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CONVERT_UNIT_OF_MEASURE]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - CONVERT_UNIT_OF_MEASURE
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_CONVERT_UNIT_OF_MEASURE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_D_CONVERT_UNIT_OF_MEASURE		VARCHAR(100),
	@PP_C_CONVERT_UNIT_OF_MEASURE		VARCHAR(255),
	@PP_S_CONVERT_UNIT_OF_MEASURE		VARCHAR(10),
	@PP_O_CONVERT_UNIT_OF_MEASURE		INT,
	@PP_L_CONVERT_UNIT_OF_MEASURE		INT,
	-- ===========================
	@PP_K_UNIT_01						INT,
	@PP_K_UNIT_02						INT,
	@PP_TOTAL_CONVERT_PER_UNIT			DECIMAL(16,5),
	@PP_TOTAL_UNIT2_03					DECIMAL(16,2),
	@PP_TOTAL_UNIT2_04					DECIMAL(16,2)
AS				
	-- ===========================
	
	INSERT INTO CONVERT_UNIT_OF_MEASURE
			(	[D_CONVERT_UNIT_OF_MEASURE]	,	[C_CONVERT_UNIT_OF_MEASURE]	,
				[S_CONVERT_UNIT_OF_MEASURE]	,	[O_CONVERT_UNIT_OF_MEASURE]	,
				[L_CONVERT_UNIT_OF_MEASURE]	,
				-- ===========================
				[K_UNIT_01]					,	[K_UNIT_02]					,
				[TOTAL_CONVERT_PER_UNIT]	,
				[TOTAL_UNIT2_01]			,	[TOTAL_UNIT2_02]				)
	VALUES	
			(	@PP_D_CONVERT_UNIT_OF_MEASURE,	@PP_C_CONVERT_UNIT_OF_MEASURE,	
				@PP_S_CONVERT_UNIT_OF_MEASURE,	@PP_O_CONVERT_UNIT_OF_MEASURE,		
				@PP_L_CONVERT_UNIT_OF_MEASURE,		
				-- ===========================
				@PP_K_UNIT_01				,	@PP_K_UNIT_02				,		
				@PP_TOTAL_CONVERT_PER_UNIT	,
				@PP_TOTAL_UNIT2_03			,	@PP_TOTAL_UNIT2_04				)		
		
	-- //////////////////////////////////////////////////////////////
GO

EXECUTE [dbo].[PG_CI_CONVERT_UNIT_OF_MEASURE]  0, 139,  'INCH-METER'	,'CONVERT INCH TO METER'		, 'in-mt'		,10 , 1, 5		,9	,0.02540,	1,10.7639
EXECUTE [dbo].[PG_CI_CONVERT_UNIT_OF_MEASURE]  0, 139,  'INCH-YARD'		,'CONVERT INCH TO YARD'			, 'in-yd'		,10 , 1, 5		,24	,0.0277778, 1,9
EXECUTE [dbo].[PG_CI_CONVERT_UNIT_OF_MEASURE]  0, 139,  'INCH-FT'		,'CONVERT INCH TO FEET'			, 'in-FT'		,10 , 1, 5		,2	,0.00694,	1,32
GO


-- ////////////////////////////////////////////////////////////////
-- //					UNIT_CLASS				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[UNIT_CLASS] (
	[K_UNIT_CLASS]				[INT]			NOT NULL,
	[D_UNIT_CLASS]				[VARCHAR](100)	NOT NULL,
	[C_UNIT_CLASS]				[VARCHAR](255)	NOT NULL,
	[S_UNIT_CLASS]				[VARCHAR](10)	NOT NULL,
	[O_UNIT_CLASS]				[INT]			NOT NULL,
	[L_UNIT_CLASS]				[INT]			NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[UNIT_CLASS]
	ADD CONSTRAINT [PK_UNIT_CLASS]
		PRIMARY KEY CLUSTERED ([K_UNIT_CLASS])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_UNIT_CLASS_01_DESCRIPCION] 
	   ON [dbo].[UNIT_CLASS] ( [D_UNIT_CLASS] )
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_UNIT_CLASS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_UNIT_CLASS]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - UNIT_CLASS
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_UNIT_CLASS]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_UNIT_CLASS			INT,
	@PP_D_UNIT_CLASS			VARCHAR(100),
	@PP_C_UNIT_CLASS			VARCHAR(255),
	@PP_S_UNIT_CLASS			VARCHAR(10),
	@PP_O_UNIT_CLASS			INT,
	@PP_L_UNIT_CLASS			INT
AS			
	
	-- ===========================

	INSERT INTO UNIT_CLASS
			(	[K_UNIT_CLASS], [D_UNIT_CLASS], 
				[C_UNIT_CLASS], [S_UNIT_CLASS], 
				[O_UNIT_CLASS], [L_UNIT_CLASS]		)
	VALUES	
			(	@PP_K_UNIT_CLASS, @PP_D_UNIT_CLASS, 
				@PP_C_UNIT_CLASS, @PP_S_UNIT_CLASS,
				@PP_O_UNIT_CLASS, @PP_L_UNIT_CLASS	)
		
	-- //////////////////////////////////////////////////////////////
GO

EXECUTE [dbo].[PG_CI_UNIT_CLASS]  0, 139,  0, '(TO DEFINE)'		,''	, '2DFNE', 10 , 1
EXECUTE [dbo].[PG_CI_UNIT_CLASS]  0, 139,  1, 'CAPACITY'		,''	, 'CAPAC', 10 , 1
EXECUTE [dbo].[PG_CI_UNIT_CLASS]  0, 139,  2, 'LENGTH'			,''	, 'LENGT', 10 , 1
EXECUTE [dbo].[PG_CI_UNIT_CLASS]  0, 139,  3, 'SURFACE'			,''	, 'SRFAC', 10 , 1
EXECUTE [dbo].[PG_CI_UNIT_CLASS]  0, 139,  4, 'VOLUME'			,''	, 'VOLUM', 10 , 1
EXECUTE [dbo].[PG_CI_UNIT_CLASS]  0, 139,  5, 'WEIGHT'			,''	, 'WEIGH', 10 , 1
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_UNIT_CLASS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_UNIT_CLASS]
GO


-- ////////////////////////////////////////////////////////////////
-- //					UNIT_OF_MEASURE				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[UNIT_OF_MEASURE] (
	[K_UNIT_OF_MEASURE]			[INT]			NOT NULL,
	[D_UNIT_OF_MEASURE]			[VARCHAR](100)	NOT NULL,
	[C_UNIT_OF_MEASURE]			[VARCHAR](255)	NOT NULL,
	[S_UNIT_OF_MEASURE]			[VARCHAR](10)	NOT NULL,
	[O_UNIT_OF_MEASURE]			[INT]			NOT NULL,
	[L_UNIT_OF_MEASURE]			[INT]			NOT NULL,
	-- ===========================
	[K_UNIT_CLASS]				[INT]			NOT NULL,
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[UNIT_OF_MEASURE]
	ADD CONSTRAINT [PK_UNIT_OF_MEASURE]
		PRIMARY KEY CLUSTERED ([K_UNIT_OF_MEASURE])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_UNIT_OF_MEASURE_01_DESCRIPCION] 
	   ON [dbo].[UNIT_OF_MEASURE] ( [D_UNIT_OF_MEASURE] )
GO

ALTER TABLE [dbo].[UNIT_OF_MEASURE] ADD 
	CONSTRAINT [FK_UNIT_CLASS_01] 
		FOREIGN KEY ( [K_UNIT_CLASS] ) 
		REFERENCES [dbo].[UNIT_CLASS] ( [K_UNIT_CLASS] )
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_UNIT_OF_MEASURE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_UNIT_OF_MEASURE]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - UNIT_OF_MEASURE
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_UNIT_OF_MEASURE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_UNIT_OF_MEASURE			INT,
	@PP_D_UNIT_OF_MEASURE			VARCHAR(100),
	@PP_C_UNIT_OF_MEASURE			VARCHAR(255),
	@PP_S_UNIT_OF_MEASURE			VARCHAR(10),
	@PP_O_UNIT_OF_MEASURE			INT,
	@PP_L_UNIT_OF_MEASURE			INT,
	-- ===========================
	@PP_K_UNIT_CLASS			INT
AS			
	
	-- ===========================

	INSERT INTO UNIT_OF_MEASURE
			(	[K_UNIT_OF_MEASURE], [D_UNIT_OF_MEASURE], 
				[C_UNIT_OF_MEASURE], [S_UNIT_OF_MEASURE], 
				[O_UNIT_OF_MEASURE], [L_UNIT_OF_MEASURE],
				[K_UNIT_CLASS]						)
	VALUES	
			(	@PP_K_UNIT_OF_MEASURE, @PP_D_UNIT_OF_MEASURE, 
				@PP_C_UNIT_OF_MEASURE, @PP_S_UNIT_OF_MEASURE,
				@PP_O_UNIT_OF_MEASURE, @PP_L_UNIT_OF_MEASURE,	
				@PP_K_UNIT_CLASS						)
		
	-- //////////////////////////////////////////////////////////////
GO
 --		1, 'CAPACITY'		 2, 'LENGTH'			 3, 'SURFACE'			 4, 'VOLUME'			 5, 'WEIGHT'			

EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  0, '(TO DEFINE)'	,''				, '2DFNE', 10 , 1, 0
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  1, 'CENTIMETRO		- CENTIMETER'	,'cm'		, 'cm', 10 , 1, 2
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  2, 'PIE				- FOOT'			,'ft'		, 'ft',  10 , 1, 2
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  3, 'GALÓN			- GALLON'		,'gal'		, 'gal', 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  4, 'GRAMO			- GRAM'			,'g'		, 'g' , 10 , 1, 5
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  5, 'PULGADA			- INCH'			,'in'		, 'inch',  10 , 1, 2
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  6, 'KILOGRAMO		- KILOGRAM'		,'kg'		, 'Kg', 10 , 1, 5
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  7, 'LITRO			- LITER'		,'L'		, 'L', 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  8, 'MILILITRO		- MILILITER'	,'ml'		, 'ml', 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  9, 'METRO			- METER'		,'m'		, 'm', 10 , 1, 2
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  10, 'ONZA			- OUNCE'		,'oz'		, 'oz', 10 , 1, 5
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  11, 'PIEZA			- PIECE'		,'pc'		, 'PIECE', 10 , 1, 0
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  12, 'LIBRA			- POUND'		,'lb'		, 'lb', 10 , 1, 5
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  13,'PIE CUADRADO	- SQ FOOT'		,'sqft'		, 'sqft',  10 , 1, 3
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  14, 'PULGADA CUADRADA- SQ INCH'	,'sqin'		, 'sqinch',  10 , 1, 3
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  15, 'SERVICIO		- SERVICE'		,'service'	, 'SERVI', 10 , 1, 0
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  16, 'BOX'							,'box'		, 'box'	 , 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  17, 'CAJA'							,'caja'		, 'caja' , 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  18, 'PACKAGE'						,'package'	, 'Package', 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  19, 'PAQUETE'						,'paquete'	, 'Paquet', 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  20, 'YARDA LÍNEAL'					,'LY'		, 'LY'   , 10 , 1, 3
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  21, 'ROLLO			- ROLL'			,'ROLL'		, 'Roll' , 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  22, 'CUBETA'						,'CUBETA'	, 'Cubeta', 10 , 1, 1
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  24, 'YARDA			- YARD'			,'Y'		, 'yd'   , 10 , 1, 3
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  25, 'YARDA CUADRADA- SQ YARD'		,'Y'		, 'sqyd'   , 10 , 1, 3
EXECUTE [dbo].[PG_CI_UNIT_OF_MEASURE]  0, 139,  26, 'METRO CUADRADO - SQ METER'	,'m2'		, 'm2', 10 , 1, 2

GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////