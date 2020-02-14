-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		ALL
-- // MODULE:			DATA BASE TAG
-- // OPERATION:		SP
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20190903
-- ////////////////////////////////////////////////////////////// 

USE [COT19_Cotizaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM SISTEMA_TAG


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SISTEMA_TAG]') AND type in (N'U'))
	DROP TABLE [dbo].[SISTEMA_TAG]
GO



-- //////////////////////////////////////////////////////////////
-- // SISTEMA_TAG
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SISTEMA_TAG] (
	[K_SISTEMA]		INT,
	[K_SISTEMA_TAG]	DECIMAL(19,2) NOT NULL,
	[D_SISTEMA_TAG]	[VARCHAR] (100) NOT NULL,
	[S_SISTEMA_TAG]	[VARCHAR] (10) NOT NULL,
	[O_SISTEMA_TAG]	[INT] NOT NULL,
	[C_SISTEMA_TAG]	[VARCHAR] (255) NOT NULL,
	[L_SISTEMA_TAG]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SISTEMA_TAG]
	ADD CONSTRAINT [PK_SISTEMA_TAG]
		PRIMARY KEY CLUSTERED ([K_SISTEMA_TAG])
GO

/*
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_SISTEMA_TAG_01_DESCRIPCION] 
	   ON [dbo].[SISTEMA_TAG] ( [D_SISTEMA_TAG] )
GO
*/

-- //////////////////////////////////////////////////////////////

--ALTER TABLE [dbo].[SISTEMA_TAG] ADD 
--	CONSTRAINT [FK_SISTEMA_TAG_01] 
--		FOREIGN KEY ( [L_SISTEMA_TAG] ) 
--		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
--GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SISTEMA_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SISTEMA_TAG]
GO


CREATE PROCEDURE [dbo].[PG_CI_SISTEMA_TAG]
--	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_SISTEMA_TAG		DECIMAL(19,2),
	@PP_D_SISTEMA_TAG		VARCHAR(100),
	@PP_S_SISTEMA_TAG		VARCHAR(10),
	@PP_O_SISTEMA_TAG		INT,
	@PP_C_SISTEMA_TAG		VARCHAR(255),
	@PP_L_SISTEMA_TAG		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	DECIMAL(19,2)

	SELECT	@VP_K_EXISTE =	K_SISTEMA_TAG
							FROM	SISTEMA_TAG
							WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO SISTEMA_TAG
			(	K_SISTEMA,
				K_SISTEMA_TAG,			D_SISTEMA_TAG, 
				S_SISTEMA_TAG,			O_SISTEMA_TAG,
				C_SISTEMA_TAG,
				L_SISTEMA_TAG			)		
		VALUES	
			(	@PP_K_SISTEMA_EXE,
				@PP_K_SISTEMA_TAG,		@PP_D_SISTEMA_TAG,	
				@PP_S_SISTEMA_TAG,		@PP_O_SISTEMA_TAG,
				@PP_C_SISTEMA_TAG,
				@PP_L_SISTEMA_TAG		)
	ELSE
		UPDATE	SISTEMA_TAG
		SET		D_SISTEMA_TAG	= @PP_D_SISTEMA_TAG,	
				S_SISTEMA_TAG	= @PP_S_SISTEMA_TAG,			
				O_SISTEMA_TAG	= @PP_O_SISTEMA_TAG,
				C_SISTEMA_TAG	= @PP_C_SISTEMA_TAG,
				L_SISTEMA_TAG	= @PP_L_SISTEMA_TAG	
		WHERE	K_SISTEMA=@PP_K_SISTEMA_EXE
		AND		K_SISTEMA_TAG=@PP_K_SISTEMA_TAG

	-- =========================================================

GO

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////

