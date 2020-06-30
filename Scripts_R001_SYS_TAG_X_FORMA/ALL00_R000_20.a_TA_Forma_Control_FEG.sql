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
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SISTEMA_CONTROL_PERMISO]') AND type in (N'U'))
	DROP TABLE [dbo].[SISTEMA_CONTROL_PERMISO]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SISTEMA_CONTROL]') AND type in (N'U'))
	DROP TABLE [dbo].[SISTEMA_CONTROL]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SUB_SISTEMA_TAG]') AND type in (N'U'))
	DROP TABLE [dbo].[SUB_SISTEMA_TAG]
GO


-- //////////////////////////////////////////////////////////////
-- // SUB_SISTEMA_TAG
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SUB_SISTEMA_TAG] (
	[K_SUB_SISTEMA_TAG]			[INT]			NOT NULL,
	-- =================================	
	[D_SUB_SISTEMA_TAG]			VARCHAR(100)	NOT NULL
	-- =================================	
)ON [PRIMARY]	
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[SUB_SISTEMA_TAG]
	ADD CONSTRAINT [PK_SUB_SISTEMA_TAG]
		PRIMARY KEY CLUSTERED ([K_SUB_SISTEMA_TAG])
GO

-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SUB_SISTEMA_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SUB_SISTEMA_TAG]
GO


CREATE PROCEDURE [dbo].[PG_CI_SUB_SISTEMA_TAG]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_SUB_SISTEMA_TAG			INT,
	@PP_D_SUB_SISTEMA_TAG			VARCHAR(100)
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_SUB_SISTEMA_TAG
							FROM	SUB_SISTEMA_TAG
							WHERE	K_SUB_SISTEMA_TAG=@PP_K_SUB_SISTEMA_TAG

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO SUB_SISTEMA_TAG	
			(	K_SUB_SISTEMA_TAG,	
				D_SUB_SISTEMA_TAG	)		
		VALUES	
			(	@PP_K_SUB_SISTEMA_TAG,				
				@PP_D_SUB_SISTEMA_TAG	)
	ELSE
		UPDATE	SUB_SISTEMA_TAG
			SET	D_SUB_SISTEMA_TAG			= @PP_D_SUB_SISTEMA_TAG
		WHERE	K_SUB_SISTEMA_TAG=@PP_K_SUB_SISTEMA_TAG

	-- =========================================================
GO

-- ===============================================
SET NOCOUNT ON
-- ===============================================


---- ===================FORMA frmLots (SECUNDARIA/DEPENDE DE UN PADRE)============================
EXECUTE [dbo].[PG_CI_SUB_SISTEMA_TAG] 0, 0, 1,	'frmLots'

---- ===================FORMA frmHides (SECUNDARIA/DEPENDE DE UN PADRE)============================
EXECUTE [dbo].[PG_CI_SUB_SISTEMA_TAG] 0, 0, 2,	'frmHides'

GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================





-- //////////////////////////////////////////////////////////////
-- // SISTEMA_CONTROL
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SISTEMA_CONTROL] (
	[K_SISTEMA_CONTROL]			[INT]			NOT NULL,
	-- =================================	
	[K_SISTEMA_TAG]				INT				NOT NULL,	
	[D_SISTEMA_CONTROL]			VARCHAR(100)	NOT NULL
	-- =================================	
)ON [PRIMARY]	
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[SISTEMA_CONTROL]
	ADD CONSTRAINT [PK_SISTEMA_CONTROL]
		PRIMARY KEY CLUSTERED ([K_SISTEMA_CONTROL])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SISTEMA_CONTROL] ADD 
	CONSTRAINT [FK_SISTEMA_CONTROL_01]  
		FOREIGN KEY ([K_SISTEMA_TAG]) 
		REFERENCES [dbo].[SISTEMA_TAG] ([K_SISTEMA_TAG])
	
GO


-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SISTEMA_CONTROL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SISTEMA_CONTROL]
GO


