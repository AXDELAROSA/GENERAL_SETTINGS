-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		ALL
-- // MODULE:			TAG x FORMA
-- // OPERATION:		SP
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200320
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- SELECT * FROM SISTEMA_TAG
-- SELECT * FROM GRUPO_TAG
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SISTEMA_TAG]') AND type in (N'U'))
	DROP TABLE [dbo].[SISTEMA_TAG]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GRUPO_TAG]') AND type in (N'U'))
	DROP TABLE [dbo].[GRUPO_TAG]
GO



-- //////////////////////////////////////////////////////////////
-- // GRUPO_TAG
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[GRUPO_TAG] (
	[K_GRUPO_TAG]	[INT] NOT NULL,
	[D_GRUPO_TAG]	[VARCHAR] (100) NOT NULL,
	[S_GRUPO_TAG]	[VARCHAR] (10) NOT NULL,
	[O_GRUPO_TAG]	[INT] NOT NULL,
	[C_GRUPO_TAG]	[VARCHAR] (255) NOT NULL,
	[L_GRUPO_TAG]	[INT] NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[GRUPO_TAG]
	ADD CONSTRAINT [PK_GRUPO_TAG]
		PRIMARY KEY CLUSTERED ([K_GRUPO_TAG])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_GRUPO_TAG_01_DESCRIPCION] 
	   ON [dbo].[GRUPO_TAG] ( [D_GRUPO_TAG] )
GO

ALTER TABLE [dbo].[GRUPO_TAG]
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL DEFAULT 139,
			[F_ALTA]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL DEFAULT 139,
			[F_CAMBIO]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
			[L_BORRADO]						[INT]		NOT NULL DEFAULT 0,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_GRUPO_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_GRUPO_TAG]
GO

CREATE PROCEDURE [dbo].[PG_CI_GRUPO_TAG]
	@PP_K_GRUPO_TAG		[INT],
	@PP_D_GRUPO_TAG		[VARCHAR](100),
	@PP_S_GRUPO_TAG		[VARCHAR](10),
	@PP_O_GRUPO_TAG		[INT],
	@PP_C_GRUPO_TAG		[VARCHAR](255),
	@PP_L_GRUPO_TAG		[INT]
AS
	-- ===============================
	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_GRUPO_TAG
							FROM	GRUPO_TAG
							WHERE	K_GRUPO_TAG=@PP_K_GRUPO_TAG
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO GRUPO_TAG
			(	K_GRUPO_TAG,			D_GRUPO_TAG, 
				S_GRUPO_TAG,			O_GRUPO_TAG,
				C_GRUPO_TAG,
				L_GRUPO_TAG			)		
		VALUES	
			(	@PP_K_GRUPO_TAG,		@PP_D_GRUPO_TAG,	
				@PP_S_GRUPO_TAG,		@PP_O_GRUPO_TAG,
				@PP_C_GRUPO_TAG,
				@PP_L_GRUPO_TAG		)
	ELSE
		UPDATE	GRUPO_TAG
		SET		D_GRUPO_TAG	= @PP_D_GRUPO_TAG,	
				S_GRUPO_TAG	= @PP_S_GRUPO_TAG,			
				O_GRUPO_TAG	= @PP_O_GRUPO_TAG,
				C_GRUPO_TAG	= @PP_C_GRUPO_TAG,
				L_GRUPO_TAG	= @PP_L_GRUPO_TAG	
		WHERE	K_GRUPO_TAG=@PP_K_GRUPO_TAG
	-- =========================================================
GO

SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 00, '(SIN-GRUPO)',		'( S/G )',	00 , '#00 // (SIN-GRUPO)'	, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 10, 'CALIDAD',			'CALID',	10 , '#10 // CALID'			, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 20, 'FINAL',			'FINAL',	20 , '#20 // FINAL'			, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 30, 'FINANZAS',			'FINZS',	30 , '#30 // FINZS'			, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 40, 'GENERAL',			'GNRAL',	40 , '#40 // GNRAL'			, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 50, 'INGENIERIA',		'INGEN',	50 , '#50 // INGEN'			, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 60, 'MATERIALES',		'MATER',	60 , '#60 // MATER'			, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 70, 'PRODUCCION',		'PRODU',	70 , '#70 // PRODU'			, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 80, 'RECURSOS_HUMANOS',	'RHUMA',	80 , '#80 // RHUMA'			, 1
EXECUTE [dbo].[PG_CI_GRUPO_TAG] 90, 'SISTEMAS',			'SISTM',	90 , '#90 // SISTM'			, 1

	-- ===============================================
GO



-- //////////////////////////////////////////////////////////////
-- // SISTEMA_TAG
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SISTEMA_TAG] (
	[K_SISTEMA_TAG]			[INT] NOT NULL,
	[D_SISTEMA_TAG]			[VARCHAR] (100) NOT NULL,
	[D_SISTEMA_TAG_MENU]	[VARCHAR] (100) NOT NULL,
	[S_SISTEMA_TAG]			[VARCHAR] (10) NOT NULL DEFAULT '',
	[O_SISTEMA_TAG]			[INT] NOT NULL DEFAULT 0,
	[C_SISTEMA_TAG]			[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_SISTEMA_TAG]			[INT] NOT NULL DEFAULT 1,
	[R_SISTEMA_TAG]			[VARCHAR] (500) NOT NULL DEFAULT '',
	-- ========================================
	[K_GRUPO_TAG]			[INT] NOT NULL DEFAULT 0,
	[L_ARCHIVO_TAG]			[INT] NOT NULL DEFAULT 0,
	[K_IMAGEN_SISTEMA_TAG]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[SISTEMA_TAG]
	ADD CONSTRAINT [PK_SISTEMA_TAG]
		PRIMARY KEY CLUSTERED ([K_SISTEMA_TAG])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_SISTEMA_TAG_01_DESCRIPCION] 
	   ON [dbo].[SISTEMA_TAG] ( [D_SISTEMA_TAG] )
GO
-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[SISTEMA_TAG] ADD 
	CONSTRAINT [FK_SISTEMA_TAG_01] 
		FOREIGN KEY ( [K_GRUPO_TAG] ) 
		REFERENCES [dbo].[GRUPO_TAG] ( [K_GRUPO_TAG] )
GO

ALTER TABLE [dbo].[SISTEMA_TAG]
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL DEFAULT 139,
			[F_ALTA]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL DEFAULT 139,
			[F_CAMBIO]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
			[L_BORRADO]						[INT]		NOT NULL DEFAULT 0,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SISTEMA_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SISTEMA_TAG]
GO


CREATE PROCEDURE [dbo].[PG_CI_SISTEMA_TAG]
	@PP_K_USUARIO_EXE			[INT],
	-- ========================================
	@PP_K_SISTEMA_TAG			[INT],
	@PP_D_SISTEMA_TAG			[VARCHAR](100),
	@PP_D_SISTEMA_TAG_MENU		[VARCHAR](100),
	@PP_S_SISTEMA_TAG			[VARCHAR](10),
	@PP_O_SISTEMA_TAG			[INT],
	@PP_C_SISTEMA_TAG			[VARCHAR](255),
	@PP_R_SISTEMA_TAG			[VARCHAR](255),
	@PP_L_SISTEMA_TAG			[INT],
	-- ===============================
	@PP_K_GRUPO_TAG				[INT],
	@PP_L_ARCHIVO_TAG			[INT],
	@PP_K_IMAGEN_SISTEMA_TAG	[INT]
