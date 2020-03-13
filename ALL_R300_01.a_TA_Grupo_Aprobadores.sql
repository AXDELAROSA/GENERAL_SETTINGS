-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	RH
-- // MODULO:			
-- // OPERACION:		GRUPO_APROBADOR DESCRIPCION
-- //////////////////////////////////////////////////////////////
-- // Autor:			FEG
-- // Fecha creación:	04/FEB/2020
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////






-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GRUPO_APROBADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[GRUPO_APROBADOR]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_GRUPO_APROBADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_GRUPO_APROBADOR]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_GRUPO_APROBADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_GRUPO_APROBADOR]
GO



-- //////////////////////////////////////////////////////////////
-- // TIPO_GRUPO_APROBADOR
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[TIPO_GRUPO_APROBADOR] (
	[K_TIPO_GRUPO_APROBADOR]	[INT]			NOT NULL,
	[D_TIPO_GRUPO_APROBADOR]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_GRUPO_APROBADOR]	[VARCHAR] (20)	NOT NULL,
	[O_TIPO_GRUPO_APROBADOR]	[INT]			NOT NULL,
	[C_TIPO_GRUPO_APROBADOR]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_GRUPO_APROBADOR]	[INT]			NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_GRUPO_APROBADOR]
	ADD CONSTRAINT [PK_TIPO_GRUPO_APROBADOR]
		PRIMARY KEY CLUSTERED ([K_TIPO_GRUPO_APROBADOR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_GRUPO_APROBADOR_01_DESCRIPCION] 
	   ON [dbo].[TIPO_GRUPO_APROBADOR] ( [D_TIPO_GRUPO_APROBADOR] )
GO

-- //////////////////////////////////////////////////////////////


--ALTER TABLE [dbo].[TIPO_GRUPO_APROBADOR] ADD 
--	CONSTRAINT [FK_TIPO_GRUPO_APROBADOR_01] 
--		FOREIGN KEY ( [L_TIPO_GRUPO_APROBADOR] ) 
--		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
--GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_GRUPO_APROBADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_GRUPO_APROBADOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_GRUPO_APROBADOR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_GRUPO_APROBADOR	INT,
	@PP_D_TIPO_GRUPO_APROBADOR	VARCHAR(100),
	@PP_S_TIPO_GRUPO_APROBADOR	VARCHAR(20),
	@PP_O_TIPO_GRUPO_APROBADOR	INT,
	@PP_C_TIPO_GRUPO_APROBADOR	VARCHAR(255),
	@PP_L_TIPO_GRUPO_APROBADOR	INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_GRUPO_APROBADOR
							FROM	TIPO_GRUPO_APROBADOR
							WHERE	K_TIPO_GRUPO_APROBADOR=@PP_K_TIPO_GRUPO_APROBADOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_GRUPO_APROBADOR	
			(	K_TIPO_GRUPO_APROBADOR,				D_TIPO_GRUPO_APROBADOR, 
				S_TIPO_GRUPO_APROBADOR,				O_TIPO_GRUPO_APROBADOR,
				C_TIPO_GRUPO_APROBADOR,
				L_TIPO_GRUPO_APROBADOR				)		
		VALUES	
			(	@PP_K_TIPO_GRUPO_APROBADOR,			@PP_D_TIPO_GRUPO_APROBADOR,	
				@PP_S_TIPO_GRUPO_APROBADOR,			@PP_O_TIPO_GRUPO_APROBADOR,
				@PP_C_TIPO_GRUPO_APROBADOR,
				@PP_L_TIPO_GRUPO_APROBADOR			)
	ELSE
		UPDATE	TIPO_GRUPO_APROBADOR
		SET		D_TIPO_GRUPO_APROBADOR	= @PP_D_TIPO_GRUPO_APROBADOR,	
				S_TIPO_GRUPO_APROBADOR	= @PP_S_TIPO_GRUPO_APROBADOR,			
				O_TIPO_GRUPO_APROBADOR	= @PP_O_TIPO_GRUPO_APROBADOR,
				C_TIPO_GRUPO_APROBADOR	= @PP_C_TIPO_GRUPO_APROBADOR,
				L_TIPO_GRUPO_APROBADOR	= @PP_L_TIPO_GRUPO_APROBADOR	
		WHERE	K_TIPO_GRUPO_APROBADOR=@PP_K_TIPO_GRUPO_APROBADOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

--=========PARA DESCRIPCION DE PUESTOS========================================
EXECUTE [dbo].[PG_CI_TIPO_GRUPO_APROBADOR] 0, 0, 1, 'CREAR DESCRIPCION PUESTO',		'CREA_DP', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_GRUPO_APROBADOR] 0, 0, 2, 'AUTORIZAR DESCRIPCION PUESTO',	'AUTOR_DP', 2, '', 1
EXECUTE [dbo].[PG_CI_TIPO_GRUPO_APROBADOR] 0, 0, 3, 'NOTIFICAR DESCRIPCION PUESTO',	'NOTIF_DP', 3, '', 1