CREATE PROCEDURE [dbo].[PG_CI_SISTEMA_CONTROL]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_SISTEMA_CONTROL			INT,
	@PP_K_SISTEMA_TAG				INT,
	@PP_D_SISTEMA_CONTROL			VARCHAR(100)
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_SISTEMA_CONTROL
							FROM	SISTEMA_CONTROL
							WHERE	K_SISTEMA_CONTROL=@PP_K_SISTEMA_CONTROL

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO SISTEMA_CONTROL	
			(	K_SISTEMA_CONTROL,					K_SISTEMA_TAG,		
				D_SISTEMA_CONTROL	)		
		VALUES	
			(	@PP_K_SISTEMA_CONTROL,				@PP_K_SISTEMA_TAG,
				@PP_D_SISTEMA_CONTROL	)
	ELSE
		UPDATE	SISTEMA_CONTROL
		SET		K_SISTEMA_TAG				= @PP_K_SISTEMA_TAG,
				D_SISTEMA_CONTROL			= @PP_D_SISTEMA_CONTROL
		WHERE	K_SISTEMA_CONTROL=@PP_K_SISTEMA_CONTROL

	-- =========================================================
GO

-- ===============================================
SET NOCOUNT ON
-- ===============================================

/*
use BD_GENERAL
SELECT * FROM SISTEMA_TAG WHERE D_SISTEMA_TAG = 'Transferencias'
select * from SISTEMA_CONTROL
SELECT * FROM USUARIO_PEARL WHERE K_USUARIO_TIPO IN (10,20,40,50) 
SELECT * FROM USUARIO_TIPO
SELECT * FROM USUARIO_PERMISOS WHERE K_SISTEMA_TAG = 6
WHERE K_SISTEMA_TAG = 32
AND K_USUARIO_PEARL  IN (SELECT K_USUARIO_PEARL FROM USUARIO_PEARL WHERE k_USUARIO_TIPO  IN (10,20,40,50) )

SELECT * FROM USUARIO_PEARL 
WHERE K_USUARIO_TIPO IN (10,20,40,50) 
AND K_USUARIO_PEARL IN (SELECT K_USUARIO_PEARL FROM USUARIO_PERMISOS WHERE K_SISTEMA_TAG = 6)
*/
-- ===================FORMA FoliosV2============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 1, 47,	'BT_ISSUE_OUT'

-- ===================FORMA frmLots (SECUNDARIA/DEPENDE DE UN PADRE)============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 20, 1,	'cmdDetails'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 21, 1,	'cmdSave'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 22, 1,	'TextBox3'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 23, 1,	'Button1'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 24, 1,	'cmdCBackout'

-- ===================FORMA Facturacion============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 30, 46,	'Button13'

-- ===================FORMA InvD============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 40, 16,	'GroupBox3'

-- ===================FORMA eng_main============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 50, 41,	'BT_UNLOCK'

-- ===================FORMA Planning============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 60, 5,	'BT_ORDEN_ELIMINAR'


-- ===================FORMA HorseDetail============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 70, 65,	'Button1'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 71, 65,	'Button3'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 72, 65,	'Button7'


-- ===================FORMA frmHides  (SECUNDARIA/DEPENDE DE UN PADRE)============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 80, 2,	'cmdSave'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 81, 2,	'TextBox3'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 82, 2,	'Button1'

-- ===================FORMA PatternsDatabase============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 90, 32,	'Button1'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 91, 32,	'Button2'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 92, 32,	'Button3'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 93, 32,	'Button4'
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 94, 32,	'Button6'

-- ===================FORMA Transferencias============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL] 0, 0, 100, 6,	'ComboBox1'

GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================





