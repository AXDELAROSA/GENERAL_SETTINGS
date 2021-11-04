-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		ALL
-- // MODULE:			USUARIOS_PERMISOS
-- // OPERATION:		SP
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200323
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- SELECT * FROM PERMISO_BOTON			
-- SELECT * FROM USUARIO_PERMISOS
-- SELECT * FROM USUARIO_PEARL
-- SELECT * FROM USUARIO_TIPO
-- //////////////////////////////////////////////////////////////

--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PERMISO_BOTON]') AND type in (N'U'))
--	DROP TABLE [dbo].[PERMISO_BOTON]
--GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIO_PERMISOS]') AND type in (N'U'))
	DROP TABLE [dbo].[USUARIO_PERMISOS]
GO

--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIO_FORANEO]') AND type in (N'U'))
--	DROP TABLE [dbo].[USUARIO_FORANEO]
--GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIO_PEARL]') AND type in (N'U'))
	DROP TABLE [dbo].[USUARIO_PEARL]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIO_TIPO]') AND type in (N'U'))
	DROP TABLE [dbo].[USUARIO_TIPO]
GO



-- //////////////////////////////////////////////////////////////
-- // USUARIO_TIPO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[USUARIO_TIPO] (
	[K_USUARIO_TIPO]	[INT] NOT NULL,
	[D_USUARIO_TIPO]	[VARCHAR] (100) NOT NULL,
	[S_USUARIO_TIPO]	[VARCHAR] (10) NOT NULL,
	[O_USUARIO_TIPO]	[INT] NOT NULL,
	[C_USUARIO_TIPO]	[VARCHAR] (255) NOT NULL,
	[L_USUARIO_TIPO]	[INT] NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[USUARIO_TIPO]
	ADD CONSTRAINT [PK_USUARIO_TIPO]
		PRIMARY KEY CLUSTERED ([K_USUARIO_TIPO])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_USUARIO_TIPO_01_DESCRIPCION] 
	   ON [dbo].[USUARIO_TIPO] ( [S_USUARIO_TIPO] )
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_TIPO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO_TIPO]
GO

CREATE PROCEDURE [dbo].[PG_CI_USUARIO_TIPO]
	@PP_K_USUARIO_TIPO		[INT],
	@PP_D_USUARIO_TIPO		[VARCHAR](100),
	@PP_S_USUARIO_TIPO		[VARCHAR](10),
	@PP_O_USUARIO_TIPO		[INT],
	@PP_C_USUARIO_TIPO		[VARCHAR](255),
	@PP_L_USUARIO_TIPO		[INT]
AS
	-- ===============================
	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_USUARIO_TIPO
							FROM	USUARIO_TIPO
							WHERE	K_USUARIO_TIPO=@PP_K_USUARIO_TIPO
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO USUARIO_TIPO
			(	K_USUARIO_TIPO,			D_USUARIO_TIPO, 
				S_USUARIO_TIPO,			O_USUARIO_TIPO,
				C_USUARIO_TIPO,
				L_USUARIO_TIPO			)		
		VALUES	
			(	@PP_K_USUARIO_TIPO,		@PP_D_USUARIO_TIPO,	
				@PP_S_USUARIO_TIPO,		@PP_O_USUARIO_TIPO,
				@PP_C_USUARIO_TIPO,
				@PP_L_USUARIO_TIPO		)
	ELSE
		UPDATE	USUARIO_TIPO
		SET		D_USUARIO_TIPO	= @PP_D_USUARIO_TIPO,	
				S_USUARIO_TIPO	= @PP_S_USUARIO_TIPO,			
				O_USUARIO_TIPO	= @PP_O_USUARIO_TIPO,
				C_USUARIO_TIPO	= @PP_C_USUARIO_TIPO,
				L_USUARIO_TIPO	= @PP_L_USUARIO_TIPO	
		WHERE	K_USUARIO_TIPO=@PP_K_USUARIO_TIPO
	-- =========================================================
GO

SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_USUARIO_TIPO] 00, '(SIN-TIPO)',				'( S/T )',	00 , '#00 // (SIN-TIPO)'	, 1
EXECUTE [dbo].[PG_CI_USUARIO_TIPO] 10, 'ADMINISTRADOR NIVEL 1',		'A1',	10 , '#10 // A1'				, 1
EXECUTE [dbo].[PG_CI_USUARIO_TIPO] 20, 'ADMINISTRADOR NIVEL 2',		'A2',	20 , '#20 // A2'				, 1
EXECUTE [dbo].[PG_CI_USUARIO_TIPO] 30, 'USUARIO GENERAL',			'U',	30 , '#30 // U'					, 1
EXECUTE [dbo].[PG_CI_USUARIO_TIPO] 40, 'USUARIO BASICO NIVEL 1',	'U1',	40 , '#40 // U1'				, 1
EXECUTE [dbo].[PG_CI_USUARIO_TIPO] 50, 'USUARIO BASICO NIVEL 2',	'U2',	50 , '#50 // U2'				, 1

GO
-- ===============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_TIPO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO_TIPO]
GO
-- ===============================================


