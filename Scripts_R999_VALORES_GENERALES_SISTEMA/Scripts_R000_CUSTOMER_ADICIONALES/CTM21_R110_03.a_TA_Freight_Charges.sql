-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			FREIGHT_CHARGES
-- // OPERATION:		TABLE
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
--		20210831
--	NO SE INCLUYE AÚN EN LA TABLA. SE UTILIZARÁ TAMBIÉN EN LA TABLA
--	PARA LAS BLANKET.
--		20210831
--		AGREGADO
--	SELECT * FROM [FREIGHT_CHARGES]
-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FREIGHT_CHARGES]') AND type in (N'U'))
	DROP TABLE [dbo].[FREIGHT_CHARGES]
GO
-- //////////////////////////////////////////////////////////////
-- // FREIGHT_CHARGES
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[FREIGHT_CHARGES] (
	[K_FREIGHT_CHARGES]				[INT]			NOT NULL,
	[D_FREIGHT_CHARGES]				[VARCHAR] (100) NOT NULL,
	[S_FREIGHT_CHARGES]				[VARCHAR] (10)	NOT NULL,
	[O_FREIGHT_CHARGES]				[INT]			NOT NULL DEFAULT 1,
	[C_FREIGHT_CHARGES]				[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_FREIGHT_CHARGES]				[INT]			NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[FREIGHT_CHARGES]
	ADD CONSTRAINT [PK_FREIGHT_CHARGES]
		PRIMARY KEY CLUSTERED ([K_FREIGHT_CHARGES])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_FREIGHT_CHARGES_01_DESCRIPCION] 
	   ON [dbo].[FREIGHT_CHARGES] ( [D_FREIGHT_CHARGES] )
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[FREIGHT_CHARGES] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FREIGHT_CHARGES]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FREIGHT_CHARGES]
GO

-- //////////////////////////////////////////////////////////////
-- // CI_FREIGHT_CHARGES
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_FREIGHT_CHARGES]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_K_FREIGHT_CHARGES					INT,			
	@PP_D_FREIGHT_CHARGES					VARCHAR(100),
	@PP_S_FREIGHT_CHARGES					VARCHAR(10),
	@PP_O_FREIGHT_CHARGES					INT,
	@PP_C_FREIGHT_CHARGES					VARCHAR(255),
	@PP_L_FREIGHT_CHARGES					INT
	-- =========================================
AS	
	-- ===============================
	DECLARE @VP_K_EXISTE	INT
	SELECT	@VP_K_EXISTE =	K_FREIGHT_CHARGES
							FROM	[FREIGHT_CHARGES]
							WHERE	K_FREIGHT_CHARGES=@PP_K_FREIGHT_CHARGES
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO [FREIGHT_CHARGES]	
			(	[K_FREIGHT_CHARGES], [D_FREIGHT_CHARGES],
				[S_FREIGHT_CHARGES], [O_FREIGHT_CHARGES],
				[C_FREIGHT_CHARGES], [L_FREIGHT_CHARGES],
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_FREIGHT_CHARGES, @PP_D_FREIGHT_CHARGES,
				@PP_S_FREIGHT_CHARGES, @PP_O_FREIGHT_CHARGES, 
				@PP_C_FREIGHT_CHARGES, @PP_L_FREIGHT_CHARGES,
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )							
	ELSE
		UPDATE	FREIGHT_CHARGES
		SET		
				[D_FREIGHT_CHARGES]				= @PP_D_FREIGHT_CHARGES,					
				[S_FREIGHT_CHARGES]				= @PP_S_FREIGHT_CHARGES,					
				[C_FREIGHT_CHARGES]				= @PP_C_FREIGHT_CHARGES,
				[O_FREIGHT_CHARGES]				= @PP_O_FREIGHT_CHARGES,
				[L_FREIGHT_CHARGES]				= @PP_L_FREIGHT_CHARGES,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_FREIGHT_CHARGES=@PP_K_FREIGHT_CHARGES
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////
-- ===============================================
SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_FREIGHT_CHARGES] 0, 139, 0, '(NO-Freight Charges)'		,'( N/FOB )'	, 00, '', 1
EXECUTE [dbo].[PG_CI_FREIGHT_CHARGES] 0, 139, 1, 'COLLECT'					,'ACTIV'		, 10, '', 1
EXECUTE [dbo].[PG_CI_FREIGHT_CHARGES] 0, 139, 2, 'INVOICE'					,'INACT'		, 20, '', 1
EXECUTE [dbo].[PG_CI_FREIGHT_CHARGES] 0, 139, 3, 'PREPAID'					,'PRPAID'		, 30, '', 1
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO
-- //////////////////////////////////////////////////////////////