--=========PARA DESCRIPCION DE PUESTOS========================================
EXECUTE [dbo].[PG_CI_TIPO_GRUPO_APROBADOR] 0, 0, 21, 'MQU SALIDA',					'MQU_SAL', 21, '', 1
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_GRUPO_APROBADOR
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_GRUPO_APROBADOR] (
	[K_ESTATUS_GRUPO_APROBADOR]	[INT]			NOT NULL,
	[D_ESTATUS_GRUPO_APROBADOR]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_GRUPO_APROBADOR]	[VARCHAR] (10)	NOT NULL,
	[O_ESTATUS_GRUPO_APROBADOR]	[INT]			NOT NULL,
	[C_ESTATUS_GRUPO_APROBADOR]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_GRUPO_APROBADOR]	[INT]			NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_GRUPO_APROBADOR]
	ADD CONSTRAINT [PK_ESTATUS_GRUPO_APROBADOR]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_GRUPO_APROBADOR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_GRUPO_APROBADOR_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_GRUPO_APROBADOR] ( [D_ESTATUS_GRUPO_APROBADOR] )
GO

-- //////////////////////////////////////////////////////////////


--ALTER TABLE [dbo].[ESTATUS_GRUPO_APROBADOR] ADD 
--	CONSTRAINT [FK_ESTATUS_GRUPO_APROBADOR_01] 
--		FOREIGN KEY ( [L_ESTATUS_GRUPO_APROBADOR] ) 
--		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
--GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_GRUPO_APROBADOR	INT,
	@PP_D_ESTATUS_GRUPO_APROBADOR	VARCHAR(100),
	@PP_S_ESTATUS_GRUPO_APROBADOR	VARCHAR(10),
	@PP_O_ESTATUS_GRUPO_APROBADOR	INT,
	@PP_C_ESTATUS_GRUPO_APROBADOR	VARCHAR(255),
	@PP_L_ESTATUS_GRUPO_APROBADOR	INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_GRUPO_APROBADOR
							FROM	ESTATUS_GRUPO_APROBADOR
							WHERE	K_ESTATUS_GRUPO_APROBADOR=@PP_K_ESTATUS_GRUPO_APROBADOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_GRUPO_APROBADOR	
			(	K_ESTATUS_GRUPO_APROBADOR,				D_ESTATUS_GRUPO_APROBADOR, 
				S_ESTATUS_GRUPO_APROBADOR,				O_ESTATUS_GRUPO_APROBADOR,
				C_ESTATUS_GRUPO_APROBADOR,
				L_ESTATUS_GRUPO_APROBADOR				)		
		VALUES	
			(	@PP_K_ESTATUS_GRUPO_APROBADOR,			@PP_D_ESTATUS_GRUPO_APROBADOR,	
				@PP_S_ESTATUS_GRUPO_APROBADOR,			@PP_O_ESTATUS_GRUPO_APROBADOR,
				@PP_C_ESTATUS_GRUPO_APROBADOR,
				@PP_L_ESTATUS_GRUPO_APROBADOR			)
	ELSE
		UPDATE	ESTATUS_GRUPO_APROBADOR
		SET		D_ESTATUS_GRUPO_APROBADOR	= @PP_D_ESTATUS_GRUPO_APROBADOR,	
				S_ESTATUS_GRUPO_APROBADOR	= @PP_S_ESTATUS_GRUPO_APROBADOR,			
				O_ESTATUS_GRUPO_APROBADOR	= @PP_O_ESTATUS_GRUPO_APROBADOR,
				C_ESTATUS_GRUPO_APROBADOR	= @PP_C_ESTATUS_GRUPO_APROBADOR,
				L_ESTATUS_GRUPO_APROBADOR	= @PP_L_ESTATUS_GRUPO_APROBADOR	
		WHERE	K_ESTATUS_GRUPO_APROBADOR=@PP_K_ESTATUS_GRUPO_APROBADOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR] 0, 0, 0, 'INACTIVO',			'INACTVO', 0, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR] 0, 0, 1, 'ACTIVO',			'ACTIVO', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR] 0, 0, 2, 'SUSPENDIDO',		'SUSPNDO', 2, '', 1
--EXECUTE [dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR] 0, 0, 3, 'APROVADO',			'APROV', 3, '', 1
--EXECUTE [dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR] 0, 0, 4, 'CANCELADO',			'CANCEL', 4, '', 1
--EXECUTE [dbo].[PG_CI_ESTATUS_GRUPO_APROBADOR] 0, 0, 4, 'VENCIDO',			'CANCEL', 4, '', 1

GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // GRUPO_APROBADOR
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[GRUPO_APROBADOR] (
	[K_GRUPO_APROBADOR]				[INT]			NOT NULL,
	-- =================================	
	[D_GRUPO_APROBADOR]				VARCHAR(100)	NOT NULL,	
	[S_GRUPO_APROBADOR]				VARCHAR(50)		NOT NULL,
	-- =================================
	[K_USUARIO]						[INT]			NOT NULL,
	[K_TIPO_GRUPO_APROBADOR]		[INT]			NOT NULL,	
	[K_ESTATUS_GRUPO_APROBADOR]		[INT]			NOT NULL,
	-- =================================	
)ON [PRIMARY]	
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[GRUPO_APROBADOR]
	ADD CONSTRAINT [PK_GRUPO_APROBADOR]
		PRIMARY KEY CLUSTERED ([K_GRUPO_APROBADOR])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[GRUPO_APROBADOR] ADD 
	CONSTRAINT [FK_GRUPO_APROBADOR_01]  
		FOREIGN KEY ([K_ESTATUS_GRUPO_APROBADOR]) 
		REFERENCES [dbo].[ESTATUS_GRUPO_APROBADOR] ([K_ESTATUS_GRUPO_APROBADOR]),
	CONSTRAINT [FK_GRUPO_APROBADOR_02]  
		FOREIGN KEY ([K_TIPO_GRUPO_APROBADOR]) 
		REFERENCES [dbo].[TIPO_GRUPO_APROBADOR] ([K_TIPO_GRUPO_APROBADOR])
	--CONSTRAINT [FK_GRUPO_APROBADOR_03]  
	--	FOREIGN KEY ([K_USUARIO]) 
	--	REFERENCES DATA_02.[dbo].[users_pearl] ([codigo])
GO


-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_GRUPO_APROBADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_GRUPO_APROBADOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_GRUPO_APROBADOR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_GRUPO_APROBADOR		INT,
	@PP_D_GRUPO_APROBADOR		VARCHAR(100),
	@PP_S_GRUPO_APROBADOR		VARCHAR(10),
	@PP_K_USUARIO				INT,
	@PP_K_TIPO_GRUPO_APROBADOR	INT,
	@PP_K_ESTATUS_APROBADOR		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_GRUPO_APROBADOR
							FROM	GRUPO_APROBADOR
							WHERE	K_GRUPO_APROBADOR=@PP_K_GRUPO_APROBADOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO GRUPO_APROBADOR	
			(	K_GRUPO_APROBADOR,				D_GRUPO_APROBADOR, 
				S_GRUPO_APROBADOR,				K_USUARIO,
				K_TIPO_GRUPO_APROBADOR,
				K_ESTATUS_GRUPO_APROBADOR				)		
		VALUES	
			(	@PP_K_GRUPO_APROBADOR,			@PP_D_GRUPO_APROBADOR,	
				@PP_S_GRUPO_APROBADOR,			@PP_K_USUARIO,
				@PP_K_TIPO_GRUPO_APROBADOR,
				@PP_K_ESTATUS_APROBADOR			)
	ELSE
		UPDATE	GRUPO_APROBADOR
		SET		D_GRUPO_APROBADOR			= @PP_D_GRUPO_APROBADOR,	
				S_GRUPO_APROBADOR			= @PP_S_GRUPO_APROBADOR,			
				K_USUARIO					= @PP_K_USUARIO,
				K_TIPO_GRUPO_APROBADOR		= @PP_K_TIPO_GRUPO_APROBADOR,
				K_ESTATUS_GRUPO_APROBADOR	= @PP_K_ESTATUS_APROBADOR	
		WHERE	K_GRUPO_APROBADOR=@PP_K_GRUPO_APROBADOR

	-- =========================================================
GO



-- ===============================================
SET NOCOUNT ON
-- ===============================================
-- select * from DATA_02.DBO.users_pearl
EXECUTE [dbo].[PG_CI_GRUPO_APROBADOR] 0, 0, 1, 'APROBADORES DESCRIPCION DE PUESTO',		'APROB_DP', 144, 1, 1
EXECUTE [dbo].[PG_CI_GRUPO_APROBADOR] 0, 0, 2, 'APROBADORES DESCRIPCION DE PUESTO',		'APROB_DP', 139, 2, 1
EXECUTE [dbo].[PG_CI_GRUPO_APROBADOR] 0, 0, 3, 'APROBADORES DESCRIPCION DE PUESTO',		'APROB_DP', 41, 3, 1
EXECUTE [dbo].[PG_CI_GRUPO_APROBADOR] 0, 0, 4, 'AUTORIZAR SALIDA MQU',					'AUT_SAL_MQU', 144, 21, 0
EXECUTE [dbo].[PG_CI_GRUPO_APROBADOR] 0, 0, 5, 'AUTORIZAR SALIDA MQU',					'AUT_SAL_MQU', 89, 21, 1 --VIVIANAC
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================

GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
