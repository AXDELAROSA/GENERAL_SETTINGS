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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FORMA_PERMISO_ACCION]') AND type in (N'U'))
	DROP TABLE [dbo].[FORMA_PERMISO_ACCION]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_FORMA_PERMISO_ACCION]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_FORMA_PERMISO_ACCION]
GO


-- //////////////////////////////////////////////////////////////
-- // ESTATUS_FORMA_PERMISO_ACCION
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_FORMA_PERMISO_ACCION] (
	[K_ESTATUS_FORMA_PERMISO_ACCION]	[INT]			NOT NULL,
	[D_ESTATUS_FORMA_PERMISO_ACCION]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_FORMA_PERMISO_ACCION]	[VARCHAR] (10)	NOT NULL,
	[O_ESTATUS_FORMA_PERMISO_ACCION]	[INT]			NOT NULL,
	[C_ESTATUS_FORMA_PERMISO_ACCION]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_FORMA_PERMISO_ACCION]	[INT]			NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_FORMA_PERMISO_ACCION]
	ADD CONSTRAINT [PK_ESTATUS_FORMA_PERMISO_ACCION]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_FORMA_PERMISO_ACCION])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_FORMA_PERMISO_ACCION_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_FORMA_PERMISO_ACCION] ( [D_ESTATUS_FORMA_PERMISO_ACCION] )
GO

-- //////////////////////////////////////////////////////////////


--ALTER TABLE [dbo].[ESTATUS_FORMA_PERMISO_ACCION] ADD 
--	CONSTRAINT [FK_ESTATUS_FORMA_PERMISO_ACCION_01] 
--		FOREIGN KEY ( [L_ESTATUS_FORMA_PERMISO_ACCION] ) 
--		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
--GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_FORMA_PERMISO_ACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_FORMA_PERMISO_ACCION]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_FORMA_PERMISO_ACCION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_FORMA_PERMISO_ACCION	INT,
	@PP_D_ESTATUS_FORMA_PERMISO_ACCION	VARCHAR(100),
	@PP_S_ESTATUS_FORMA_PERMISO_ACCION	VARCHAR(10),
	@PP_O_ESTATUS_FORMA_PERMISO_ACCION	INT,
	@PP_C_ESTATUS_FORMA_PERMISO_ACCION	VARCHAR(255),
	@PP_L_ESTATUS_FORMA_PERMISO_ACCION	INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_FORMA_PERMISO_ACCION
							FROM	ESTATUS_FORMA_PERMISO_ACCION
							WHERE	K_ESTATUS_FORMA_PERMISO_ACCION=@PP_K_ESTATUS_FORMA_PERMISO_ACCION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_FORMA_PERMISO_ACCION	
			(	K_ESTATUS_FORMA_PERMISO_ACCION,				D_ESTATUS_FORMA_PERMISO_ACCION, 
				S_ESTATUS_FORMA_PERMISO_ACCION,				O_ESTATUS_FORMA_PERMISO_ACCION,
				C_ESTATUS_FORMA_PERMISO_ACCION,
				L_ESTATUS_FORMA_PERMISO_ACCION				)		
		VALUES	
			(	@PP_K_ESTATUS_FORMA_PERMISO_ACCION,			@PP_D_ESTATUS_FORMA_PERMISO_ACCION,	
				@PP_S_ESTATUS_FORMA_PERMISO_ACCION,			@PP_O_ESTATUS_FORMA_PERMISO_ACCION,
				@PP_C_ESTATUS_FORMA_PERMISO_ACCION,
				@PP_L_ESTATUS_FORMA_PERMISO_ACCION			)
	ELSE
		UPDATE	ESTATUS_FORMA_PERMISO_ACCION
		SET		D_ESTATUS_FORMA_PERMISO_ACCION	= @PP_D_ESTATUS_FORMA_PERMISO_ACCION,	
				S_ESTATUS_FORMA_PERMISO_ACCION	= @PP_S_ESTATUS_FORMA_PERMISO_ACCION,			
				O_ESTATUS_FORMA_PERMISO_ACCION	= @PP_O_ESTATUS_FORMA_PERMISO_ACCION,
				C_ESTATUS_FORMA_PERMISO_ACCION	= @PP_C_ESTATUS_FORMA_PERMISO_ACCION,
				L_ESTATUS_FORMA_PERMISO_ACCION	= @PP_L_ESTATUS_FORMA_PERMISO_ACCION	
		WHERE	K_ESTATUS_FORMA_PERMISO_ACCION=@PP_K_ESTATUS_FORMA_PERMISO_ACCION

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_FORMA_PERMISO_ACCION] 0, 0, 0, 'INACTIVO',			'INACTVO', 0, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_FORMA_PERMISO_ACCION] 0, 0, 1, 'ACTIVO',			'ACTIVO', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_FORMA_PERMISO_ACCION] 0, 0, 2, 'SUSPENDIDO',		'SUSPNDO', 2, '', 1

GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // FORMA_PERMISO_ACCION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[FORMA_PERMISO_ACCION] (
	[K_FORMA_PERMISO_ACCION]			[INT]			NOT NULL,
	-- =================================	
	[D_FORMA_PERMISO_ACCION]			VARCHAR(100)	NOT NULL,	
	[BOTON]								VARCHAR(50)		NOT NULL,
	-- =================================
	[K_USUARIO]							[INT]			NOT NULL,	
	[K_ESTATUS_FORMA_PERMISO_ACCION]	[INT]			NOT NULL,
	-- =================================	
)ON [PRIMARY]	
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[FORMA_PERMISO_ACCION]
	ADD CONSTRAINT [PK_FORMA_PERMISO_ACCION]
		PRIMARY KEY CLUSTERED ([K_FORMA_PERMISO_ACCION])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[FORMA_PERMISO_ACCION] ADD 
	CONSTRAINT [FK_FORMA_PERMISO_ACCION_01]  
		FOREIGN KEY ([K_ESTATUS_FORMA_PERMISO_ACCION]) 
		REFERENCES [dbo].[ESTATUS_FORMA_PERMISO_ACCION] ([K_ESTATUS_FORMA_PERMISO_ACCION])
	
GO


-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FORMA_PERMISO_ACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FORMA_PERMISO_ACCION]
GO


CREATE PROCEDURE [dbo].[PG_CI_FORMA_PERMISO_ACCION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_FORMA_PERMISO_ACCION		INT,
	@PP_D_FORMA_PERMISO_ACCION		VARCHAR(100),
	@PP_BOTON						VARCHAR(50),
	@PP_K_USUARIO					INT,
	@PP_K_ESTATUS_PERMISO_ACCION	INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_FORMA_PERMISO_ACCION
							FROM	FORMA_PERMISO_ACCION
							WHERE	K_FORMA_PERMISO_ACCION=@PP_K_FORMA_PERMISO_ACCION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO FORMA_PERMISO_ACCION	
			(	K_FORMA_PERMISO_ACCION,				D_FORMA_PERMISO_ACCION, 
				BOTON,								K_USUARIO,
				K_ESTATUS_FORMA_PERMISO_ACCION				)		
		VALUES	
			(	@PP_K_FORMA_PERMISO_ACCION,			@PP_D_FORMA_PERMISO_ACCION,	
				@PP_BOTON,							@PP_K_USUARIO,
				@PP_K_ESTATUS_PERMISO_ACCION			)
	ELSE
		UPDATE	FORMA_PERMISO_ACCION
		SET		D_FORMA_PERMISO_ACCION			= @PP_D_FORMA_PERMISO_ACCION,	
				BOTON							= @PP_BOTON,			
				K_USUARIO						= @PP_K_USUARIO,
				K_ESTATUS_FORMA_PERMISO_ACCION	= @PP_K_ESTATUS_PERMISO_ACCION	
		WHERE	K_FORMA_PERMISO_ACCION=@PP_K_FORMA_PERMISO_ACCION

	-- =========================================================
GO

-- ===============================================
SET NOCOUNT ON
-- ===============================================
/*
 K_ESTATUS_FORMA_PERMISO_ACCION
0, 'INACTIVO',	
1, 'ACTIVO',	
2, 'SUSPENDIDO',
*/


/*
use BD_GENERAL
select * from USUARIO_PEARL
SELECT * FROM FORMA_PERMISO_ACCION
*/
-- ===================FORMA FoliosV2============================
EXECUTE [dbo].[PG_CI_FORMA_PERMISO_ACCION] 0, 0, 1, 'FoliosV2',		'BT_ISSUE_OUT', 144, 1
EXECUTE [dbo].[PG_CI_FORMA_PERMISO_ACCION] 0, 0, 2, 'FoliosV2',		'BT_ISSUE_OUT', 89, 1 
EXECUTE [dbo].[PG_CI_FORMA_PERMISO_ACCION] 0, 0, 3, 'FoliosV2',		'BT_ISSUE_OUT', 132, 1 

GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================

GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