-- //////////////////////////////////////////////////////////////
-- // USUARIO_PEARL
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[USUARIO_PEARL] (
	[K_USUARIO_PEARL]			[INT] NOT NULL,
	-- ========================================
	[D_USUARIO_PEARL]			[VARCHAR] (100) NOT NULL,
	-- ========================================
	[NOMBRE]					[VARCHAR] (100) NULL,
	[APELLIDO_PATERNO]			[VARCHAR] (100) NULL,
	[APELLIDO_MATERNO]			[VARCHAR] (100) NULL,
	-- ========================================
	[CORREO_USUARIO_PEARL]		[VARCHAR] (100) DEFAULT '',
	[PASSWORD_USUARIO_PEARL]	[VARCHAR] (15) NOT NULL,
	[TEMA_USUARIO_PEARL]		[VARCHAR] (30) DEFAULT 'Flat Nature.isl',
	-- ========================================
	[K_USUARIO_DEPARTAMENTO]	[INT] NOT NULL,
	[K_USUARIO_TIPO]			[INT] DEFAULT 30,
	[K_EMPLEADO_PEARL]			[INT] NOT NULL,
	-- ========================================
	--[L_USUARIO_PEARL]			[INT] NOT NULL DEFAULT 1
	--[L_CORREO_PEARL]			[INT] NOT NULL,
	--[C_USUARIO_PEARL]			[VARCHAR] (255) DEFAULT '',
	-- ========================================
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[USUARIO_PEARL]
	ADD CONSTRAINT [PK_USUARIO_PEARL]
		PRIMARY KEY CLUSTERED ([K_USUARIO_PEARL])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_USUARIO_PEARL_01_DESCRIPCION] 
	   ON [dbo].[USUARIO_PEARL] ( [D_USUARIO_PEARL] )
GO

ALTER TABLE [dbo].[USUARIO_PEARL]
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL DEFAULT 139,
			[F_ALTA]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL DEFAULT 139,
			[F_CAMBIO]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
			[L_BORRADO]						[INT]		NOT NULL DEFAULT 0,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO

ALTER TABLE [dbo].[USUARIO_PEARL]
	ADD		[K_CLASE_DEPARTAMENTO]			[INT]		NOT NULL DEFAULT 0
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO_PEARL]
GO

CREATE PROCEDURE [dbo].[PG_CI_USUARIO_PEARL]
	@PP_K_USUARIO_PEARL				INT,
	-- ========================================
	@PP_D_USUARIO_PEARL				VARCHAR (100),
	-- ========================================
	@PP_NOMBRE						VARCHAR (100),
	@PP_APELLIDO_PATERNO			VARCHAR (100),
	@PP_APELLIDO_MATERNO			VARCHAR (100),
	-- ========================================
	@PP_PASSWORD_USUARIO_PEARL		VARCHAR (15) ,
	@PP_CORREO_USUARIO_PEARL		VARCHAR (50),
	@PP_K_USUARIO_DEPTO				INT,
	@PP_K_USUARIO_TIPO				INT,
	@PP_TEMA_USUARIO_PEARL			VARCHAR(50),
	-- ========================================
	@PP_K_EMPLEADO_PEARL			INT,
--	@PP_C_USUARIO_PEARL				VARCHAR(100),
	@PP_L_USUARIO_PEARL				INT,
	@PP_L_BORRADO					INT
	-- ========================================
--	@PP_L_CORREO_PEARL				INT
AS
	-- ===============================
	--DECLARE @VP_K_EXISTE	INT

	--SELECT	@VP_K_EXISTE =	K_USUARIO_PEARL
	--						FROM	USUARIO_PEARL
	--						WHERE	K_USUARIO_PEARL=@PP_K_USUARIO_PEARL
	---- ===============================
	--IF @VP_K_EXISTE IS NULL
		INSERT INTO USUARIO_PEARL
			(	[K_USUARIO_PEARL]			,
				-- =========================
				[D_USUARIO_PEARL]			,
				-- =========================
				[NOMBRE]					,
				[APELLIDO_PATERNO]			,
				[APELLIDO_MATERNO]			,
				-- =========================
				[PASSWORD_USUARIO_PEARL]	,				[CORREO_USUARIO_PEARL]		,
				[K_USUARIO_DEPARTAMENTO]	,				[K_USUARIO_TIPO]			,
				[TEMA_USUARIO_PEARL]		,
				-- =========================
				[K_EMPLEADO_PEARL]			,				--[C_USUARIO_PEARL]			,
				--[L_USUARIO_PEARL]			,				
				[L_BORRADO]					)
--				[L_CORREO_PEARL]			)		
		VALUES	
			(	@PP_K_USUARIO_PEARL			,	
				-- =============================
				@PP_D_USUARIO_PEARL			,	
				-- =============================
				@PP_NOMBRE					,
				@PP_APELLIDO_PATERNO		,
				@PP_APELLIDO_MATERNO		,
				-- ========================================
				@PP_PASSWORD_USUARIO_PEARL	,				@PP_CORREO_USUARIO_PEARL		,
				@PP_K_USUARIO_DEPTO			,				@PP_K_USUARIO_TIPO				,
				@PP_TEMA_USUARIO_PEARL		,	
				-- =============================
				@PP_K_EMPLEADO_PEARL		,				--@PP_C_USUARIO_PEARL			,
				--@PP_L_USUARIO_PEARL			,				
				@PP_L_BORRADO					)
