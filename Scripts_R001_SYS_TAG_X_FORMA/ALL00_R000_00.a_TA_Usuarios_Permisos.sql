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
-- SELECT * FROM USUARIO_PERMISOS_MENU
-- SELECT * FROM USUARIO_PEARL
-- SELECT * FROM USUARIO_TIPO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PERMISO_BOTON]') AND type in (N'U'))
	DROP TABLE [dbo].[PERMISO_BOTON]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIO_PERMISOS_MENU]') AND type in (N'U'))
	DROP TABLE [dbo].[USUARIO_PERMISOS_MENU]
GO

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
	[PASSWORD_USUARIO_PEARL]	[VARCHAR] (15) NOT NULL,
	[CORREO_USUARIO_PEARL]		[VARCHAR] (30) DEFAULT '@PEARLLEATHER.COM.MX',
--	[K_USUARIO_TIPO]			[INT] DEFAULT 3,
	[USUARIO_TIPO]				[VARCHAR] (10) DEFAULT 'U',
	[TEMA_USUARIO_PEARL]		[VARCHAR] (30) DEFAULT 'Flat Nature.isl',
	-- ========================================
	[K_EMPLEADO_PEARL]			[INT] NOT NULL,
	[C_USUARIO_PEARL]			[VARCHAR] (255) DEFAULT '',
	[L_USUARIO_PEARL]			[INT] NOT NULL
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


-- //////////////////////////////////////////////////////////////
-- // USUARIO_PERMISOS_MENU
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[USUARIO_PERMISOS_MENU] (
	[K_USUARIO_PERMISOS_MENU]	[INT] NOT NULL,
	-- ========================================
	[K_USUARIO_PEARL]		[INT] NOT NULL DEFAULT 0,
	[K_SISTEMA_TAG]			[INT] NOT NULL DEFAULT 0
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[USUARIO_PERMISOS_MENU]
	ADD CONSTRAINT [PK_USUARIO_PERMISOS_MENU]
		PRIMARY KEY CLUSTERED ([K_USUARIO_PERMISOS_MENU])
GO

-- //////////////////////////////////////////////////////////////

--ALTER TABLE [dbo].[USUARIO_PERMISOS] ADD 
--	CONSTRAINT [FK_USUARIO_PERMISOS_01] 
--		FOREIGN KEY ( [K_USUARIO_PEARL] ) 
--		REFERENCES [dbo].[USUARIO_PEARL] ( [K_USUARIO_PEARL] )
--GO



-- //////////////////////////////////////////////////////////////
-- // PERMISO_BOTON
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PERMISO_BOTON] (
	[K_PERMISO_BOTON]		[INT] NOT NULL,
	[D_BOTON]				[VARCHAR] (250) NOT NULL,
	[L_ACTIVO_BOTON]		[INT] DEFAULT 1,
	[L_VISIBLE_BOTON]		[INT] DEFAULT 1,
	-- ========================================
	[K_SISTEMA_TAG]			[INT] NOT NULL DEFAULT 0
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[PERMISO_BOTON]
	ADD CONSTRAINT [PK_PERMISO_BOTON]
		PRIMARY KEY CLUSTERED ([K_PERMISO_BOTON])
GO

-- //////////////////////////////////////////////////////////////

--ALTER TABLE [dbo].[PERMISO_BOTON] ADD 
--	CONSTRAINT [FK_PERMISO_BOTON_01] 
--		FOREIGN KEY ( [K_SISTEMA_TAG] ) 
--		REFERENCES [dbo].[SISTEMA_TAG] ( [K_SISTEMA_TAG] )
--GO


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
INSERT INTO USUARIO_PEARL
(	K_USUARIO_PEARL,
	D_USUARIO_PEARL,
	PASSWORD_USUARIO_PEARL,
	CORREO_USUARIO_PEARL,
	USUARIO_TIPO,
	TEMA_USUARIO_PEARL,
	L_USUARIO_PEARL,
	K_EMPLEADO_PEARL
)
SELECT 
	CODIGO,
	UPPER(USUARIO),
	CONTRASENA,
	UPPER(CORREO),
	UPPER(tipo),
----	(
----	CASE WHEN [tipo]='A1' THEN 10
----		 WHEN [tipo]='A1' THEN 10
----		 WHEN [tipo]='A1' THEN 10
----		 WHEN [tipo]='A1' THEN 10
----	END ),	
	UPPER(TEMA),
	1,
	0
FROM DATA_02PRUEBAS.DBO.USERS_PEARL
WHERE codigo NOT IN (127,128)
*/

/*
INSERT INTO USUARIO_PERMISOS_MENU
(
	K_USUARIO_PERMISOS_MENU,
	K_USUARIO_PEARL,
	K_SISTEMA_TAG
)
SELECT	* 
FROM	DATA_02.DBO.perm_pearl
/*
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////

