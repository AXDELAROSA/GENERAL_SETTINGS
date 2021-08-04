-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	[BD_GENERAL]
-- // MODULO:			[AUTORIZACIÓN ACTUALIZACIÓN]
-- // OPERACION:		STORED PROCEDURES
-- //////////////////////////////////////////////////////////////
-- // Autor:			AX
-- // Fecha creación:	20210728
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AUTORIZACION_ACTUALIZAR]') AND type in (N'U'))
	DROP TABLE [dbo].[AUTORIZACION_ACTUALIZAR]
GO


-- //////////////////////////////////////////////////////////////
-- // AUTORIZACION_ACTUALIZAR
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[AUTORIZACION_ACTUALIZAR] (
	[K_AUTORIZACION_ACTUALIZAR]			[INT]			IDENTITY(1,1)		NOT NULL,
	-- =================================	
	[D_NOMBRE_EQUIPO]					[VARCHAR](250)	NOT NULL,
	[L_AUTORIZACION_ACTUALIZAR]			[INT]			NOT NULL	DEFAULT 1,
	[VERSION_ACTUALIZAR]				[INT]			NOT NULL	DEFAULT 0,
	-- =================================	
)ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[AUTORIZACION_ACTUALIZAR]
	ADD CONSTRAINT [PK_AUTORIZACION_ACTUALIZAR]
		PRIMARY KEY CLUSTERED ([K_AUTORIZACION_ACTUALIZAR])
GO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_AUTORIZACION_ACTUALIZAR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_AUTORIZACION_ACTUALIZAR]
GO

CREATE PROCEDURE [dbo].[PG_CI_AUTORIZACION_ACTUALIZAR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_D_NOMBRE_EQUIPO					VARCHAR(250),
	@PP_L_AUTORIZACION_ACTUALIZAR		INT	
AS
	-- ===============================
	DECLARE @VP_K_EXISTE	INT	= 0
	
	SELECT	@VP_K_EXISTE =	K_AUTORIZACION_ACTUALIZAR
	FROM	AUTORIZACION_ACTUALIZAR		(NOLOCK)
	WHERE	D_NOMBRE_EQUIPO	= @PP_D_NOMBRE_EQUIPO
	-- ===============================

	IF ( @VP_K_EXISTE IS NULL ) OR ( @VP_K_EXISTE  = 0 )
	BEGIN
		INSERT INTO AUTORIZACION_ACTUALIZAR	
			(	
				[D_NOMBRE_EQUIPO]			,
				[L_AUTORIZACION_ACTUALIZAR]
			)		
		VALUES	
			(	
				@PP_D_NOMBRE_EQUIPO			,
				@PP_L_AUTORIZACION_ACTUALIZAR
			)
	END
	ELSE
	BEGIN
		UPDATE	AUTORIZACION_ACTUALIZAR
		SET		D_NOMBRE_EQUIPO				= @PP_D_NOMBRE_EQUIPO,	
				L_AUTORIZACION_ACTUALIZAR	= @PP_L_AUTORIZACION_ACTUALIZAR
		WHERE	K_AUTORIZACION_ACTUALIZAR	= @VP_K_EXISTE
	END
	-- =========================================================
GO

-- ===============================================
SET NOCOUNT ON
-- ===============================================
/*
use BD_GENERAL
SELECT * FROM bd_general.dbo.AUTORIZACION_ACTUALIZAR
*/
-- ===============================================
EXECUTE [dbo].[PG_CI_AUTORIZACION_ACTUALIZAR] 0, 0, 'MTR-TV'		,1
EXECUTE [dbo].[PG_CI_AUTORIZACION_ACTUALIZAR] 0, 0, 'LAMINADORA'	,1
EXECUTE [dbo].[PG_CI_AUTORIZACION_ACTUALIZAR] 0, 0, 'IT-007'		,1
GO-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