--				@PP_L_CORREO_PEARL	)
--	ELSE
--		UPDATE	USUARIO_PEARL
--		SET		[K_USUARIO_PEARL]			= @PP_K_USUARIO_PEARL		,		
--				-- ========================== -- =============================
--				[D_USUARIO_PEARL]			= @PP_D_USUARIO_PEARL		,		
--				-- ========================== -- =============================
--				[PASSWORD_USUARIO_PEARL]	= @PP_PASSWORD_USUARIO_PEARL,		
--				[CORREO_USUARIO_PEARL]		= @PP_CORREO_USUARIO_PEARL	,	
--				[K_USUARIO_DEPARTAMENTO]	= @PP_K_USUARIO_DEPTO		,		
--				[K_USUARIO_TIPO]			= @PP_K_USUARIO_TIPO		,	
--				[TEMA_USUARIO_PEARL]		= @PP_TEMA_USUARIO_PEARL	,		
--				-- ========================== -- =============================
--				[K_EMPLEADO_PEARL]			= @PP_K_EMPLEADO_PEARL		,	
----				[C_USUARIO_PEARL]			= @PP_C_USUARIO_PEARL		,		
--				[L_USUARIO_PEARL]			= @PP_L_USUARIO_PEARL		,
--				[L_BORRADO]					= @PP_L_BORRADO
--		WHERE	K_USUARIO_PEARL=@PP_K_USUARIO_PEARL
	-- =========================================================
GO

SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 41, 'RAFAELF', 'RAFAEL','FIERRO','MASCORRO','killer' , 'RAFAELF@PEARLLEATHER.COM.MX' , 7,30,'Red Planet.isl',6142,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 42, 'OMARD', 'OMAR ALBERTO','DECENA','MARTINEZ','12340' , 'OMARD@PEARLLEATHER.COM.MX' , 12,20,'Red Planet.isl',181,1,0				--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 43, 'JORGEH', 'JORGE FELIPE','HOLGUIN','NAVA','jorgeh' , 'JORGEH@PEARLLEATHER.COM.MX' , 9,50,'Flat Nature.isl',52,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 44, 'GUILLERMOM', 'GUILLERMO ALFONSO','MATA','RODRIGUEZ','nicole' , 'GUILLERMOM@PEARLLEATHER.COM.MX' , 6,40,'Flat Nature.isl',22,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 45, 'PEDROV', 'PEDRO','VARGAS','FRAGOSO','Saver10*' , 'PEDROV@PEARLLEATHER.COM.MX' , 3,40,'Red Planet.isl',999,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 47, 'MIGUELC', 'JESUS MIGUEL','CARRASCO','ORTIZ','Dalica9905' , 'MIGUELC@PEARLLEATHER.COM.MX' , 4,20,'Flat Nature.isl',1299,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 48, 'IVAND', 'IVAN ANDRES','DECENA','MARTINEZ','5623' , 'IVAND@PEARLLEATHER.COM.MX' , 4,30,'IG Style.isl',2091,1,0				--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 49, 'OSCART', 'OSCAR OMAR','TORRES','BUGARIN','7890' , 'OSCART@PEARLLEATHER.COM.MX' , 2,30,'Natilus.isl',10901,1,0				--,1
--EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 51, 'RECIBO1', '12345' , 'PEDROA' , 0,30,'IG Style.isl',0,'recibo',1,0,1
--EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 52, 'RECIBO2', '12340' , 'PEDROA' , 0,30,'The Blues.isl',0,'recibo',1,0,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 54, 'GILBERTOV', 'GILBERTO','VAZQUEZ','RAMIREZ','Alexander1' , 'GILBERTOV@PEARLLEATHER.COM.MX' , 1,40,'Red Planet.isl',6898,1,0 --,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 56, 'MANUELG', 'MANUEL MAURILIO','GARCIA','ORTIZ','Mangar83' , 'MANUELG@PEARLLEATHER.COM.MX' , 3,50,'Flat Nature.isl',4475,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 57, 'FABIOLAG', 'ALEXIS FABIOLA','GERARDO','AREVALO','fabiola' , 'FABIOLAG@PEARLLEATHER.COM.MX' , 8,30,'Flat Nature.isl',7658,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 58, 'DIANAS', 'DIANA JANNET','SALAS','TOVAR','1604' , '' , 3,30,'Flat Nature.isl',10151,1,0				--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 59, 'ALEJANDROP', 'ALEJANDRO','PEREZ','REYES','alex' , 'EMBARQUES1@PEARLLEATHER.COM.MX' , 3,30,'Flat Nature.isl',6176,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 60, 'ADRIANAD', 'ADRIANA','DE LA REE','DOMINGUEZ','adriana' , 'ADRIANAD@PEARLLEATHER.COM.MX' , 8,30,'Flat Nature.isl',67,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 62, 'PATRICIAC', 'MARTHA PATRICIA','CHAVEZ','VARGAS','mebi1625' , 'PATRICIAC@PEARLLEATHER.COM.MX' , 1,30,'Flat Nature.isl',7945,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 63, 'LUISP', '','','','luis' , 'LUISP@PEARLLEATHER.COM.MX' , 0,40,'IG Style.isl',0,1,1					--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 64, 'LEONORH', 'LEONOR ADRIANA','HERNANDEZ','MARTINEZ','12340' , 'LEONORH@PEARLLEATHER.COM.MX' , 2,30,'Red Planet.isl',7549,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 66, 'KARENE', 'KAREN SELENE','ESPINOZA','RANGEL','200816' , 'RECIBO@PEARLLEATHER.COM.MX' , 3,30,'Red Planet.isl',10382,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 67, 'GASPARH', 'GASPAR','HINOJOS','HERNANDEZ','12345' , 'GASPARH@PEARLLEATHER.COM.MX' , 2,30,'The Blues.isl',5628,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 68, 'ARMIDAH', 'ARMIDA','HERNANDEZ','RIVERA','2878' , 'ARMIDAH@PEARLLEATHER.COM.MX' , 2,30,'Flat Nature.isl',7041,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 69, 'MARIAS', 'MARIA DE LA LUZ','SOSA','SEDANO','12345' , 'MARIAS@PEARLLEATHER.COM.MX' , 8,30,'Flat Nature.isl',4158,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 70, 'FERNANDOG', 'FERNANDO','GARCIA','ANTE','ferny' , 'FERNANDOG@PEARLLEATHER.COM.MX' , 3,40,'Red Planet.isl',8464,1,0		--,1
--EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 71, 'NAVIDR', 'kgi01!' , 'NAVID@RACHMANTECH.COM' , 0,30,'Flat Nature.isl',-1,'USUARIO MAGNA',1,0,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 72, 'ROXANAL', 'ROXANA EDITH','LARA','AMADOR','123789' , '' , 4,40,'The Blues.isl',11879,1,0				--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 73, 'YAMILEXQ', '','','','1234' , 'YAMILEXQ@PEARLLEATHER.COM.MX' , 0,30,'Flat Nature.isl',0,1,1			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 75, 'KARENA', 'KAREN MICHELLE','APOLONIO','SOTO','102' , 'KARENA@PEARLLEATHER.COM.MX' , 4,30,'Noir Moderne.isl',12769,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 77, 'GENAROH', 'GENARO','HERNANDEZ','SANCHEZ','12345' , 'EMBARQUES1@PEARLLEATHER.COM.MX' , 3,30,'Flat Nature.isl',4880,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 82, 'DANAC', 'DANA YARETH','CONDE','MENDEZ','2697' , 'CERTI@PEARLLEATHER.COM.MX' , 4,30,'Flat Nature.isl',10054,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 83, 'MARIANAC', '','','','1986' , 'CERTI@PEARLLEATHER.COM.MX' , 0,30,'Red Planet.isl',0,1,1				--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 86, 'JORGEO', 'JORGE OLEGARIO','MIGUEL','LOPEZ','calidad.30' , 'JOLEGARIO@PEARLLEATHER.COM.MX' , 4,30,'Flat Nature.isl',3589,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 87, 'DIANAN', 'DIANA CECILIA','NAVARRETE','MARTINEZ','Facturas1' , 'DIANAN@PEARLLEATHER.COM.MX' , 3,40,'Red Planet.isl',10221,1,0		--,1
--EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 88, 'SISTEMAS', 'm@ster++' , 'SISTEMAS' , 0,30,'Red Planet.isl',0,'sistemas',1,0,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 89, 'VIVIANAC', 'VIVIANA ANGELICA','CHAVEZ','ZUNIGA','123450' , 'VIVIANC@PEARLLEATHER.COM.MX' , 4,30,'Flat Nature.isl',8242,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 90, 'TANIAC', 'TANIA ELIZABETH','CRUZ','HERNANDEZ','1726' , 'RECIBO@PEARLLEATHER.COM.MX' , 3,30,'Black Style.isl',10209,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 92, 'JOSES', 'JOSE LUIS','SANCHEZ','CORDOVA','jose48320031' , 'JOSES@PEARLLEATHER.COM.MX' , 2,30,'IG Style.isl',13253,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 93, 'MARIAR', '','','','12345' , 'MARIAR@PEARLLEATHER.COM.MX' , 0,30,'Natilus.isl',0,1,1					--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 94, 'FRANCISCOM','FRANCISCO GABRIEL','MORALES','LOPEZ','cuarris987' , '' , 2,30,'IG Style.isl',13189,1,0			--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 96, 'SANTOSR', 'SANTOS JESUS','REYES','CASTRO','12345' , 'SANTOSR@PEARLLEATHER.COM.MX' , 2,30,'IG Style.isl',13005,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 97, 'ELENAR', '','','','1234' , 'ELENAR@PEARLLEATHER.COM.MX' , 0,30,'IG Style.isl',0,1,1					--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 98, 'MONICAG', 'MONICA ESTEFANIA','GABINO','GARCIA','7410' , 'RECIBO@PEARLLEATHER.COM.MX' , 3,30,'Red Planet.isl',10569,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 101, 'LEYVERR', '','','','193105' , '' , 0,30,'Red Planet.isl',0,1,1					--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 102, 'EDGARA', 'EDGAR MANUEL','ARMIJO','CAMPOS','12345' , '' , 4,30,'Flat Nature.isl',10222,1,0				--,0
--EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 103, 'SUPERVISOR', 'super10' , 'XX' , 0,30,'Flat Nature.isl',0,'supervisor',1,0,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 108, 'VICTORC', 'VICTOR MANUEL','CHONTAL','GALLEGOS','Password1' , 'VICTORC@PEARLLEATHER.COM.MX' , 12,30,'Flat Nature.isl',5913,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 109, 'ASIFUENTES', 'JOSE ALBERTO','SIFUENTES','ROJAS','1234' , 'ALBERTOS@PEARLLEATHER.COM.MX' , 5,30,'Red Planet.isl',11258,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 110, 'FRAYJ', '','','','1234' , 'FRAYJ@PEARLLEATHER.COM.MX' , 0,30,'The Blues.isl',0,1,1					--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 111, 'ADRIANAI', 'ADRIANA','IBARRA','PRIETO','12345' , 'ADRIANAI@PEARLLEATHER.COM.MX' , 4,30,'Natilus.isl',11476,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 112, 'ALMAZ', '','','','123' , '' , 0,30,'Mistic Brown.isl',0,1,1					--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 113, 'ERNESTOG', '','','','*eder0607' , 'ERNESTOG@PEARLLEATHER.COM.MX' , 0,50,'black.isl',0,1,1			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 114, 'JOSUEC', '','','','Password1' , 'JOSUEC@PEARLLEATHER.COM.MX' , 0,40,'Noir Moderne.isl',0,1,1		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 115, 'SONIAO', 'SONIA YADIRA','ORTIZ','TORRES','12340' , 'SONIAO@PEARLLEATHER.COM.MX' , 1,30,'Flat Nature.isl',515,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 116, 'PERLAH', 'PERLA IVETH','HERNANDEZ','CASTILLO','Password1' , '' , 4,30,'IG Style.isl',11834,1,0				--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 120, 'ALFREDOA', 'JOSE ALFREDO','ALANIS','CONTRERAS','saiddamian' , '' , 3,30,'Noir Moderne.isl',11716,1,0		--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 121, 'LUZM', 'LUZ ELENA','MORALES','GONZALEZ','12340' , 'LUZM@PEARLLEATHER.COM.MX' , 1,30,'Flat Nature.isl',7283,1,0				--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 122, 'JESUSR', '','','','12340' , 'JESUSR@PEARLLEATHER.COM.MX' , 0,30,'Red Planet.isl',0,1,1				--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 123, 'JORGEN', 'JORGE ADRIAN','NINO','RUIZ','1234' , 'ADRIANN@PEARLLEATHER.COM.MX' , 5,30,'Red Planet.isl',11524,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 125, 'IRISE', 'IRIS ELIZABETH','ESTRADA','BAUTISTA','12345' , 'IRISE@PEARLLEATHER.COM.MX' , 1,30,'Flat Nature.isl',8524,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 126, 'ANAHIG', '','','','12345' , '' , 0,30,'Natilus.isl',0,1,1						--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 129, 'MARIOS', 'MARIO ALBERTO','SAENZ','MONTES','12345' , 'MARIOS@PEARLLEATHER.COM.MX' , 4,30,'Red Planet.isl',12483,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 131, 'JESUST', 'JESUS','TORRES','ORONA','Password1' , '' , 3,30,'Flat Nature.isl',3719,1,0			--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 132, 'TERESAJ', 'TERESA DE JESUS','JIMENEZ','GARCIA','123456' , '' , 4,30,'Flat Nature.isl',12662,1,0			--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 134, 'DANELIJ', 'DANELI MICHELLE','JIMENEZ','PEREZ','Password1' , '' , 4,30,'Flat Nature.isl',12722,1,0			--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 135, 'ANAH', 'ANA KAREN','HERNANDEZ','LINARES','Password1' , '' , 2,30,'black.isl',11943,1,0					--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 136, 'CRISTALV', 'VIVIANA CRISTAL','VILLA','RODRIGUEZ','1394' , '' , 3,30,'Noir Moderne.isl',12844,1,0			--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 137, 'JORGEG', 'JORGE ARMANDO','GONZALEZ','JUAREZ','1234' , 'JORGEG@PEARLLEATHER.COM.MX' , 1,30,'Flat Nature.isl',6897,1,0			--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 138, 'RODOLFOC', 'RODOLFO','CARBAJAL','PAJON','247328' , '' , 12,40,'Flat Nature.isl',9762,1,0			--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 139, 'ALEJANDROD', 'ALEJANDRO','DE LA ROSA','RODRIGUEZ','11111111' , 'ALEJANDROD@PEARLLEATHER.COM.MX' , 7,30,'black.isl',13164,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 140, 'JORGEJ', 'JORGE IVAN','JARAMILLO','TAPIA','Password1' , 'JORGEJ@PEARLLEATHER.COM.MX' , 4,30,'Red Planet.isl',8537,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 141, 'GEOVANNIL', 'HECTOR GEOVANNI','LOPEZ','LOPEZ','Password1' , '' , 4,30,'Flat Nature.isl',12602,1,0		--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 142, 'ALBAJ', 'ALBA VALERIA','JAQUEZ','BERNAL','Password1' , 'ALBAJ@PEARLLEATHER.COM.MX' , 4,30,'Flat Nature.isl',13270,1,0		--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 143, 'EDUARDOP', '','','','80916' , '' , 0,30,'Noir Moderne.isl',0,1,1				--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 144, 'FRANCISCOE', 'FRANCISCO','ESTEBAN','GUTIERREZ','Password1' , 'FRANCISCOE@PEARLLEATHER.COM.MX' , 7,30,'Flat Nature.isl',13367,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 145, 'DULCEC', 'DULCE IVETH','COBOS','FRAYRE','Password1' , 'DULCEC@PEARLLEATHER.COM.MX' , 2,30,'Flat Nature.isl',12834,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 146, 'JACKIEG', 'JACKIE JURIANA','GONZALEZ','HERNANDEZ','Password1' , 'JACKIE@PEARLLEATHER.COM.MX' , 2,30,'Flat Nature.isl',13107,1,0	--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 147, 'ROSARIOM','ROSARIO','MENDOZA','PENA','Password1','ROSARIOM.PEARL@GMAIL.COM',4,30,'Flat Nature.isl',8130,1,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 148, 'MIGUELR' ,'JESUS MIGUEL','REYES','RODRIGUEZ','Password1','MIGUELR@PEARLLEATHER.COM.MX',4,30,'Flat Nature.isl',13205,1,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 149, 'NICOLASP','NICOLAS','PEREZ','ANOTA','password1','NICOLASP@PEARLLEATHER.COM.MX',2,30,'Flat Nature.isl',5520,1,0
-- ===============================================
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 51, 'RECIBO1', '', '', '', '12345' , 'PEDROA@PEARLLEATHER.COM.MX' , 0,30,'IG Style.isl',0,1,0								--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 52, 'RECIBO2', '', '', '', '12340' , 'PEDROA@PEARLLEATHER.COM.MX' , 0,30,'The Blues.isl',0,1,0							--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 71, 'NAVIDR', 'NAVID','RACHMAN','','kgi01!' , 'NAVID@RACHMANTECH.COM' , 0,30,'Flat Nature.isl',-1,0,0	--,0
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 88, 'SISTEMAS', '', '', '', 'm@ster++' , 'SISTEMAS@PEARLLEATHER.COM.MX' , 0,30,'Red Planet.isl',0,1,0						--,1
EXECUTE [dbo].[PG_CI_USUARIO_PEARL] 103, 'SUPERVISOR', '', '', '', 'super10' , 'XX@PEARLLEATHER.COM.MX' , 0,30,'Flat Nature.isl',0,1,0						--,1
GO

