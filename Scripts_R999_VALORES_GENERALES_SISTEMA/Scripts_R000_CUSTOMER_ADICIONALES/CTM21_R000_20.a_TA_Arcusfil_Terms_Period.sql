-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			CUSTOMER
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
--		20210831
--	SE MIGRÓ LA INFORMACIÓN DE LA TABLA, DE DATA_02 A BD_GENERAL.	(20210831)
--	SELECT * FROM [ARCUSFIL_TERMS_PERIOD]

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ARCUSFIL_TERMS_PERIOD]') AND type in (N'U'))
	DROP TABLE [dbo].[ARCUSFIL_TERMS_PERIOD]
GO
-- ////////////////////////////////////////////////////////////////
-- //					ARCUSFIL_TERMS_PERIOD				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[ARCUSFIL_TERMS_PERIOD] (
	[K_ARCUSFIL_TERMS_PERIOD]				[INT]			NOT NULL,
	[D_ARCUSFIL_TERMS_PERIOD]				[VARCHAR](100)	NOT NULL,
	[C_ARCUSFIL_TERMS_PERIOD]				[VARCHAR](255)	NOT NULL,
	[S_ARCUSFIL_TERMS_PERIOD]				[VARCHAR](10)	NOT NULL,
	[O_ARCUSFIL_TERMS_PERIOD]				[INT]			NOT NULL,
	[L_ARCUSFIL_TERMS_PERIOD]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[ARCUSFIL_TERMS_PERIOD]
	ADD CONSTRAINT [PK_ARCUSFIL_TERMS_PERIOD]
		PRIMARY KEY CLUSTERED ([K_ARCUSFIL_TERMS_PERIOD])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ARCUSFIL_TERMS_PERIOD_01_DESCRIPCION] 
	   ON [dbo].[ARCUSFIL_TERMS_PERIOD] ( [D_ARCUSFIL_TERMS_PERIOD] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - ARCUSFIL_TERMS_PERIOD
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_ARCUSFIL_TERMS_PERIOD				INT,
	@PP_D_ARCUSFIL_TERMS_PERIOD				VARCHAR(100),
	@PP_C_ARCUSFIL_TERMS_PERIOD				VARCHAR(255),
	@PP_S_ARCUSFIL_TERMS_PERIOD				VARCHAR(10),
	@PP_O_ARCUSFIL_TERMS_PERIOD				INT,
	@PP_L_ARCUSFIL_TERMS_PERIOD				INT
AS				
	-- ===========================
	INSERT INTO ARCUSFIL_TERMS_PERIOD
			(	[K_ARCUSFIL_TERMS_PERIOD], [D_ARCUSFIL_TERMS_PERIOD], 
				[C_ARCUSFIL_TERMS_PERIOD], [S_ARCUSFIL_TERMS_PERIOD], 
				[O_ARCUSFIL_TERMS_PERIOD], [L_ARCUSFIL_TERMS_PERIOD]		)
	VALUES	
			(	@PP_K_ARCUSFIL_TERMS_PERIOD, @PP_D_ARCUSFIL_TERMS_PERIOD, 
				@PP_C_ARCUSFIL_TERMS_PERIOD, @PP_S_ARCUSFIL_TERMS_PERIOD,
				@PP_O_ARCUSFIL_TERMS_PERIOD, @PP_L_ARCUSFIL_TERMS_PERIOD	 )
GO

EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	00, '( TO DEFINE )',				'----'		, '--'		,000	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	01, '5 DAYS',						'5DAYS'		, '5'		,010	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	02, '7 DAYS ',						'7DAYS'		, '7'		,020	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	03, '10 DAYS',						'10DAYS'	, '10'		,030	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	04, '14 DAYS',						'14DAYS'	, '14'		,040	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	05, '15 DAYS',						'15DAYS'	, '15'		,050	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	06, '25 DAYS',						'25DAYS'	, '25'		,060	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	07, '30 DAYS',						'30DAYS'	, '30'		,070	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	08, '40 DAYS',						'40DAYS'	, '40'		,080	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	09, '45 DAYS',						'45DAYS'	, '45'		,090	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	10, '50 DAYS',						'50DAYS'	, '50'		,100	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	12, '60 DAYS',						'60DAYS'	, '60'		,120	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	13, '64 DAYS',						'64DAYS'	, '64'		,130	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	14, 'CSH AGAINST DOC',				'CAD'		, 'CAD'		,140	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_TERMS_PERIOD] 0,0,	15, 'CASH ON DELIVER',				'COD'		, 'COD'		,150	,1
-- =================================================================================
GO