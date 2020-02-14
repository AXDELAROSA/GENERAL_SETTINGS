-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			CONTINENTE
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CONTINENTE]') AND type in (N'U'))
	DROP TABLE [dbo].[CONTINENTE]
GO


-- //////////////////////////////////////////////////////////////
-- // CONTINENTE
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CONTINENTE] (
	[K_CONTINENTE]				[INT]			NOT NULL,
	[D_CONTINENTE]				[VARCHAR] (100) NOT NULL,
	[S_CONTINENTE]				[VARCHAR] (10)	NOT NULL,
	[O_CONTINENTE]				[INT]			NOT NULL DEFAULT 1,
	[C_CONTINENTE]				[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_CONTINENTE]				[INT]			NOT NULL DEFAULT 1
	-- =========================================
	--[K_STATUS_CONTINENTE]			[INT]			NOT NULL,
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CONTINENTE]
	ADD CONSTRAINT [PK_CONTINENTE]
		PRIMARY KEY CLUSTERED ([K_CONTINENTE])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CONTINENTE_01_DESCRIPCION] 
	   ON [dbo].[CONTINENTE] ( [D_CONTINENTE] )
GO

-- //////////////////////////////////////////////////////////////


--ALTER TABLE [dbo].[CONTINENTE] ADD 
--	CONSTRAINT [FK_CONTINENTE_01] 
--		FOREIGN KEY ( [L_CONTINENTE] ) 
--		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
--	--CONSTRAINT [FK_CONTINENTE_02] 
--	--	FOREIGN KEY ( [K_STATUS_CONTINENTE] ) 
--	--	REFERENCES [dbo].[STATUS_CONTINENTE] ( [K_STATUS_CONTINENTE] )
--GO


ALTER TABLE [dbo].[CONTINENTE] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


--ALTER TABLE [dbo].[CONTINENTE] ADD 
--	CONSTRAINT [FK_CONTINENTE_USUARIO_ALTA]  
--		FOREIGN KEY ([K_USUARIO_ALTA]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
--	CONSTRAINT [FK_CONTINENTE_USUARIO_CAMBIO]  
--		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
--	CONSTRAINT [FK_CONTINENTE_USUARIO_BAJA]  
--		FOREIGN KEY ([K_USUARIO_BAJA]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
--GO


-- //////////////////////////////////////////////////////////////