-- ===============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_PEARL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO_PEARL]
GO
-- ===============================================

---- //////////////////////////////////////////////////////////////
---- // USUARIO_FORANEO
---- //////////////////////////////////////////////////////////////

--CREATE TABLE [dbo].[USUARIO_FORANEO] (
--	[K_USUARIO_PEARL]			[INT] NOT NULL,
--	-- ========================================
--	[D_USUARIO_PEARL]			[VARCHAR] (100) NOT NULL,
--	-- ========================================
--	[NOMBRE_FORANEO]			[VARCHAR] (100) NULL,
--	[APELLIDO_PATERNO_FORANEO]	[VARCHAR] (100) NULL,
--	[APELLIDO_MATERNO_FORANEO]	[VARCHAR] (100) NULL,
--	-- ========================================
--	[CORREO_USUARIO_PEARL]		[VARCHAR] (100) DEFAULT '',
--	[PASSWORD_USUARIO_PEARL]	[VARCHAR] (15) NOT NULL,
--	[TEMA_USUARIO_PEARL]		[VARCHAR] (30) DEFAULT 'Flat Nature.isl',
--	-- ========================================
--	[K_USUARIO_DEPARTAMENTO]	[INT] DEFAULT 0,
--	[K_USUARIO_TIPO]			[INT] DEFAULT 30,
--	[K_EMPLEADO_PEARL]			[INT] DEFAULT -1,
--	-- ========================================
--	[L_USUARIO_PEARL]			[INT] NOT NULL DEFAULT 0
--	--[C_USUARIO_PEARL]			[VARCHAR] (255) DEFAULT '',
--	--[L_CORREO_PEARL]			[INT] NOT NULL,
--	-- ========================================
--) ON [PRIMARY]
--GO
---- //////////////////////////////////////////////////////////////

