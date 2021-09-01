-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			FOB_POINT
-- // OPERATION:		TABLE
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20190903
-- ////////////////////////////////////////////////////////////// 

--USE [COT19_Cotizaciones_V9999_R0]
USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOB_POINT]') AND type in (N'U'))
	DROP TABLE [dbo].[FOB_POINT]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STATUS_FOB_POINT]') AND type in (N'U'))
	DROP TABLE [dbo].[STATUS_FOB_POINT]
GO


-- //////////////////////////////////////////////////////////////
-- // STATUS_FOB_POINT
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[STATUS_FOB_POINT] (
	[K_STATUS_FOB_POINT]	[INT]				NOT NULL,
	[D_STATUS_FOB_POINT]	[VARCHAR] (100)		NOT NULL,
	[S_STATUS_FOB_POINT]	[VARCHAR] (10)		NOT NULL,
	[O_STATUS_FOB_POINT]	[INT]				NOT NULL,
	[C_STATUS_FOB_POINT]	[VARCHAR] (255)		NOT NULL,
	[L_STATUS_FOB_POINT]	[INT]				NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[STATUS_FOB_POINT]
	ADD CONSTRAINT [PK_STATUS_FOB_POINT]
		PRIMARY KEY CLUSTERED ([K_STATUS_FOB_POINT])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_STATUS_FOB_POINT_01_DESCRIPCION] 
	   ON [dbo].[STATUS_FOB_POINT] ( [D_STATUS_FOB_POINT] )
GO

-- //////////////////////////////////////////////////////////////


--ALTER TABLE [dbo].[STATUS_FOB_POINT] ADD 
--	CONSTRAINT [FK_STATUS_FOB_POINT_01] 
--		FOREIGN KEY ( [L_STATUS_FOB_POINT] ) 
--		REFERENCES [dbo].[STATUS_ACTIVO] ( [K_STATUS_ACTIVO] )
--GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_STATUS_FOB_POINT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_STATUS_FOB_POINT]
GO


CREATE PROCEDURE [dbo].[PG_CI_STATUS_FOB_POINT]
--	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_STATUS_FOB_POINT		INT,
	@PP_D_STATUS_FOB_POINT		VARCHAR(100),
	@PP_S_STATUS_FOB_POINT		VARCHAR(10),
	@PP_O_STATUS_FOB_POINT		INT,
	@PP_C_STATUS_FOB_POINT		VARCHAR(255),
	@PP_L_STATUS_FOB_POINT		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXIST	INT

	SELECT	@VP_K_EXIST =	K_STATUS_FOB_POINT
							FROM	STATUS_FOB_POINT
							WHERE	K_STATUS_FOB_POINT=@PP_K_STATUS_FOB_POINT

	-- ===============================

	IF @VP_K_EXIST IS NULL
		INSERT INTO STATUS_FOB_POINT	
			(	K_STATUS_FOB_POINT,				D_STATUS_FOB_POINT, 
				S_STATUS_FOB_POINT,				O_STATUS_FOB_POINT,
				C_STATUS_FOB_POINT,
				L_STATUS_FOB_POINT				)		
		VALUES	
			(	@PP_K_STATUS_FOB_POINT,			@PP_D_STATUS_FOB_POINT,	
				@PP_S_STATUS_FOB_POINT,			@PP_O_STATUS_FOB_POINT,
				@PP_C_STATUS_FOB_POINT,
				@PP_L_STATUS_FOB_POINT			)
	ELSE
		UPDATE	STATUS_FOB_POINT
		SET		D_STATUS_FOB_POINT	= @PP_D_STATUS_FOB_POINT,	
				S_STATUS_FOB_POINT	= @PP_S_STATUS_FOB_POINT,			
				O_STATUS_FOB_POINT	= @PP_O_STATUS_FOB_POINT,
				C_STATUS_FOB_POINT	= @PP_C_STATUS_FOB_POINT,
				L_STATUS_FOB_POINT	= @PP_L_STATUS_FOB_POINT	
		WHERE	K_STATUS_FOB_POINT=@PP_K_STATUS_FOB_POINT

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_STATUS_FOB_POINT] 0, 0, '(DESCONOCIDO)',	'?????', 1, '', 1
EXECUTE [dbo].[PG_CI_STATUS_FOB_POINT] 0, 1, 'ACTIVO',			'ACTIV', 1, '', 1
EXECUTE [dbo].[PG_CI_STATUS_FOB_POINT] 0, 2, 'INACTIVO',		'INACT', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // FOB_POINT
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[FOB_POINT] (
	[K_FOB_POINT]				[INT]			NOT NULL,
	[D_FOB_POINT]				[VARCHAR] (100) NOT NULL,
	[S_FOB_POINT]				[VARCHAR] (10)	NOT NULL,
	[O_FOB_POINT]				[INT]			NOT NULL DEFAULT 1,
	[C_FOB_POINT]				[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_FOB_POINT]				[INT]			NOT NULL DEFAULT 1,
		-- =========================================
	[K_STATUS_FOB_POINT]		[INT]			NOT NULL,
	--[K_COUNTRY]					[INT]			NOT NULL,
	--[K_STATE_GEO_FOB_POINT]		[INT]			NOT NULL
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
	--CONSTRAINT [FK_FOB_POINT_01] 
	--	FOREIGN KEY ( [L_FOB_POINT] ) 
	--	REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_FOB_POINT_02] 
		FOREIGN KEY ( [K_STATUS_FOB_POINT] ) 
		REFERENCES [dbo].[STATUS_FOB_POINT] ( [K_STATUS_FOB_POINT] )
	--CONSTRAINT [FK_FOB_POINT_03] 
	--	FOREIGN KEY ( [K_STATE_GEO_FOB_POINT] ) 
	--	REFERENCES [dbo].[STATE_GEO] ( [K_STATE_GEO] )
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