AS
	-- ===============================
	DECLARE @VP_K_EXISTE	INT
	SELECT	@VP_K_EXISTE =	K_SISTEMA_TAG
							FROM	SISTEMA_TAG
							WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO SISTEMA_TAG
			(	K_SISTEMA_TAG,			
				D_SISTEMA_TAG,			D_SISTEMA_TAG_MENU, 
				S_SISTEMA_TAG,			O_SISTEMA_TAG,
				C_SISTEMA_TAG,			R_SISTEMA_TAG,
				L_SISTEMA_TAG,			K_GRUPO_TAG	,
				L_ARCHIVO_TAG,			K_IMAGEN_SISTEMA_TAG				)
		VALUES	
			(	@PP_K_SISTEMA_TAG,		
				@PP_D_SISTEMA_TAG,		@PP_D_SISTEMA_TAG_MENU,	
				@PP_S_SISTEMA_TAG,		@PP_O_SISTEMA_TAG,
				@PP_C_SISTEMA_TAG,		@PP_R_SISTEMA_TAG,
				@PP_L_SISTEMA_TAG,		@PP_K_GRUPO_TAG	,
				@PP_L_ARCHIVO_TAG,		@PP_K_IMAGEN_SISTEMA_TAG			)
	ELSE
		UPDATE	SISTEMA_TAG
		SET		D_SISTEMA_TAG		= @PP_D_SISTEMA_TAG,	
				D_SISTEMA_TAG_MENU	= @PP_D_SISTEMA_TAG_MENU,	
				S_SISTEMA_TAG		= @PP_S_SISTEMA_TAG,			
				O_SISTEMA_TAG		= @PP_O_SISTEMA_TAG,
				C_SISTEMA_TAG		= @PP_C_SISTEMA_TAG,
				R_SISTEMA_TAG		= @PP_R_SISTEMA_TAG,
				L_SISTEMA_TAG		= @PP_L_SISTEMA_TAG,
				K_GRUPO_TAG			= @PP_K_GRUPO_TAG,
				L_ARCHIVO_TAG		= @PP_L_ARCHIVO_TAG,
				K_IMAGEN_SISTEMA_TAG= @PP_K_IMAGEN_SISTEMA_TAG
		WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG
	-- =========================================================
GO


SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 0, '(NO-SISTEMA)', '( NO-SISTEMA )', '( N/S )' , 0 , '#0 // (NO-SISTEMA)' , '', 1,0,0,1
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 1, 'prod_rpt', 'PRODUCTION REPORT', '#001' , 1 , '' , '', 1,70,0,1
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 2, 'SupScreen', 'SUPERVISORS', '#002' , 2 , '' , '', 1,70,0,30
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 3, 'frmMain2', 'PRODUCTION', '#003' , 3 , '' , '', 1,70,0,26
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 4, 'rej', 'REJECTS', '#004' , 4 , '' , '', 1,70,0,24
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 5, 'Planning', 'PLANNING SCREEN', '#005' , 5 , '' , '', 1,60,0,21
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 6, 'Transferencias', 'TRANSACTIONS', '#006' , 6 , '' , '', 1,60,0,19
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 7, 'sc_pieles2', 'HIDES SCANNER', '#007' , 7 , '' , '', 0,60,0,7
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 8, 'labels', 'LABELS', '#008' , 8 , '' , '', 1,60,0,35
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 9, 'etiqueta_piel', 'HIDE LABELS', '#009' , 9 , '' , '', 1,60,0,34
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 10, 'Packing', 'PACKING SLIP', '#010' , 10 , '' , '', 1,20,0,14
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 11, 'FO_TRANSFER_SCREEN', 'TRANSFER MCT TO MFP', '#011' , 11 , '' , '', 1,20,0,20
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 12, 'InventMFP', 'MFP INVENTORY', '#012' , 12 , '' , '', 1,20,0,12
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 13, 'PPMS', 'PPMS', '#013' , 13 , '' , '', 1,10,0,31
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 14, 'readEDI', 'LOAD RELEASE', '#014' , 14 , '' , '', 1,60,0,6
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 15, 'diamante', 'EDI WEEKLY RPT', '#015' , 15 , '' , '', 1,60,0,29
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 16, 'InvD', 'DAILY INVENTORY', '#016' , 16 , '' , '', 1,20,0,25
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 17, '2D BARCODE', '2D BARCODE', '#017' , 17 , '' , '', 0,0,0,1
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 18, 'HidesAllocation', 'HIDES ALLOCATION', '#018' , 18 , '' , '', 1,40,0,2
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 19, 'personal', 'HUMAN RESOURCES', '#019' , 19 , '' , '', 1,80,0,4
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 20, 'frmRange', 'STOCK STATUS', '#020' , 20 , '' , '', 1,40,0,4
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 21, 'EXCEL_PRODUCTION_REPORT', 'EXCEL PRODUCTION REPORT', '#021' , 21 , '' , '\\10.1.1.5\documents\PEARL\Reportes\Excel Production Report.xlsm', 1,70,1,32
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 22, 'BELL_CURVE', 'BELL CURVE', '#022' , 22 , '' , '\\10.1.1.5\documents\PEARL\Reportes\Bell_Curve_Report.xls', 1,40,1,14
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 23, 'TransactionsReport', 'TRANSACTION REPORT', '#023' , 23 , '' , '', 1,60,0,7
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 24, 'CERTIFICATION_REPORT', 'CERTIFICATION REPORT', '#024' , 24 , '' , '', 1,10,0,21
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 25, 'FoliosInv', 'FOLIOS INVENTORY', '#025' , 25 , '' , '', 1,60,0,6
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 26, 'QUALITY_REJECTS', 'QUALITY REJECTS', '#026' , 26 , '' , '', 1,10,0,24
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 27, 'PackingSlipMexico', 'PACKING MACOLA', '#027' , 27 , '' , '', 1,20,0,10
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 28, 'Tags', 'TAGS', '#028' , 28 , '' , '', 1,30,0,36
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 29, 'SalesByCust', 'SALES BY CUST', '#029' , 29 , '' , '', 1,30,0,38
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 30, 'PolizaNomina', 'POLIZA DE NOMINA', '#030' , 30 , '' , '', 1,30,0,25
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 31, 'HistoryByPackL', 'HISTORY BY JOB NO', '#031' , 31 , '' , '', 1,60,0,15
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 32, 'PatternsDatabase', 'PATTERN LABELS', '#032' , 32 , '' , '', 1,90,0,39
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 33, 'Leather planning              ', 'Leather planning              ', '#033' , 33 , '' , '', 0,40,0,1
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 34, 'Cum_Report', 'CUMULATIVE REPORT', '#034' , 34 , '' , '', 1,60,0,7
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 35, 'INCOMING_INSPECTION', 'INCOMING INSPECTION', '#035' , 35 , '' , '', 1,10,0,27
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 36, 'STATUS_DE_ORDENES', 'STATUS DE ORDENES', '#036' , 36 , '' , '', 1,10,0,17
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 37, 'UpdateTarget', 'UPDATE TARGETS', '#037' , 37 , '' , '', 1,40,0,38
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 38, 'colors', 'COLORS MANT', '#038' , 38 , '' , '', 1,50,0,28
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 39, 'LOT_COMP', 'LOT COMP', '#039' , 39 , '' , '', 1,10,0,14
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 40, 'INV IT', 'INV IT', '#040' , 40 , '' , '', 0,90,0,1
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 41, 'Eng_main', 'ENGINEERING SCREEN', '#041' , 41 , '' , '', 1,50,0,22
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 42, 'ProdCat', 'PROD CATEGORY', '#042' , 42 , '' , '', 1,50,0,10
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 43, 'ItemMaster', 'ITEM MASTER', '#043' , 43 , '' , '', 1,50,0,30
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 44, 'KitMaster', 'KIT MASTER', '#044' , 44 , '' , '', 1,50,0,17
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 45, 'ADLocations', 'ADD LOCATIONS', '#045' , 45 , '' , '', 1,40,0,11
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 46, 'Facturacion', 'BILLING', '#046' , 46 , '' , '', 1,20,0,13
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 47, 'FoliosV2', 'TRANS_FOLIOS', '#047' , 47 , '' , '', 1,60,0,20
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 48, 'PrintInvoice', 'RE-PRINT INVOICE', '#048' , 48 , '' , '', 1,20,0,7
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 49, 'Fina_Cum_Report', 'CUM REPORT', '#049' , 49 , '' , '', 1,60,0,17
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 50, 'SalidasInventa', 'SALIDAS DE INV', '#050' , 50 , '' , '', 1,60,0,0
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 51, 'frmprddefrpt', 'REPORTE DE DEFECTOS', '#051' , 51 , '' , '', 1,70,0,11
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 52, 'LotsYield', 'LOT YIELD', '#052' , 52 , '' , '', 1,70,0,38
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 53, 'LotTrack', 'LOT TRACK', '#053' , 53 , '' , '', 1,40,0,26
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 54, 'FO_USUARIOS', 'USUARIOS', '#054' , 54 , '' , '', 1,90,0,57
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 55, 'frmmnto', 'MTTO PREVENTIVO', '#055' , 55 , '' , '', 1,90,0,58
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 56, 'frmequipo', 'EQUIPOS', '#056' , 56 , '' , '', 1,90,0,50
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 57, 'frmbajas', 'BAJAS', '#057' , 57 , '' , '', 1,80,0,53
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 58, 'FO_PUESTO', 'CAPACITACIÓN', '#058' , 58 , '' , '', 1,80,0,51
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 59, 'frmtoner', 'TONERS', '#059' , 59 , '' , '', 1,90,0,56
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 60, 'frmKits', 'CERRAR KITS', '#060' , 60 , '' , '', 1,20,0,53
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 61, 'frmreporte', 'REPORTE', '#061' , 61 , '' , '', 1,80,0,53
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 62, 'Frm_Ausentismo', 'AUSENTISMO', '#062' , 62 , '' , '', 1,80,0,61
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 63, 'etiqueta_piel_new', 'HIDE LABELS JL', '#063' , 63 , '' , '', 1,60,0,34
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 64, 'FO_MENU', 'COMPRAS', '#064' , 64 , '' , '', 1,30,0,38
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 65, 'HorseDetail', 'IMPORT HIDES', '#065' , 65 , '' , '', 1,60,0,53
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 66, 'HeadCountRpt', 'HEAD COUNT', '#066' , 66 , '' , '', 1,80,0,61
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 67, 'SalesReports', 'SALES REPORTS', '#067' , 67 , '' , '', 1,30,0,6
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 68, 'Enroll', 'FINGERPRINT', '#068' , 68 , '' , '', 1,80,0,61
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 69, 'Customers', 'CUSTOMERS', '#069' , 69 , '' , '', 1,50,0,61
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 70, 'FO_ENG_QUOTE', 'COTIZACIONES', '#070' , 70 , '' , '', 1,50,0,16
EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 139, 71, 'FO_SISTEMAS', 'ALTA DE FORMAS', '#071' , 71 , '' , '', 1,90,0,16