--ALTER TABLE [dbo].[USUARIO_FORANEO]
--	ADD CONSTRAINT [PK_USUARIO_FORANEO]
--		PRIMARY KEY CLUSTERED ([K_USUARIO_PEARL])
--GO

--CREATE UNIQUE NONCLUSTERED 
--	INDEX [UN_USUARIO_FORANEO_01_DESCRIPCION] 
--	   ON [dbo].[USUARIO_PEARL] ( [D_USUARIO_PEARL] )
--GO

--ALTER TABLE [dbo].[USUARIO_FORANEO]
--	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL DEFAULT 139,
--			[F_ALTA]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
--			[K_USUARIO_CAMBIO]				[INT]		NOT NULL DEFAULT 139,
--			[F_CAMBIO]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
--			[L_BORRADO]						[INT]		NOT NULL DEFAULT 0,
--			[K_USUARIO_BAJA]				[INT]		NULL,
--			[F_BAJA]						[DATETIME]	NULL;
--GO


--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_FORANEO]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_CI_USUARIO_FORANEO]
--GO

--CREATE PROCEDURE [dbo].[PG_CI_USUARIO_FORANEO]
--	@PP_K_USUARIO_PEARL				INT,
--	-- ========================================
--	@PP_D_USUARIO_PEARL				VARCHAR (100),
--	-- ========================================
--	@PP_NOMBRE_FORANEO				VARCHAR (100),
--	@PP_APELLIDO_PATERNO_FORANEO	VARCHAR (100),
--	@PP_APELLIDO_MATERNO_FORANEO	VARCHAR (100),
--	-- ========================================
--	@PP_PASSWORD_USUARIO_PEARL		VARCHAR (15) ,
--	@PP_CORREO_USUARIO_PEARL		VARCHAR (50),
--	@PP_K_USUARIO_DEPTO				INT,
--	@PP_K_USUARIO_TIPO				INT,
--	@PP_TEMA_USUARIO_PEARL			VARCHAR(50),
--	-- ========================================
--	@PP_K_EMPLEADO_PEARL			INT,
----	@PP_C_USUARIO_PEARL				VARCHAR(100),
--	@PP_L_USUARIO_PEARL				INT,
--	@PP_L_BORRADO					INT
--	-- ========================================
----	@PP_L_CORREO_PEARL				INT
--AS
--	-- ===============================
--	DECLARE @VP_K_EXISTE	INT