-- //////////////////////////////////////////////////////////////
-- // SISTEMA_CONTROL
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SISTEMA_CONTROL_PERMISO] (
	[K_SISTEMA_CONTROL_PERMISO]			[INT]		NOT NULL,
	-- =================================	
	[K_SISTEMA_CONTROL]				INT				NOT NULL,	
	[K_USUARIO]						INT				NOT NULL
	-- =================================	
)ON [PRIMARY]	
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[SISTEMA_CONTROL_PERMISO]
	ADD CONSTRAINT [PK_SISTEMA_CONTROL_PERMISO]
		PRIMARY KEY CLUSTERED ([K_SISTEMA_CONTROL_PERMISO])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SISTEMA_CONTROL_PERMISO] ADD 
	CONSTRAINT [FK_SISTEMA_CONTROL_PERMISO_01]  
		FOREIGN KEY ([K_USUARIO]) 
		REFERENCES [dbo].[USUARIO_PEARL] ([K_USUARIO_PEARL])
	
GO


-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SISTEMA_CONTROL_PERMISO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO]
GO


CREATE PROCEDURE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_SISTEMA_CONTROL_PERMISO	INT,
	@PP_K_SISTEMA_CONTROL			INT,
	@PP_K_USUARIO					VARCHAR(100)
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_SISTEMA_CONTROL_PERMISO
							FROM	SISTEMA_CONTROL_PERMISO
							WHERE	K_SISTEMA_CONTROL_PERMISO=@PP_K_SISTEMA_CONTROL_PERMISO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO SISTEMA_CONTROL_PERMISO	
			(	K_SISTEMA_CONTROL_PERMISO,					K_SISTEMA_CONTROL,
				K_USUARIO	
					)		
		VALUES	
			(	@PP_K_SISTEMA_CONTROL_PERMISO,				@PP_K_SISTEMA_CONTROL,
				@PP_K_USUARIO	)
	ELSE
		UPDATE	SISTEMA_CONTROL_PERMISO
		SET		K_SISTEMA_CONTROL			= @PP_K_SISTEMA_CONTROL,
				K_USUARIO	= @PP_K_USUARIO
		WHERE	K_SISTEMA_CONTROL_PERMISO=@PP_K_SISTEMA_CONTROL_PERMISO

	-- =========================================================
GO

-- ===============================================
SET NOCOUNT ON
-- ===============================================

/*
use BD_GENERAL
select * from sistema_tag where d_sistema_tag = 'eng_main'
select * from SISTEMA_CONTROL
select * from SISTEMA_CONTROL_PERMISO WHERE K_SISTEMA_CONTROL = 50
SELECT * FROM USUARIO_PEARL WHERE K_USARIO--k_USUARIO_TIPO = 70 --K_USUARIO_PEARL IN (144,41,139)
SELECT * FROM USUARIO_TIPO

SELECT  K_USUARIO_TIPO AS TIPO ,* FROM USUARIO_PEARL 
WHERE K_USUARIO_TIPO IN (10) 
AND K_USUARIO_PEARL IN (SELECT K_USUARIO_PEARL FROM USUARIO_PERMISOS WHERE K_SISTEMA_TAG = 41)

SELECT * FROM USUARIO_PERMISOS WHERE K_SISTEMA_TAG = 41
*/
-- ===================FORMA FoliosV2============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 1, 1,	144 -- FRANCISCOE / BOTON BT_ISSUE_OUT
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 2, 1,	89 -- VIVIANAC / BOTON BT_ISSUE_OUT
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 3, 1,	132 -- TERESAJ / BOTON BT_ISSUE_OUT

-- ===================FORMA frmLots  (SECUNDARIA/DEPENDE DE UN PADRE)============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 20, 20,	144 -- FRANCISCOE / BOTON cmdDetails
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 21, 20,	41 -- RAFAELF / BOTON cmdDetails
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 22, 20,	139 -- ALEJANDROD / BOTON cmdDetails

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 23, 21,	41 -- RAFAELF / BOTON cmdSave

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 24, 22,	41 -- RAFAELF / TextBox3

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 25, 23,	41 -- RAFAELF / BOTON Button1

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 26, 24,	144 -- FRANCISCOE / BOTON cmdCBackout
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 27, 24,	41 -- RAFAELF / BOTON cmdCBackout
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 28, 24,	139 -- ALEJANDROD / BOTON cmdCBackout

