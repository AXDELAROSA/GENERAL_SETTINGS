-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	[BD_GENERAL]
-- // MODULO:			[PANTALLAS CON NOTIFICACIONES]
-- // OPERACION:		LIBERACION / STORED PROCEDURES
-- //////////////////////////////////////////////////////////////
-- // Autor:			AX
-- // Fecha creación:	20210621
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NOTIFICACION_PANTALLA]') AND type in (N'U'))
	DROP TABLE [dbo].[NOTIFICACION_PANTALLA]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_NOTIFICACION_PANTALLA]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_NOTIFICACION_PANTALLA]
GO


-- //////////////////////////////////////////////////////////////
-- // ESTATUS_NOTIFICACION_PANTALLA
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[ESTATUS_NOTIFICACION_PANTALLA] (
	[K_ESTATUS_NOTIFICACION_PANTALLA]	[INT]			NOT NULL,
	[D_ESTATUS_NOTIFICACION_PANTALLA]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_NOTIFICACION_PANTALLA]	[VARCHAR] (10)	NOT NULL,
	[O_ESTATUS_NOTIFICACION_PANTALLA]	[INT]			NOT NULL,
	[C_ESTATUS_NOTIFICACION_PANTALLA]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_NOTIFICACION_PANTALLA]	[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[ESTATUS_NOTIFICACION_PANTALLA]
	ADD CONSTRAINT [PK_ESTATUS_NOTIFICACION_PANTALLA]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_NOTIFICACION_PANTALLA])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_NOTIFICACION_PANTALLA_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_NOTIFICACION_PANTALLA] ( [D_ESTATUS_NOTIFICACION_PANTALLA] )
GO
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_NOTIFICACION_PANTALLA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_NOTIFICACION_PANTALLA]
GO
CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_NOTIFICACION_PANTALLA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_NOTIFICACION_PANTALLA	INT,
	@PP_D_ESTATUS_NOTIFICACION_PANTALLA	VARCHAR(100),
	@PP_S_ESTATUS_NOTIFICACION_PANTALLA	VARCHAR(10),
	@PP_O_ESTATUS_NOTIFICACION_PANTALLA	INT,
	@PP_C_ESTATUS_NOTIFICACION_PANTALLA	VARCHAR(255),
	@PP_L_ESTATUS_NOTIFICACION_PANTALLA	INT
AS
	-- ===============================
	DECLARE @VP_K_EXISTE	INT
	SELECT	@VP_K_EXISTE =	K_ESTATUS_NOTIFICACION_PANTALLA
							FROM	ESTATUS_NOTIFICACION_PANTALLA
							WHERE	K_ESTATUS_NOTIFICACION_PANTALLA=@PP_K_ESTATUS_NOTIFICACION_PANTALLA
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_NOTIFICACION_PANTALLA	
			(	K_ESTATUS_NOTIFICACION_PANTALLA,				D_ESTATUS_NOTIFICACION_PANTALLA, 
				S_ESTATUS_NOTIFICACION_PANTALLA,				O_ESTATUS_NOTIFICACION_PANTALLA,
				C_ESTATUS_NOTIFICACION_PANTALLA,
				L_ESTATUS_NOTIFICACION_PANTALLA				)		
		VALUES	
			(	@PP_K_ESTATUS_NOTIFICACION_PANTALLA,			@PP_D_ESTATUS_NOTIFICACION_PANTALLA,	
				@PP_S_ESTATUS_NOTIFICACION_PANTALLA,			@PP_O_ESTATUS_NOTIFICACION_PANTALLA,
				@PP_C_ESTATUS_NOTIFICACION_PANTALLA,
				@PP_L_ESTATUS_NOTIFICACION_PANTALLA			)
	ELSE
		UPDATE	ESTATUS_NOTIFICACION_PANTALLA
		SET		D_ESTATUS_NOTIFICACION_PANTALLA	= @PP_D_ESTATUS_NOTIFICACION_PANTALLA,	
				S_ESTATUS_NOTIFICACION_PANTALLA	= @PP_S_ESTATUS_NOTIFICACION_PANTALLA,			
				O_ESTATUS_NOTIFICACION_PANTALLA	= @PP_O_ESTATUS_NOTIFICACION_PANTALLA,
				C_ESTATUS_NOTIFICACION_PANTALLA	= @PP_C_ESTATUS_NOTIFICACION_PANTALLA,
				L_ESTATUS_NOTIFICACION_PANTALLA	= @PP_L_ESTATUS_NOTIFICACION_PANTALLA	
		WHERE	K_ESTATUS_NOTIFICACION_PANTALLA=@PP_K_ESTATUS_NOTIFICACION_PANTALLA

	-- =========================================================