--	SELECT	@VP_K_EXISTE =	K_USUARIO_PEARL
--							FROM	USUARIO_FORANEO
--							WHERE	K_USUARIO_PEARL=@PP_K_USUARIO_PEARL
--	-- ===============================
--	IF @VP_K_EXISTE IS NULL
--		INSERT INTO USUARIO_FORANEO
--			(	[K_USUARIO_PEARL]			,
--				-- =========================
--				[D_USUARIO_PEARL]			,
--				-- ========================================
--				[NOMBRE_FORANEO]			,
--				[APELLIDO_PATERNO_FORANEO]	,
--				[APELLIDO_MATERNO_FORANEO]	,
--				-- =========================
--				[PASSWORD_USUARIO_PEARL]	,				[CORREO_USUARIO_PEARL]		,
--				[K_USUARIO_DEPARTAMENTO]	,				[K_USUARIO_TIPO]			,
--				[TEMA_USUARIO_PEARL]		,
--				-- ========================================-- =========================
--				[K_EMPLEADO_PEARL]			,				--[C_USUARIO_PEARL]			,
--				[L_USUARIO_PEARL]			,				[L_BORRADO]					)
----				[L_CORREO_PEARL])		
--		VALUES	
--			(	@PP_K_USUARIO_PEARL			,	
--				-- =============================
--				@PP_D_USUARIO_PEARL			,	
--				-- =============================
--				@PP_NOMBRE_FORANEO			,
--				@PP_APELLIDO_PATERNO_FORANEO,
--				@PP_APELLIDO_MATERNO_FORANEO,
--				-- =============================
--				@PP_PASSWORD_USUARIO_PEARL	,				@PP_CORREO_USUARIO_PEARL		,
--				@PP_K_USUARIO_DEPTO			,				@PP_K_USUARIO_TIPO				,
--				@PP_TEMA_USUARIO_PEARL		,	
--				-- =============================
--				@PP_K_EMPLEADO_PEARL		,				--@PP_C_USUARIO_PEARL				,
--				@PP_L_USUARIO_PEARL			,				@PP_L_BORRADO					)
----				@PP_L_CORREO_PEARL	)
--	ELSE
--		UPDATE	USUARIO_FORANEO
--		SET		[K_USUARIO_PEARL]			= @PP_K_USUARIO_PEARL		,		
--				-- ========================== -- =============================
--				[D_USUARIO_PEARL]			= @PP_D_USUARIO_PEARL		,		
--				-- ========================== -- =============================
--				[NOMBRE_FORANEO]			= @PP_NOMBRE_FORANEO		,
--				[APELLIDO_PATERNO_FORANEO]	= @PP_APELLIDO_PATERNO_FORANEO,
--				[APELLIDO_MATERNO_FORANEO]	= @PP_APELLIDO_MATERNO_FORANEO,
--				-- ========================== -- =============================
--				[PASSWORD_USUARIO_PEARL]	= @PP_PASSWORD_USUARIO_PEARL,		
--				[CORREO_USUARIO_PEARL]		= @PP_CORREO_USUARIO_PEARL	,	
--				[K_USUARIO_DEPARTAMENTO]	= @PP_K_USUARIO_DEPTO		,		
--				[K_USUARIO_TIPO]			= @PP_K_USUARIO_TIPO		,	
--				[TEMA_USUARIO_PEARL]		= @PP_TEMA_USUARIO_PEARL	,		
--				-- ========================== -- =============================
--				[K_EMPLEADO_PEARL]			= @PP_K_EMPLEADO_PEARL		,	
----				[C_USUARIO_PEARL]			= @PP_C_USUARIO_PEARL		,		
--				[L_USUARIO_PEARL]			= @PP_L_USUARIO_PEARL		,
--				[L_BORRADO]					= @PP_L_BORRADO
--		WHERE	K_USUARIO_PEARL=@PP_K_USUARIO_PEARL
--	-- =========================================================
--GO

--SET NOCOUNT ON
---- ===============================================
--EXECUTE [dbo].[PG_CI_USUARIO_FORANEO] 51, 'RECIBO1', '', '', '', '12345' , 'PEDROA' , 0,30,'IG Style.isl',0,1,0								--,1
--EXECUTE [dbo].[PG_CI_USUARIO_FORANEO] 52, 'RECIBO2', '', '', '', '12340' , 'PEDROA' , 0,30,'The Blues.isl',0,1,0							--,1
--EXECUTE [dbo].[PG_CI_USUARIO_FORANEO] 71, 'NAVIDR', 'NAVID','RACHMAN','','kgi01!' , 'NAVID@RACHMANTECH.COM' , 0,30,'Flat Nature.isl',-1,0,0	--,0
--EXECUTE [dbo].[PG_CI_USUARIO_FORANEO] 88, 'SISTEMAS', '', '', '', 'm@ster++' , 'SISTEMAS' , 0,30,'Red Planet.isl',0,1,0						--,1
--EXECUTE [dbo].[PG_CI_USUARIO_FORANEO] 103, 'SUPERVISOR', '', '', '', 'super10' , 'XX' , 0,30,'Flat Nature.isl',0,1,0						--,1
--GO