-- ===================FORMA Factuarion============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 30, 30,	41 -- RAFAELF / BOTON Button13

-- ===================FORMA InvD============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 40, 40,	41 -- RAFAELF /  GroupBox3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 41, 40,	59 -- ALEJANDROP / GroupBox3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 42, 40,	77 -- GENAROH /  GroupBox3


-- ===================FORMA eng_main============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 50, 50,	41 -- RAFAELF /  BT_UNLOCK / USUARIO TIPO A1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 51, 50,	89 -- VIVIANAC / BT_UNLOCK
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 52, 50,	139 -- ALEJANDROD / BT_UNLOCK
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 53, 50,	144 -- FRANCISCOE / BT_UNLOCK 
-- DELETE SISTEMA_CONTROL_PERMISO WHERE K_SISTEMA_CONTROL_PERMISO = 53 -- FRANCISCOE
-- ===================FORMA Planning============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 60, 60,	41 -- RAFAELF /  BT_ORDEN_ELIMINAR
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 61, 60,	45 -- PEDROV /  BT_ORDEN_ELIMINAR
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 62, 60,	56 -- MANUELG /  BT_ORDEN_ELIMINAR

-- ===================FORMA HorseDetail============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 70, 70,	41 -- RAFAELF /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 71, 70,	45 -- PEDROV /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 72, 70,	56 -- MANUELG /  Button1

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 73, 71,	41 -- RAFAELF /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 74, 71,	45 -- PEDROV /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 75, 71,	56 -- MANUELG /  Button3

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 76, 72,	41 -- RAFAELF /  Button7

-- ===================FORMA frmHides  (SECUNDARIA/DEPENDE DE UN PADRE)============================
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 80, 80,	41 -- RAFAELF /  cmdSave 
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 81, 80,	64 -- LEONORH /  cmdSave / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 82, 80,	67 -- GASPARH /  cmdSave / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 83, 80,	68 -- ARMIDAH /  cmdSave / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 84, 80,	73 -- YAMILEXQ /  cmdSave / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 85, 80,	93 -- MARIAR /  cmdSave / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 86, 80,	145 -- DULCEC /  cmdSave / USUARIO TIPO P1

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 87, 81,	41 -- RAFAELF /  TextBox3 
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 88, 81,	64 -- LEONORH /  TextBox3 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 89, 81,	67 -- GASPARH /  TextBox3 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 90, 81,	68 -- ARMIDAH /  TextBox3 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 91, 81,	73 -- YAMILEXQ /  TextBox3 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 92, 81,	93 -- MARIAR /  TextBox3 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 93, 81,	145 -- DULCEC /  TextBox3 / USUARIO TIPO P1

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 94, 82,	41 -- RAFAELF /  Button1 
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 95, 82,	64 -- LEONORH /  Button1 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 96, 82,	67 -- GASPARH /  Button1 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 97, 82,	68 -- ARMIDAH /  Button1 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 98, 82,	73 -- YAMILEXQ /  Button1 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 99, 82,	93 -- MARIAR /  Button1 / USUARIO TIPO P1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 100, 82, 145 -- DULCEC /  Button1 / USUARIO TIPO P1

