-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			STATE_GEO
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STATE_GEO]') AND type in (N'U'))
	DROP TABLE [dbo].[STATE_GEO]
GO


-- //////////////////////////////////////////////////////////////
-- // STATE_GEO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[STATE_GEO] (
	[K_STATE_GEO]				[INT]			NOT NULL,
	[D_STATE_GEO]				[VARCHAR] (100) NOT NULL,
	[S_STATE_GEO]				[VARCHAR] (10)	NOT NULL,
	[O_STATE_GEO]				[INT]			NOT NULL DEFAULT 1,
	[C_STATE_GEO]				[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_STATE_GEO]				[INT]			NOT NULL DEFAULT 1,
	-- =========================================
	[K_COUNTRY]				[INT]			NOT NULL,
) ON [PRIMARY]
GO

--/////FEG: SE AGREGO CAMPO PARA ESPECIFICAR LAS SIGUES CORRESPONDIENTES A LA CURP POR ESTADO 03-03-2022
-- 	ALTER TABLE [BD_GENERAL].[dbo].[STATE_GEO] ADD S_CURP VARCHAR(10) DEFAULT NULL 

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[STATE_GEO]
	ADD CONSTRAINT [PK_STATE_GEO]
		PRIMARY KEY CLUSTERED ([K_STATE_GEO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_STATE_GEO_01_DESCRIPCION] 
	   ON [dbo].[STATE_GEO] ( [D_STATE_GEO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[STATE_GEO] ADD 
	--CONSTRAINT [FK_STATE_GEO_01] 
	--	FOREIGN KEY ( [L_STATE_GEO] ) 
	--	REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_STATE_GEO_02] 
		FOREIGN KEY ( [K_COUNTRY] ) 
		REFERENCES [dbo].[COUNTRY] ( [K_COUNTRY] )
GO


ALTER TABLE [dbo].[STATE_GEO] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


--ALTER TABLE [dbo].[STATE_GEO] ADD 
--	CONSTRAINT [FK_STATE_GEO_USUARIO_ALTA]  
--		FOREIGN KEY ([K_USUARIO_ALTA]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
--	CONSTRAINT [FK_STATE_GEO_USUARIO_CAMBIO]  
--		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
--	CONSTRAINT [FK_STATE_GEO_USUARIO_BAJA]  
--		FOREIGN KEY ([K_USUARIO_BAJA]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
--GO


-- //////////////////////////////////////////////////////////////