GO
-- //////////////////////////////////////////////////////////////
-- ===============================================
SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_ESTATUS_NOTIFICACION_PANTALLA] 0, 0, 0, 'INACTIVO',		'INACTVO',		0,		'',		1
EXECUTE [dbo].[PG_CI_ESTATUS_NOTIFICACION_PANTALLA] 0, 0, 1, 'ACTIVO',			'ACTIVO',		1,		'',		1
EXECUTE [dbo].[PG_CI_ESTATUS_NOTIFICACION_PANTALLA] 0, 0, 2, 'SUSPENDIDO',		'SUSPNDO',		2,		'',		1
GO-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////
-- // NOTIFICACION_PANTALLA
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[NOTIFICACION_PANTALLA] (
	[K_NOTIFICACION_PANTALLA]			[INT] IDENTITY(1,1)		NOT NULL,
	-- =================================	
	[K_PANTALLA_SISTEMA]				[INT]			NOT NULL,
	[K_GRUPO_APROBADOR]					[INT]			NOT NULL,
	-- =================================	
	[K_ESTATUS_NOTIFICACION_PANTALLA]	[INT]			NOT NULL DEFAULT 1
	-- =================================	
)ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[NOTIFICACION_PANTALLA]
	ADD CONSTRAINT [PK_NOTIFICACION_PANTALLA]
		PRIMARY KEY CLUSTERED ([K_NOTIFICACION_PANTALLA])
GO
-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[NOTIFICACION_PANTALLA] ADD 
	CONSTRAINT [FK_NOTIFICACION_PANTALLA_01]  
		FOREIGN KEY ([K_ESTATUS_NOTIFICACION_PANTALLA]) 
		REFERENCES [dbo].[ESTATUS_NOTIFICACION_PANTALLA] ([K_ESTATUS_NOTIFICACION_PANTALLA])	
GO
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_NOTIFICACION_PANTALLA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_NOTIFICACION_PANTALLA]
GO

CREATE PROCEDURE [dbo].[PG_CI_NOTIFICACION_PANTALLA]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_PANTALLA_SISTEMA					INT,
	@PP_K_GRUPO_APROBADOR					INT,
	@PP_K_ESTATUS_NOTIFICACION_PANTALLA		INT
AS
	-- ===============================
	--DECLARE @VP_K_EXISTE	INT
	--SELECT	@VP_K_EXISTE =	K_NOTIFICACION_PANTALLA
	--						FROM	NOTIFICACION_PANTALLA
	--						WHERE	K_NOTIFICACION_PANTALLA=@PP_K_NOTIFICACION_PANTALLA
	-- ===============================

	--IF @VP_K_EXISTE IS NULL
		INSERT INTO NOTIFICACION_PANTALLA	
			(	[K_PANTALLA_SISTEMA]				,
				[K_GRUPO_APROBADOR]					,
				[K_ESTATUS_NOTIFICACION_PANTALLA]	)		
		VALUES	
			(	@PP_K_PANTALLA_SISTEMA				,
				@PP_K_GRUPO_APROBADOR				,
				@PP_K_ESTATUS_NOTIFICACION_PANTALLA	)
	--ELSE
	--	UPDATE	NOTIFICACION_PANTALLA
	--	SET		D_NOTIFICACION_PANTALLA			= @PP_D_NOTIFICACION_PANTALLA,	
	--			BOTON							= @PP_BOTON,			
	--			K_USUARIO						= @PP_K_USUARIO,
	--			K_ESTATUS_NOTIFICACION_PANTALLA	= @PP_K_ESTATUS_PERMISO_ACCION	
	--	WHERE	K_NOTIFICACION_PANTALLA=@PP_K_NOTIFICACION_PANTALLA

	-- =========================================================
GO

-- ===============================================
SET NOCOUNT ON
-- ===============================================
/*
use BD_GENERAL
select * from USUARIO_PEARL
SELECT * FROM NOTIFICACION_PANTALLA
*/
-- ===================FORMA FoliosV2============================
EXECUTE [dbo].[PG_CI_NOTIFICACION_PANTALLA] 0, 0, 64	,6003	,1
EXECUTE [dbo].[PG_CI_NOTIFICACION_PANTALLA] 0, 0, 97	,9703	,1

GO-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