---- ===============================================
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_FORANEO]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_CI_USUARIO_FORANEO]
--GO


-- //////////////////////////////////////////////////////////////
-- // USUARIO_PERMISOS
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[USUARIO_PERMISOS] (
	--[K_USUARIO_PERMISOS]	[INT] NOT NULL,
	[K_USUARIO_PEARL]		[INT] NOT NULL,
	-- ========================================
	[K_SISTEMA_TAG]			[INT] NOT NULL DEFAULT 0
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

----ALTER TABLE [dbo].[USUARIO_PERMISOS]
----	ADD CONSTRAINT [PK_USUARIO_PERMISOS]
----		PRIMARY KEY CLUSTERED ([K_USUARIO_PERMISOS])
----GO

------ //////////////////////////////////////////////////////////////

--ALTER TABLE [dbo].[USUARIO_PERMISOS] ADD 
--	CONSTRAINT [FK_USUARIO_PERMISOS_01] 
--		FOREIGN KEY ( [K_USUARIO_PEARL] ) 
--		REFERENCES [dbo].[USUARIO_PEARL] ( [K_USUARIO_PEARL] )
--GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_PERMISOS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO_PERMISOS]
GO

CREATE PROCEDURE [dbo].[PG_CI_USUARIO_PERMISOS]
	@PP_K_USUARIO_PEARL				INT,
	-- ========================================
	@PP_K_SISTEMA_TAG				INT
AS
	-- ===============================
		INSERT INTO USUARIO_PERMISOS
			(	[K_USUARIO_PEARL]			,
				-- =========================
				[K_SISTEMA_TAG]				)		
		VALUES	
			(	@PP_K_USUARIO_PEARL			,	
				-- =============================
				@PP_K_SISTEMA_TAG			)
	-- =========================================================
GO

SET NOCOUNT ON
-- ===============================================
---- #10 CALIDAD
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 13
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 23
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 33
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 37
---- #30 FINANZAS
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 58
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 144, 58
---- #40 GENERAL
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 61
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 144, 61
---- #60 MATERIALES
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 144, 5
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 144, 6
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 144, 7
---- #90 SISTEMAS
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 31
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 51
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 52
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 53
--EXECUTE [dbo].[PG_CI_USUARIO_PERMISOS] 139, 57

GO

-- ===============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_PERMISOS_MENU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO_PERMISOS]
GO
-- ===============================================


-- //////////////////////////////////////////////////////////////
-- // PERMISO_BOTON
-- //////////////////////////////////////////////////////////////

--CREATE TABLE [dbo].[PERMISO_BOTON] (
--	[K_PERMISO_BOTON]		[INT] NOT NULL,
--	[D_BOTON]				[VARCHAR] (250) NOT NULL,
--	[L_ACTIVO_BOTON]		[INT] DEFAULT 1,
--	[L_VISIBLE_BOTON]		[INT] DEFAULT 1,
--	-- ========================================
--	[K_SISTEMA_TAG]			[INT] NOT NULL DEFAULT 0
--) ON [PRIMARY]
--GO
---- //////////////////////////////////////////////////////////////

--ALTER TABLE [dbo].[PERMISO_BOTON]
--	ADD CONSTRAINT [PK_PERMISO_BOTON]
--		PRIMARY KEY CLUSTERED ([K_PERMISO_BOTON])
--GO

---- //////////////////////////////////////////////////////////////

----ALTER TABLE [dbo].[PERMISO_BOTON] ADD 
----	CONSTRAINT [FK_PERMISO_BOTON_01] 
----		FOREIGN KEY ( [K_SISTEMA_TAG] ) 
----		REFERENCES [dbo].[SISTEMA_TAG] ( [K_SISTEMA_TAG] )
----GO


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////

--INSERT INTO USUARIO_PEARL
--(	K_USUARIO_PEARL,
--	D_USUARIO_PEARL,
--	PASSWORD_USUARIO_PEARL,
--	CORREO_USUARIO_PEARL,
--	USUARIO_TIPO,
--	TEMA_USUARIO_PEARL,
--	L_USUARIO_PEARL,
--	K_EMPLEADO_PEARL
--)
--SELECT 
--	CODIGO,
--	UPPER(USUARIO),
--	CONTRASENA,
--	UPPER(CORREO),
--	UPPER(tipo),
------	(
------	CASE WHEN [tipo]='A1' THEN 10
------		 WHEN [tipo]='A1' THEN 10
------		 WHEN [tipo]='A1' THEN 10
------		 WHEN [tipo]='A1' THEN 10
------	END ),	
--	UPPER(TEMA),
--	1,
--	0
--FROM DATA_02PRUEBAS.DBO.USERS_PEARL
--WHERE codigo NOT IN (127,128)



	--		INSERT INTO USUARIO_PERMISOS		
	--		(
	--			K_USUARIO_PEARL,
	--			K_SISTEMA_TAG
	--		)
	--		SELECT	
	--		usr_pearl,
	--		app_pearl
	--		FROM	DATA_02.DBO.perm_pearl

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////

