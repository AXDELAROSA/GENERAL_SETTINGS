-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			CITY
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20190911
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL] 
GO

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CITY]') AND type in (N'U'))
	DROP TABLE [dbo].[CITY]
GO

--SELECT * FROM CITY
-- //////////////////////////////////////////////////////////////
-- // CITY
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CITY] (
	[K_CITY]				[INT]			NOT NULL,
	[D_CITY]				[VARCHAR] (100) NOT NULL,
	[S_CITY]				[VARCHAR] (10)	NOT NULL,
	[O_CITY]				[INT]			NOT NULL DEFAULT 1,
	[C_CITY]				[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_CITY]				[INT]			NOT NULL DEFAULT 1,
	-- =========================================
	[K_STATE_GEO]				[INT]			NOT NULL,
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CITY]
	ADD CONSTRAINT [PK_CITY]
		PRIMARY KEY CLUSTERED ([K_CITY])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CITY_01_DESCRIPCION] 
	   ON [dbo].[CITY] ( [D_CITY] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CITY] ADD 
	--CONSTRAINT [FK_CITY_01] 
	--	FOREIGN KEY ( [L_CITY] ) 
	--	REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_CITY_02] 
		FOREIGN KEY ( [K_STATE_GEO] ) 
		REFERENCES [dbo].[STATE_GEO] ( [K_STATE_GEO] )
GO


ALTER TABLE [dbo].[CITY] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


-- //////////////////////////////////////////////////////////////