-- ===================FORMA PatternsDatabase============================
/*
SELECT * FROM USUARIO_PEARL WHERE K_USUARIO_PEARL IN (123,63,88,96,114,41,42,139,144 )
*/
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 110, 90,	41 -- RAFAELF /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 111, 90,	42 -- OMARD /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 112, 90,	63 -- LUISP /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 113, 90,	88 -- SISTEMAS /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 114, 90,	96 -- SANTOSR /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 115, 90,	114 -- JOSUEC /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 116, 90,	123 -- JORGEN /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 117, 90,	139 -- ALEJANDROD /  Button1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 118, 90,	144 -- FRANCISCOE /  Button1

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 119, 91,	41 -- RAFAELF /  Button2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 120, 91,	42 -- OMARD /  Button2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 121, 91,	63 -- LUISP /  Button2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 122, 91,	88 -- SISTEMAS /  Button2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 123, 91,	96 -- SANTOSR /  Button2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 124, 91,	114 -- JOSUEC /  Button2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 125, 91,	123 -- JORGEN /  Button2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 126, 91,	139 -- ALEJANDROD /  Button2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 127, 91,	144 -- FRANCISCOE /  Button2

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 128, 92,	41 -- RAFAELF /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 129, 92,	42 -- OMARD /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 130, 92,	63 -- LUISP /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 131, 92,	88 -- SISTEMAS /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 132, 92,	96 -- SANTOSR /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 133, 92,	114 -- JOSUEC /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 134, 92,	123 -- JORGEN /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 135, 92,	139 -- ALEJANDROD /  Button3
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 136, 92,	144 -- FRANCISCOE /  Button3

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 137, 93,	41 -- RAFAELF /  Button4
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 138, 93,	42 -- OMARD /  Button4
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 139, 93,	63 -- LUISP /  Button4
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 140, 93,	88 -- SISTEMAS /  Button4
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 141, 93,	96 -- SANTOSR /  Button4
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 142, 93,	114 -- JOSUEC /  Button4
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 143, 93,	123 -- JORGEN /  Button4
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 144, 93,	139 -- ALEJANDROD /  Button4
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 145, 93,	144 -- FRANCISCOE /  Button4

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 146, 94,	41 -- RAFAELF /  Button6
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 147, 94,	42 -- OMARD /  Button6
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 148, 94,	63 -- LUISP /  Button6
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 149, 94,	88 -- SISTEMAS /  Button6
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 150, 94,	96 -- SANTOSR /  Button6
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 151, 94,	114 -- JOSUEC /  Button6
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 152, 94,	123 -- JORGEN /  Button6
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 153, 94,	139 -- ALEJANDROD /  Button6
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 154, 94,	144 -- FRANCISCOE /  Button6


-- ===================FORMA Transferencias============================
/*
SELECT * FROM USUARIO_TIPO WHERE K_USUARIO_TIPO IN (10,20,40,50)  
SELECT  K_USUARIO_TIPO AS TIPO ,* FROM USUARIO_PEARL 
WHERE K_USUARIO_TIPO IN (10,20,40,50) 
AND K_USUARIO_PEARL IN (SELECT K_USUARIO_PEARL FROM USUARIO_PERMISOS WHERE K_SISTEMA_TAG = 6)

10	ADMINISTRADOR A1	A1
20	ADMINISTRADOR Q1	Q1
40	USUARIO BASICO NIVEL 1	U1
50	USUARIO BASICO NIVEL 2	U2
*/

EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 170, 100,	41 -- RAFAELF /  ComboBox1 / USUARIO TIPO A1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 171, 100,	42 -- OMARD /  ComboBox1 / USUARIO TIPO Q1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 172, 100,	45 -- PEDROV / ComboBox1 / USUARIO TIPO U1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 173, 100,	47 -- MIGUELC / ComboBox1 / USUARIO TIPO Q1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 174, 100,	54 -- GILBERTOV / ComboBox1 / USUARIO TIPO U1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 175, 100,	56 -- MANUELG / ComboBox1 / USUARIO TIPO U2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 176, 100,	63 -- LUISP / ComboBox1 / USUARIO TIPO U1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 177, 100,	70 -- FERNANDOG / ComboBox1 / USUARIO TIPO U1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 178, 100,	72 -- DIANAN / ComboBox1 / USUARIO TIPO U1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 179, 100,	87 -- VIVIANAC / ComboBox1 / USUARIO TIPO Q1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 180, 100,	89 -- ERNESTOG / ComboBox1 / USUARIO TIPO U2
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 181, 100,	113-- JOSUEC / ComboBox1 / USUARIO TIPO U1
EXECUTE [dbo].[PG_CI_SISTEMA_CONTROL_PERMISO] 0, 0, 182, 100,	114-- RODOLFOC / ComboBox1 / USUARIO TIPO U1

GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================

GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
