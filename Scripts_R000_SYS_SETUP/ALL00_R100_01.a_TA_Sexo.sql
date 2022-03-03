-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		BD_GENERAL
-- // MODULE:			ALL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200912
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SEXO]') AND type in (N'U'))
	DROP TABLE [dbo].[SEXO]
GO

-- ////////////////////////////////////////////////////////////////
-- //					SEXO				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SEXO] (
	[K_SEXO]			[INT]			NOT NULL,
	[D_SEXO]			[VARCHAR](100)	NOT NULL,
	[C_SEXO]			[VARCHAR](255)	NOT NULL,
	[S_SEXO]			[VARCHAR](10)	NOT NULL,
	[O_SEXO]			[INT]			NOT NULL,
	[L_SEXO]			[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[SEXO]
	ADD CONSTRAINT [PK_SEXO]
		PRIMARY KEY CLUSTERED ([K_SEXO])
GO
--CREATE UNIQUE NONCLUSTERED 
--	INDEX [UN_SEXO_01_DESCRIPCION] 
--	   ON [dbo].[SEXO] ( [D_SEXO] )
--GO
--ALTER TABLE [dbo].[SEXO] ADD 
--	CONSTRAINT [FK_UNIT_CLASS_01] 
--		FOREIGN KEY ( [K_UNIT_CLASS] ) 
--		REFERENCES [dbo].[UNIT_CLASS] ( [K_UNIT_CLASS] )
--GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SEXO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SEXO]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - SEXO
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_SEXO]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_SEXO			INT,
	@PP_D_SEXO			VARCHAR(100),
	@PP_C_SEXO			VARCHAR(255),
	@PP_S_SEXO			VARCHAR(10),
	@PP_O_SEXO			INT,
	@PP_L_SEXO			INT
AS				
	-- ===========================
	INSERT INTO SEXO
			(	[K_SEXO], [D_SEXO], 
				[C_SEXO], [S_SEXO], 
				[O_SEXO], [L_SEXO])
	VALUES	
			(	@PP_K_SEXO, @PP_D_SEXO, 
				@PP_C_SEXO, @PP_S_SEXO,
				@PP_O_SEXO, @PP_L_SEXO)
		
	-- //////////////////////////////////////////////////////////////
GO

EXECUTE [dbo].[PG_CI_SEXO]  0, 139,  1,	'HOMBRE'			,'' , 'H',  10 , 1
EXECUTE [dbo].[PG_CI_SEXO]  0, 139,  2,	'MUJER'			,'' , 'M',  10 , 1

GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////