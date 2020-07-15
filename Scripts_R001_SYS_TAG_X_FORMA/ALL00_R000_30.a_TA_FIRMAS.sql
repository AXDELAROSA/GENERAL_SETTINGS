-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		ALL
-- // MODULE:			USUARIOS_PERMISOS
-- // OPERATION:		SP
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200323
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FIRMAS]') AND type in (N'U'))
	DROP TABLE [dbo].[FIRMAS]
GO

-- ////////////////////////////////////////////////////////////////
-- //					FIRMAS				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[FIRMAS] (
	[K_FIRMAS]				[INT]			NOT NULL,	--	#EMPLEADO DE RH
	[D_FIRMAS]				[VARCHAR](100)	NOT NULL,	--	NOMBRE_IMAGEN  (NOMBRE+#EMPLEADO)
	[C_FIRMAS]				[VARCHAR](255)	NOT NULL,	--	RUTA ARCHIVO DE IMAGEN
	[S_FIRMAS]				[VARCHAR](100)	NOT NULL,	--	FORMATO / EXTENSIÓN DEL ARCHIVO DE IMAGEN
	[O_FIRMAS]				[INT]			NOT NULL,	
	[L_FIRMAS]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[FIRMAS]
	ADD CONSTRAINT [PK_FIRMAS]
		PRIMARY KEY CLUSTERED ([K_FIRMAS])
GO
--CREATE UNIQUE NONCLUSTERED 
--	INDEX [UN_FIRMAS_01_DESCRIPCION] 
--	   ON [dbo].[FIRMAS] ( [D_FIRMAS] )
--GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FIRMAS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FIRMAS]
GO
-- //////////////////////////////////////////////////////////////
-- //				CI - FIRMAS
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_FIRMAS]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_FIRMAS				INT,
	@PP_D_FIRMAS				VARCHAR(100),
	@PP_C_FIRMAS				VARCHAR(255),
	@PP_S_FIRMAS				VARCHAR(100),
	@PP_O_FIRMAS				INT,
	@PP_L_FIRMAS				INT
AS				
	-- ===========================
	INSERT INTO FIRMAS
			(	[K_FIRMAS], [D_FIRMAS], 
				[C_FIRMAS], [S_FIRMAS], 
				[O_FIRMAS], [L_FIRMAS]		)
	VALUES	
			(	@PP_K_FIRMAS, @PP_D_FIRMAS, 
				@PP_C_FIRMAS, @PP_S_FIRMAS,
				@PP_O_FIRMAS, @PP_L_FIRMAS	 )
GO
EXECUTE [dbo].[PG_CI_FIRMAS] 0,0,22, 'GUILLERMO_ALFONSO_MATA','C:\FIRMAS', '.jpg', 10,1
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FIRMAS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FIRMAS]
GO

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////