--ALTER TABLE [dbo].[FOB_POINT] ADD 
--	CONSTRAINT [FK_FOB_POINT_USUARIO_ALTA]  
--		FOREIGN KEY ([K_USUARIO_ALTA]) 
--		REFERENCES [dbo].[USERS_PEARL] ([CODIGO]),
--	CONSTRAINT [FK_FOB_POINT_USUARIO_CAMBIO]  
--		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
--		REFERENCES [dbo].[USERS_PEARL] ([CODIGO]),
--	CONSTRAINT [FK_FOB_POINT_USUARIO_BAJA]  
--		FOREIGN KEY ([K_USUARIO_BAJA]) 
--		REFERENCES [dbo].[USERS_PEARL] ([CODIGO])
--


-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> CARGA INICIAL
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FOB_POINT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FOB_POINT]
GO
CREATE PROCEDURE [dbo].[PG_CI_FOB_POINT]
--	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_K_FOB_POINT					INT,			
	@PP_D_FOB_POINT					VARCHAR(100),
	@PP_S_FOB_POINT					VARCHAR(10),
	@PP_O_FOB_POINT					INT,
	@PP_C_FOB_POINT					VARCHAR(255),
	@PP_L_FOB_POINT					INT,
	-- =========================================
	@PP_K_ESTATUS_FOB_POINT			INT
	--@PP_K_COUNTRY					INT,
	--@PP_K_STATE_GEO_FOB_POINT		INT
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
				[K_STATUS_FOB_POINT], 
				--[K_COUNTRY],
				--[K_STATE_GEO_FOB_POINT],
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_FOB_POINT, @PP_D_FOB_POINT,
				@PP_S_FOB_POINT, 1, 
				@PP_C_FOB_POINT, 1,
				@PP_K_ESTATUS_FOB_POINT,	
				--@PP_K_COUNTRY,
				--@PP_K_STATE_GEO_FOB_POINT,	
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
				[K_STATUS_FOB_POINT]		= @PP_K_ESTATUS_FOB_POINT,
				--[K_COUNTRY]					= @PP_K_COUNTRY,
				--[K_STATE_GEO_FOB_POINT]		= @PP_K_STATE_GEO_FOB_POINT,
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

EXECUTE [dbo].[PG_CI_FOB_Point] 0, 139, 0, '(NO-FOBPoint)',		'( N/C )',	00 ,		'#0 // (NO-FOBPoint)'	, 1		,1	--,0		,0
EXECUTE [dbo].[PG_CI_FOB_Point] 0, 139, 1, 'JUAREZ',			'JRZ,MX',	10 ,		'#1 // JUAREZ'			, 1		,1	--,260	,8
EXECUTE [dbo].[PG_CI_FOB_Point] 0, 139, 2, 'SHIPPING POINT',	'SHIPNT',	20 ,		''						, 1		,1	--


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////