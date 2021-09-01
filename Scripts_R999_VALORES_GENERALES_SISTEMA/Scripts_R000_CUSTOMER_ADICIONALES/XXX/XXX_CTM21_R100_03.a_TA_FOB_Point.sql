-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			FOB_POINT
-- // OPERATION:		TABLE
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
--			20210831
--	EN COTIZACIONES SE UTILIZA ALGO SEMEJANTE AL FOB_POINT
--	PERO NO ESTA RELACIONADO CON EL CLIENTE.
--	SE DEBERÍA INCLUIR Y HACER LAS MODIFICACIONES NECESARIAS
--	EN COTIZACIONES.

--	SELECT * FROM COT19_COTIZACIONES_V9999_R0.DBO.[FOB_POINT]
--	SELECT * FROM [FOB_POINT]
-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOB_POINT]') AND type in (N'U'))
	DROP TABLE [dbo].[FOB_POINT]
GO

-- //////////////////////////////////////////////////////////////
-- // FOB_POINT
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[FOB_POINT] (
	[K_FOB_POINT]				[INT]			NOT NULL,
	[D_FOB_POINT]				[VARCHAR] (100) NOT NULL,
	[S_FOB_POINT]				[VARCHAR] (10)	NOT NULL,
	[O_FOB_POINT]				[INT]			NOT NULL DEFAULT 10,
	[C_FOB_POINT]				[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_FOB_POINT]				[INT]			NOT NULL DEFAULT 1,
		-- =========================================
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[FOB_POINT]
	ADD CONSTRAINT [PK_FOB_POINT]
		PRIMARY KEY CLUSTERED ([K_FOB_POINT])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_FOB_POINT_01_DESCRIPCION] 
	   ON [dbo].[FOB_POINT] ( [D_FOB_POINT] )
GO
-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[FOB_POINT] ADD 
	CONSTRAINT [FK_FOB_POINT_01] 
		FOREIGN KEY ( [K_STATUS_FOB_POINT] ) 
		REFERENCES [dbo].[STATUS_FOB_POINT] ( [K_STATUS_FOB_POINT] )
GO

ALTER TABLE [dbo].[FOB_POINT] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FOB_POINT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FOB_POINT]
GO
-- //////////////////////////////////////////////////////////////
-- // CI_FOB_POINT
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_FOB_POINT]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_K_FOB_POINT					INT,			
	@PP_D_FOB_POINT					VARCHAR(100),
	@PP_S_FOB_POINT					VARCHAR(10),
	@PP_O_FOB_POINT					INT,
	@PP_C_FOB_POINT					VARCHAR(255),
	@PP_L_FOB_POINT					INT
	-- =========================================
AS	
	-- ===============================
	DECLARE @VP_K_EXISTE	INT
	SELECT	@VP_K_EXISTE =	K_FOB_POINT
							FROM	[FOB_POINT]
							WHERE	K_FOB_POINT=@PP_K_FOB_POINT
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO [FOB_POINT]	
			(	[K_FOB_POINT], [D_FOB_POINT],
				[S_FOB_POINT], [O_FOB_POINT],
				[C_FOB_POINT], [L_FOB_POINT],
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_FOB_POINT, @PP_D_FOB_POINT,
				@PP_S_FOB_POINT, @PP_O_FOB_POINT, 
				@PP_C_FOB_POINT, @PP_L_FOB_POINT,
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )							
	ELSE
		UPDATE	FOB_POINT
		SET		
				[D_FOB_POINT]				= @PP_D_FOB_POINT,					
				[S_FOB_POINT]				= @PP_S_FOB_POINT,					
				[C_FOB_POINT]				= @PP_C_FOB_POINT,
				[O_FOB_POINT]				= @PP_O_FOB_POINT,
				[L_FOB_POINT]				= @PP_L_FOB_POINT,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_FOB_POINT=@PP_K_FOB_POINT
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////
-- ===============================================
SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_FOB_Point] 0, 139, 0, '(NO-FOBPoint)',			'( N/FOB )'		, 00 , '' , 1
EXECUTE [dbo].[PG_CI_FOB_Point] 0, 139, 1, 'JUAREZ',				'JRZ,MX'		, 10 , '' , 1
EXECUTE [dbo].[PG_CI_FOB_Point] 0, 139, 2, 'SHIPPING POINT',		'SHIPNT'		, 20 , '' , 1
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO
-- //////////////////////////////////////////////////////////////
