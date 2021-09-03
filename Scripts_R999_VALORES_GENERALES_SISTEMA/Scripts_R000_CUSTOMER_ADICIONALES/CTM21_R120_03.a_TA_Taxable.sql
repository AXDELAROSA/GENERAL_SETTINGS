-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			TAXABLE
-- // OPERATION:		TABLE
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
--	NO SE INCLUYE EN LA TABLA AÚN.
--		20210831
--	AGREGADO
--	SELECT * FROM [TAXABLE]
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TAXABLE]') AND type in (N'U'))
	DROP TABLE [dbo].[TAXABLE]
GO

-- //////////////////////////////////////////////////////////////
-- // TAXABLE
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[TAXABLE] (
	[K_TAXABLE]				[INT]			NOT NULL,
	[D_TAXABLE]				[VARCHAR] (100) NOT NULL,
	[S_TAXABLE]				[VARCHAR] (10)	NOT NULL,
	[O_TAXABLE]				[INT]			NOT NULL DEFAULT 1,
	[C_TAXABLE]				[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_TAXABLE]				[INT]			NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[TAXABLE]
	ADD CONSTRAINT [PK_TAXABLE]
		PRIMARY KEY CLUSTERED ([K_TAXABLE])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TAXABLE_01_DESCRIPCION] 
	   ON [dbo].[TAXABLE] ( [D_TAXABLE] )
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[TAXABLE] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TAXABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TAXABLE]
GO
-- //////////////////////////////////////////////////////////////
-- // CI_TAXABLE
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_TAXABLE]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_K_TAXABLE					INT,			
	@PP_D_TAXABLE					VARCHAR(100),
	@PP_S_TAXABLE					VARCHAR(10),
	@PP_O_TAXABLE					INT,
	@PP_C_TAXABLE					VARCHAR(255),
	@PP_L_TAXABLE					INT
	-- =========================================
AS	
	-- ===============================
	DECLARE @VP_K_EXISTE	INT
	SELECT	@VP_K_EXISTE =	K_TAXABLE
							FROM	[TAXABLE]
							WHERE	K_TAXABLE=@PP_K_TAXABLE
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO [TAXABLE]	
			(	[K_TAXABLE], [D_TAXABLE],
				[S_TAXABLE], [O_TAXABLE],
				[C_TAXABLE], [L_TAXABLE],
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_TAXABLE, @PP_D_TAXABLE,
				@PP_S_TAXABLE, @PP_O_TAXABLE, 
				@PP_C_TAXABLE, @PP_L_TAXABLE,
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )							
	ELSE
		UPDATE	TAXABLE
		SET		
				[D_TAXABLE]				= @PP_D_TAXABLE,					
				[S_TAXABLE]				= @PP_S_TAXABLE,					
				[C_TAXABLE]				= @PP_C_TAXABLE,
				[O_TAXABLE]				= @PP_O_TAXABLE,
				[L_TAXABLE]				= @PP_L_TAXABLE,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_TAXABLE=@PP_K_TAXABLE
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////
-- ===============================================
SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_TAXABLE] 0, 139, 0, '(Unknown)'				,'( UNK )'		, 00, '', 1
EXECUTE [dbo].[PG_CI_TAXABLE] 0, 139, 1, 'NO TAXABLE'				,'NO-TAX'		, 10, '', 1
EXECUTE [dbo].[PG_CI_TAXABLE] 0, 139, 2, 'TAXABLE'					,'TXABLE'		, 20, '', 1
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO
-- //////////////////////////////////////////////////////////////
