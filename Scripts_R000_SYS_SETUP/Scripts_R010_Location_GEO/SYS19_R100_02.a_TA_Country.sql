-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			COUNTRY
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[COUNTRY]') AND type in (N'U'))
	DROP TABLE [dbo].[COUNTRY]
GO


-- //////////////////////////////////////////////////////////////
-- // COUNTRY
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[COUNTRY] (
	[K_COUNTRY]				[INT]			NOT NULL,
	[D_COUNTRY]				[VARCHAR] (100) NOT NULL,
	[S_COUNTRY]				[VARCHAR] (10)	NOT NULL,
	[O_COUNTRY]				[INT]			NOT NULL DEFAULT 1,
	[C_COUNTRY]				[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_COUNTRY]				[INT]			NOT NULL DEFAULT 1,
	-- =========================================
	[K_CONTINENTE]			[INT]			NOT NULL,
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[COUNTRY]
	ADD CONSTRAINT [PK_COUNTRY]
		PRIMARY KEY CLUSTERED ([K_COUNTRY])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_COUNTRY_01_DESCRIPCION] 
	   ON [dbo].[COUNTRY] ( [D_COUNTRY] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[COUNTRY] ADD 
	--CONSTRAINT [FK_COUNTRY_01] 
	--	FOREIGN KEY ( [L_COUNTRY] ) 
	--	REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_COUNTRY_02] 
		FOREIGN KEY ( [K_CONTINENTE] ) 
		REFERENCES [dbo].[CONTINENTE] ( [K_CONTINENTE] )
GO


ALTER TABLE [dbo].[COUNTRY] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


--ALTER TABLE [dbo].[COUNTRY] ADD 
--	CONSTRAINT [FK_COUNTRY_USUARIO_ALTA]  
--		FOREIGN KEY ([K_USUARIO_ALTA]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
--	CONSTRAINT [FK_COUNTRY_USUARIO_CAMBIO]  
--		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
--	CONSTRAINT [FK_COUNTRY_USUARIO_BAJA]  
--		FOREIGN KEY ([K_USUARIO_BAJA]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
--GO


-- //////////////////////////////////////////////////////////////