--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 0, '(NO-SISTEMA)',				'(NO-SISTEMA)', '( N/S )' , 0 , '#0 // (NO-SISTEMA)', '', 1,0,1,1
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 1, 'prod_rpt',					'PRODUCTION REPORT','#001' , 1 , '', '', 1,70,0,1
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 2, 'SupScreen',					'SUPERVISORS','#002' , 2 , '' , '', 1,70,0,30
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 3, 'frmMain2',					'PRODUCTION','#003' , 3 , '' , '', 1,70,0,26
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 4, 'rej',						'REJECTS','#004' , 4 , '' , '', 1,70,0,24
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 5, 'Planning',					'PLANNING SCREEN','#005' , 5 , '' , '', 1,60,0,21
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 6, 'Transferencias',				'TRANSACTIONS','#006' , 6 , '' , '', 1,60,0,19
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 7, 'sc_pieles2',					'HIDES SCANNER','#007' , 7 , '' , '', 0,60,0,7
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 8, 'Packing',					'PACKING SLIP','#008' , 8 , '' , '', 1,20,0,14
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 9, 'transfer_screen',			'TRANSFER MCT TO MFP','#009' , 9 , '' , '', 1,20,0,20
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 10, 'InventMFP',					'MFP INVENTORY','#010' , 10 , '' , '', 1,20,0,12
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 11, 'labels',					'LABELS','#011' , 11 , '' , '', 1,60,0,35
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 12, 'etiqueta_piel',				'HIDE LABELS','#012' , 12 , '' , '', 1,60,0,34
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 13, 'PPMS',						'PPMS','#013' , 13 , '' , '', 1,10,0,31
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 14, 'readEDI',					'LOAD RELEASE','#014' , 14 , '' , '', 1,60,0,6
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 15, 'diamante',					'EDI WEEKLY RPT','#015' , 15 , '' , '', 1,60,0,29
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 16, 'InvD',						'DAILY INVENTORY','#016' , 16 , '' , '', 1,20,0,25
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 17, 'HidesAllocation',			'HIDES ALLOCATION','#017' , 17 , '' , '', 1,40,0,2
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 18, 'personal',					'HUMAN RESOURCES','#018' , 18 , '' , '', 1,80,0,4
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 19, 'frmRange',					'STOCK STATUS','#019' , 19 , '' , '', 1,40,0,4
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 20, 'EXCEL_PRODUCTION_REPORT',	'EXCEL PRODUCTION REPORT','#020' , 20 , '', '\\10.1.1.5\documents\PEARL\Reportes\Excel Production Report.xlsm', 1,70,1,32
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 21, 'BELL_CURVE',				'BELL CURVE','#021' , 21 , '', '\\10.1.1.5\documents\PEARL\Reportes\Bell_Curve_Report.xls' , 1,40,1,14
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 22, 'TransactionsReport',		'TRANSACTION REPORT','#022' , 22 , '', '', 1,60,0,7
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 23, 'CERTIFICATION_REPORT',		'CERTIFICATION REPORT','#023' , 23 , '', '', 1,10,0,21
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 24, 'FoliosInv',					'FOLIOS INVENTORY','#024' , 24 , '', '', 1,60,0,6
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 25, 'QUALITY_REJECTS',			'QUALITY REJECTS','#025' , 25 , '', '', 1,10,0,24
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 26, 'PackingSlipMexico',			'PACKING MACOLA','#026' , 26 , '', '', 1,20,0,10
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 27, 'Tags',						'TAGS','#027' , 27 , '', '', 1,30,0,36
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 28, 'SalesByCust',				'SALES BY CUST','#028' , 28 , '', '', 1,30,0,38
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 29, 'PolizaNomina',				'POLIZA DE NOMINA','#029' , 29 , '', '', 1,30,0,25
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 30, 'HistoryByPackL',			'HISTORY BY JOB NO','#030' , 30 , '', '', 1,60,0,15
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 31, 'PatternsDatabase',			'PATTERN LABELS','#031' , 31 , '', '', 1,90,0,39
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 32, 'Cum_Report',				'CUMULATIVE REPORT','#032' , 32 , '', '', 1,60,0,7
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 33, 'INCOMING_INSPECTION',		'INCOMING INSPECTION','#033' , 33 , '', '', 1,10,0,27
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 34, 'STATUS_DE_ORDENES',			'STATUS DE ORDENES','#034' , 34 , '', '', 1,10,0,17
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 35, 'colors',					'COLORS MANT','#035' , 35 , '', '', 1,50,0,28
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 36, 'UpdateTarget',				'UPDATE TARGETS','#036' , 36 , '', '', 1,40,0,38
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 37, 'LOT_COMP',					'LOT COMP','#037' , 37 , '', '', 1,10,0,14
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 38, 'Eng_main',					'ENGINEERING SCREEN','#038' , 38 , '', '', 1,50,0,22
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 39, 'ProdCat',					'PROD CATEGORY','#039' , 39 , '', '', 1,50,0,10
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 40, 'ItemMaster',				'ITEM MASTER','#040' , 40 , '', '', 1,50,0,30
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 41, 'KitMaster',					'KIT MASTER','#041' , 41 , '', '', 1,50,0,17
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 42, 'ADLocations',				'ADD LOCATIONS','#042' , 42 , '', '', 1,40,0,11
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 43, 'Facturacion',				'BILLING','#043' , 43 , '', '', 1,20,0,13
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 44, 'FoliosV2',					'TRANS_FOLIOS','#044' , 44 , '', '', 1,60,0,20
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 45, 'PrintInvoice',				'RE-PRINT INVOICE','#045' , 45 , '', '', 1,20,0,7
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 46, 'Fina_Cum_Report',			'CUM REPORT','#046' , 46 , '', '', 1,60,0,17
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 47, 'frmprddefrpt',				'REPORTE DE DEFECTOS','#047' , 47 , '', '', 1,70,0,11
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 48, 'LotsYield',					'LOT YIELD','#048' , 48 , '', '', 1,70,0,38
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 49, 'LotTrack',					'LOT TRACK','#049' , 49 , '', '', 1,40,0,26
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 50, 'SalidasInventa',			'SALIDAS DE INV','#050' , 50 , '', '', 1,60,0,0
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 51, 'FO_USUARIOS',				'USUARIOS','#051' , 51 , '', '', 1,90,0,57
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 52, 'frmmnto',					'MTTO PREVENTIVO','#052' , 52 , '', '', 1,90,0,58
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 53, 'EQUIPOS',					'EQUIPOS','#053' , 53 , '', '', 1,90,0,50
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 54, 'frmbajas',					'BAJAS','#054' , 54 , '', '', 1,80,0,53
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 55, 'FO_PUESTO',					'CAPACITACIÓN','#055' , 55 , '', '', 1,80,0,51
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 56, 'etiqueta_piel_new',			'HIDE LABELS JL','#056' , 56 , '', '', 1,60,0,34
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 57, 'frmtoner',					'TONERS','#057' , 57 , '', '', 1,90,0,56
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 58, 'frmKits',					'CERRAR KITS','#058' , 58 , '', '', 1,20,0,53
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 59, 'Frm_Ausentismo',			'AUSENTISMO','#059' , 59 , '', '', 1,80,0,61
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 60, 'frmreporte',				'REPORTE','#060' , 60 , '', '', 1,80,0,53
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 61, 'FO_MENU',					'COMPRAS','#061' , 61 , '', '', 1,30,0,38
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 62, 'HorseDetail',				'IMPORT HIDES','#062' , 62 , '', '', 1,60,0,53
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 63, 'HeadCountRpt',				'HEAD COUNT','#063' , 63 , '', '', 1,80,0,61
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 64, 'SalesReports',				'SALES REPORTS','#064' , 64 , '', '', 1,30,0,6
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 65, 'Enroll',					'FINGERPRINT','#065' , 65 , '', '', 1,80,0,61
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 66, 'Customers',					'CUSTOMERS','#066' , 66 , '', '', 1,50,0,61
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 67, 'FO_ENG_QUOTE',				'COTIZACIONES','#067' , 67 , '', '', 1,50,0,16
--EXECUTE [DBO].[PG_CI_SISTEMA_TAG] 139, 68, 'FO_SISTEMAS',				'ALTA DE FORMAS','#068' , 68 , '', '', 1,90,0,16
	-- ===============================================
GO

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////

