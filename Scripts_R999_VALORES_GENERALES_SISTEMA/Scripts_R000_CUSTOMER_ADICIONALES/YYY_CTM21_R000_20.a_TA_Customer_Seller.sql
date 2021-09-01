-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			CUSTOMER
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
--		20210831
--	TABLA NO AGREGADA AL SISTEMA, AÚN. AL PARECER NO ES TAN RELEVANTE
--	EN EL SISTEMA ACTUAL.
--	SELECT * FROM [ARCUSFIL_SELLER]

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ARCUSFIL_SELLER]') AND type in (N'U'))
	DROP TABLE [dbo].[ARCUSFIL_SELLER]
GO


-- ////////////////////////////////////////////////////////////////
-- //					ARCUSFIL_SELLER				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[ARCUSFIL_SELLER] (
	[K_ARCUSFIL_SELLER]				[INT]			NOT NULL,
	[D_ARCUSFIL_SELLER]				[VARCHAR](100)	NOT NULL,
	[C_ARCUSFIL_SELLER]				[VARCHAR](255)	NOT NULL,
	[S_ARCUSFIL_SELLER]				[VARCHAR](10)	NOT NULL,
	[O_ARCUSFIL_SELLER]				[INT]			NOT NULL,
	[L_ARCUSFIL_SELLER]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[ARCUSFIL_SELLER]
	ADD CONSTRAINT [PK_ARCUSFIL_SELLER]
		PRIMARY KEY CLUSTERED ([K_ARCUSFIL_SELLER])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ARCUSFIL_SELLER_01_DESCRIPCION] 
	   ON [dbo].[ARCUSFIL_SELLER] ( [D_ARCUSFIL_SELLER] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ARCUSFIL_SELLER]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ARCUSFIL_SELLER]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - ARCUSFIL_SELLER
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_ARCUSFIL_SELLER]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_ARCUSFIL_SELLER				INT,
	@PP_D_ARCUSFIL_SELLER				VARCHAR(100),
	@PP_C_ARCUSFIL_SELLER				VARCHAR(255),
	@PP_S_ARCUSFIL_SELLER				VARCHAR(10),
	@PP_O_ARCUSFIL_SELLER				INT,
	@PP_L_ARCUSFIL_SELLER				INT
AS				
	-- ===========================
	INSERT INTO ARCUSFIL_SELLER
			(	[K_ARCUSFIL_SELLER], [D_ARCUSFIL_SELLER], 
				[C_ARCUSFIL_SELLER], [S_ARCUSFIL_SELLER], 
				[O_ARCUSFIL_SELLER], [L_ARCUSFIL_SELLER]		)
	VALUES	
			(	@PP_K_ARCUSFIL_SELLER, @PP_D_ARCUSFIL_SELLER, 
				@PP_C_ARCUSFIL_SELLER, @PP_S_ARCUSFIL_SELLER,
				@PP_O_ARCUSFIL_SELLER, @PP_L_ARCUSFIL_SELLER	 )
GO

EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,01, 'AUSTRALIA',							'', 'AUS',			010	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,02, 'NORTH AMERICA',						'', 'NAM',			020	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,03, 'BMW',									'', 'BMW',			030	,1
EXECUTE [DBO].[PG_CI_ARCUSFIL_SELLER] 0,139,04, 'MISSING SALES PERSON KEEP!',			'', 'MSPKP!',		040	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,05, 'ASIA',									'', 'ASIA',			050	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,06, 'NEW ZEALAND',							'', 'NZ',			060	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,07, 'SOUTH AFRICA',							'', 'SA',			070	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,08, 'OTHER',								'', 'OTHR',			080	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,09, 'DISTINCTIVE USA',						'', 'DSTUSA',		090	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,10, 'LEAR THAILAND',						'', 'THLEAR',		100	,1
EXECUTE [dbo].[PG_CI_ARCUSFIL_SELLER] 0,139,11, 'JCI CHINA',							'', 'CNJCI',		110	,1
-- =================================================================================
GO
