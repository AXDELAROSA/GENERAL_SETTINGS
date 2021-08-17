-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	[BD_GENERAL]
-- // MODULO:			
-- // OPERACION:		RUTA_ARCHIVO
-- //////////////////////////////////////////////////////////////
-- // Autor:			FEG
-- // Fecha creación:	14/ABR/2021
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RUTA_ARCHIVO]') AND type in (N'U'))
	DROP TABLE [dbo].[RUTA_ARCHIVO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_RUTA_ARCHIVO]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_RUTA_ARCHIVO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_RUTA_ARCHIVO]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_RUTA_ARCHIVO]
GO


-- //////////////////////////////////////////////////////////////
-- // ESTATUS_RUTA_ARCHIVO
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_RUTA_ARCHIVO] (
	[K_ESTATUS_RUTA_ARCHIVO]	[INT]			NOT NULL,
	[D_ESTATUS_RUTA_ARCHIVO]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_RUTA_ARCHIVO]	[VARCHAR] (10)	NOT NULL,
	[O_ESTATUS_RUTA_ARCHIVO]	[INT]			NOT NULL,
	[C_ESTATUS_RUTA_ARCHIVO]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_RUTA_ARCHIVO]	[INT]			NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_RUTA_ARCHIVO]
	ADD CONSTRAINT [PK_ESTATUS_RUTA_ARCHIVO]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_RUTA_ARCHIVO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_RUTA_ARCHIVO_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_RUTA_ARCHIVO] ( [D_ESTATUS_RUTA_ARCHIVO] )
GO

-- //////////////////////////////////////////////////////////////


--ALTER TABLE [dbo].[ESTATUS_RUTA_ARCHIVO] ADD 
--	CONSTRAINT [FK_ESTATUS_RUTA_ARCHIVO_01] 
--		FOREIGN KEY ( [L_ESTATUS_RUTA_ARCHIVO] ) 
--		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
--GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_RUTA_ARCHIVO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_RUTA_ARCHIVO]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_RUTA_ARCHIVO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_RUTA_ARCHIVO	INT,
	@PP_D_ESTATUS_RUTA_ARCHIVO	VARCHAR(100),
	@PP_S_ESTATUS_RUTA_ARCHIVO	VARCHAR(10),
	@PP_O_ESTATUS_RUTA_ARCHIVO	INT,
	@PP_C_ESTATUS_RUTA_ARCHIVO	VARCHAR(255),
	@PP_L_ESTATUS_RUTA_ARCHIVO	INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_RUTA_ARCHIVO
							FROM	ESTATUS_RUTA_ARCHIVO
							WHERE	K_ESTATUS_RUTA_ARCHIVO=@PP_K_ESTATUS_RUTA_ARCHIVO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_RUTA_ARCHIVO	
			(	K_ESTATUS_RUTA_ARCHIVO,				D_ESTATUS_RUTA_ARCHIVO, 
				S_ESTATUS_RUTA_ARCHIVO,				O_ESTATUS_RUTA_ARCHIVO,
				C_ESTATUS_RUTA_ARCHIVO,
				L_ESTATUS_RUTA_ARCHIVO				)		
		VALUES	
			(	@PP_K_ESTATUS_RUTA_ARCHIVO,			@PP_D_ESTATUS_RUTA_ARCHIVO,	
				@PP_S_ESTATUS_RUTA_ARCHIVO,			@PP_O_ESTATUS_RUTA_ARCHIVO,
				@PP_C_ESTATUS_RUTA_ARCHIVO,
				@PP_L_ESTATUS_RUTA_ARCHIVO			)
	ELSE
		UPDATE	ESTATUS_RUTA_ARCHIVO
		SET		D_ESTATUS_RUTA_ARCHIVO	= @PP_D_ESTATUS_RUTA_ARCHIVO,	
				S_ESTATUS_RUTA_ARCHIVO	= @PP_S_ESTATUS_RUTA_ARCHIVO,			
				O_ESTATUS_RUTA_ARCHIVO	= @PP_O_ESTATUS_RUTA_ARCHIVO,
				C_ESTATUS_RUTA_ARCHIVO	= @PP_C_ESTATUS_RUTA_ARCHIVO,
				L_ESTATUS_RUTA_ARCHIVO	= @PP_L_ESTATUS_RUTA_ARCHIVO	
		WHERE	K_ESTATUS_RUTA_ARCHIVO=@PP_K_ESTATUS_RUTA_ARCHIVO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_RUTA_ARCHIVO] 0, 0, 0, 'INACTIVO',			'INACTVO', 0, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_RUTA_ARCHIVO] 0, 0, 1, 'ACTIVO',			'ACTIVO', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_RUTA_ARCHIVO] 0, 0, 2, 'SUSPENDIDO',		'SUSPNDO', 2, '', 1

GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////
-- // TIPO_RUTA_ARCHIVO
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[TIPO_RUTA_ARCHIVO] (
	[K_TIPO_RUTA_ARCHIVO]	[INT]			NOT NULL,
	[D_TIPO_RUTA_ARCHIVO]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_RUTA_ARCHIVO]	[VARCHAR] (20)	NOT NULL,
	[O_TIPO_RUTA_ARCHIVO]	[INT]			NOT NULL,
	[C_TIPO_RUTA_ARCHIVO]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_RUTA_ARCHIVO]	[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[TIPO_RUTA_ARCHIVO]
	ADD CONSTRAINT [PK_TIPO_RUTA_ARCHIVO]
		PRIMARY KEY CLUSTERED ([K_TIPO_RUTA_ARCHIVO])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_RUTA_ARCHIVO_01_DESCRIPCION] 
	   ON [dbo].[TIPO_RUTA_ARCHIVO] ( [D_TIPO_RUTA_ARCHIVO] )
GO
-- //////////////////////////////////////////////////////////////
--ALTER TABLE [dbo].[TIPO_RUTA_ARCHIVO] ADD 
--	CONSTRAINT [FK_TIPO_RUTA_ARCHIVO_01] 
--		FOREIGN KEY ( [L_TIPO_RUTA_ARCHIVO] ) 
--		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
--GO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_RUTA_ARCHIVO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_RUTA_ARCHIVO]
GO
CREATE PROCEDURE [dbo].[PG_CI_TIPO_RUTA_ARCHIVO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_RUTA_ARCHIVO	INT,
	@PP_D_TIPO_RUTA_ARCHIVO	VARCHAR(100),
	@PP_S_TIPO_RUTA_ARCHIVO	VARCHAR(20),
	@PP_O_TIPO_RUTA_ARCHIVO	INT,
	@PP_C_TIPO_RUTA_ARCHIVO	VARCHAR(255),
	@PP_L_TIPO_RUTA_ARCHIVO	INT
AS
	-- ===============================
	DECLARE @VP_K_EXISTE	INT
	SELECT	@VP_K_EXISTE =	K_TIPO_RUTA_ARCHIVO
							FROM	TIPO_RUTA_ARCHIVO
							WHERE	K_TIPO_RUTA_ARCHIVO=@PP_K_TIPO_RUTA_ARCHIVO
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_RUTA_ARCHIVO	
			(	K_TIPO_RUTA_ARCHIVO,				D_TIPO_RUTA_ARCHIVO, 
				S_TIPO_RUTA_ARCHIVO,				O_TIPO_RUTA_ARCHIVO,
				C_TIPO_RUTA_ARCHIVO,
				L_TIPO_RUTA_ARCHIVO				)		
		VALUES	
			(	@PP_K_TIPO_RUTA_ARCHIVO,			@PP_D_TIPO_RUTA_ARCHIVO,	
				@PP_S_TIPO_RUTA_ARCHIVO,			@PP_O_TIPO_RUTA_ARCHIVO,
				@PP_C_TIPO_RUTA_ARCHIVO,
				@PP_L_TIPO_RUTA_ARCHIVO			)
	ELSE
		UPDATE	TIPO_RUTA_ARCHIVO
		SET		D_TIPO_RUTA_ARCHIVO	= @PP_D_TIPO_RUTA_ARCHIVO,	
				S_TIPO_RUTA_ARCHIVO	= @PP_S_TIPO_RUTA_ARCHIVO,			
				O_TIPO_RUTA_ARCHIVO	= @PP_O_TIPO_RUTA_ARCHIVO,
				C_TIPO_RUTA_ARCHIVO	= @PP_C_TIPO_RUTA_ARCHIVO,
				L_TIPO_RUTA_ARCHIVO	= @PP_L_TIPO_RUTA_ARCHIVO	
		WHERE	K_TIPO_RUTA_ARCHIVO=@PP_K_TIPO_RUTA_ARCHIVO
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////
-- ===============================================
SET NOCOUNT ON
-- ===============================================

--=========PARA DESCRIPCION DE PUESTOS========================================
EXECUTE [dbo].[PG_CI_TIPO_RUTA_ARCHIVO] 0, 0, 1, '.PNG',		'PNG', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA_ARCHIVO] 0, 0, 2, '.JPG',		'JPG', 2, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA_ARCHIVO] 0, 0, 3, '.PDF',		'PDF', 3, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA_ARCHIVO] 0, 0, 4, '.JPEG',		'JPEG', 4, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA_ARCHIVO] 0, 0, 5, '.xlsx',		'EXCEL', 5, '', 1 

GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////
-- // RUTA_ARCHIVO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[RUTA_ARCHIVO] (
	[K_RUTA_ARCHIVO]				[INT]			NOT NULL,
	-- =================================	
	[D_RUTA_ARCHIVO]				VARCHAR(255)	NOT NULL,	
	[SERVIDOR]						VARCHAR(255)	NOT NULL,	
	[RUTA]							VARCHAR(255)	NOT NULL,
	-- =================================
	[NOMBRE_ARCHIVO]				VARCHAR(255)	NOT NULL,
	[K_TIPO_RUTA_ARCHIVO]			[INT]			NOT NULL,	
	[K_ESTATUS_RUTA_ARCHIVO]		[INT]			NOT NULL,
	-- =================================	
)ON [PRIMARY]	
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[RUTA_ARCHIVO]
	ADD CONSTRAINT [PK_RUTA_ARCHIVO]
		PRIMARY KEY CLUSTERED ([K_RUTA_ARCHIVO])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[RUTA_ARCHIVO] ADD 
	CONSTRAINT [FK_RUTA_ARCHIVO_01]  
		FOREIGN KEY ([K_ESTATUS_RUTA_ARCHIVO]) 
		REFERENCES [dbo].[ESTATUS_RUTA_ARCHIVO] ([K_ESTATUS_RUTA_ARCHIVO]),
	CONSTRAINT [FK_RUTA_ARCHIVO_02]  
		FOREIGN KEY ([K_TIPO_RUTA_ARCHIVO]) 
		REFERENCES [dbo].[TIPO_RUTA_ARCHIVO] ([K_TIPO_RUTA_ARCHIVO])
	--CONSTRAINT [FK_RUTA_ARCHIVO_03]  
	--	FOREIGN KEY ([K_USUARIO]) 
	--	REFERENCES DATA_02.[dbo].[users_pearl] ([codigo])
GO


-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_RUTA_ARCHIVO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_RUTA_ARCHIVO]
GO


CREATE PROCEDURE [dbo].[PG_CI_RUTA_ARCHIVO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_RUTA_ARCHIVO			INT,
	@PP_D_RUTA_ARCHIVO			VARCHAR(255),
	@PP_SERVIDOR				VARCHAR(255),
	@PP_RUTA					VARCHAR(255),
	@PP_NOMBRE_ARCHIVO			VARCHAR(255),
	@PP_K_TIPO_RUTA_ARCHIVO		INT,
	@PP_K_ESTATUS_APROBADOR		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_RUTA_ARCHIVO
							FROM	RUTA_ARCHIVO
							WHERE	K_RUTA_ARCHIVO=@PP_K_RUTA_ARCHIVO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO RUTA_ARCHIVO	
			(	K_RUTA_ARCHIVO,				D_RUTA_ARCHIVO,	
				SERVIDOR, 
				RUTA,						NOMBRE_ARCHIVO,
				K_TIPO_RUTA_ARCHIVO,
				K_ESTATUS_RUTA_ARCHIVO				)		
		VALUES	
			(	@PP_K_RUTA_ARCHIVO,			@PP_D_RUTA_ARCHIVO,
				@PP_SERVIDOR,	
				@PP_RUTA,					@PP_NOMBRE_ARCHIVO,
				@PP_K_TIPO_RUTA_ARCHIVO,
				@PP_K_ESTATUS_APROBADOR			)
	ELSE
		UPDATE	RUTA_ARCHIVO
		SET		D_RUTA_ARCHIVO			= @PP_D_RUTA_ARCHIVO,
				SERVIDOR				= @PP_SERVIDOR,	
				RUTA					= @PP_RUTA,			
				NOMBRE_ARCHIVO			= @PP_NOMBRE_ARCHIVO,
				K_TIPO_RUTA_ARCHIVO		= @PP_K_TIPO_RUTA_ARCHIVO,
				K_ESTATUS_RUTA_ARCHIVO	= @PP_K_ESTATUS_APROBADOR	
		WHERE	K_RUTA_ARCHIVO=@PP_K_RUTA_ARCHIVO

	-- =========================================================
GO



-- ===============================================
SET NOCOUNT ON
-- ===============================================
-- USE BD_GENERAL
--SELECT * FROM RUTA_ARCHIVO
-- ===============================================
EXECUTE [dbo].[PG_CI_RUTA_ARCHIVO] 0, 0, 1, 'INSPECCION_IMG_MASTER_QC', '\\10.1.1.5',		'\documents\IT\001_DEVELOPER_FILES\ICONOS\', 'FWLNPX7', 1, 1 -- EXTENSION PNG

SET NOCOUNT OFF
-- ===============================================

GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
