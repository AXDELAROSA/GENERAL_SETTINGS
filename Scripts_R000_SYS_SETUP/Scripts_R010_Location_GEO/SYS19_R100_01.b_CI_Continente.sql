-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			CONTINENTE
-- // OPERATION:		PROCEDIMIENTOS ESPECIFICOS
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20190903
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> CARGA INICIAL
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CONTINENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CONTINENTE]
GO


CREATE PROCEDURE [dbo].[PG_CI_CONTINENTE]
	--  @PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_K_CONTINENTE					INT,			
	@PP_D_CONTINENTE					VARCHAR(100),
	@PP_S_CONTINENTE					VARCHAR(10),
	@PP_O_CONTINENTE					INT,
	@PP_C_CONTINENTE					VARCHAR(255),
	@PP_L_CONTINENTE					INT
	-- =========================================
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_CONTINENTE
							FROM	[CONTINENTE]
							WHERE	K_CONTINENTE=@PP_K_CONTINENTE

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO [CONTINENTE]	
			(	[K_CONTINENTE], [D_CONTINENTE],
				[S_CONTINENTE], [O_CONTINENTE],
				[C_CONTINENTE], [L_CONTINENTE],
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_CONTINENTE, @PP_D_CONTINENTE,
				@PP_S_CONTINENTE, @PP_O_CONTINENTE, 
				@PP_C_CONTINENTE, @PP_L_CONTINENTE,
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )							
	ELSE
		UPDATE	CONTINENTE
		SET		
				[D_CONTINENTE]				= @PP_D_CONTINENTE,					
				[S_CONTINENTE]				= @PP_S_CONTINENTE,					
				[C_CONTINENTE]				= @PP_C_CONTINENTE,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_CONTINENTE=@PP_K_CONTINENTE
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_CONTINENTE] 0,139, 0, '(NO-CONTINENTE)', '( N/CN )' , 1 , '#0 // (NO-CONTINENTE)' , 0
EXECUTE [dbo].[PG_CI_CONTINENTE] 0,139, 100, 'ÁFRICA', 'ÁFRICA' , 1 , '#100 // ÁFRICA' , 0
EXECUTE [dbo].[PG_CI_CONTINENTE] 0,139, 200, 'AMÉRICA', 'AMÉRICA' , 1 , '#200 // AMÉRICA' , 1
EXECUTE [dbo].[PG_CI_CONTINENTE] 0,139, 300, 'ASIA', 'ASIA' , 1 , '#300 // ASIA' , 1
EXECUTE [dbo].[PG_CI_CONTINENTE] 0,139, 400, 'EUROPA', 'EUROPA' , 1 , '#400 // EUROPA' , 0
EXECUTE [dbo].[PG_CI_CONTINENTE] 0,139, 500, 'OCEANÍA', 'OCEANÍA' , 1 , '#500 // OCEANÍA' , 1




GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
