-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			FOB_POINT
-- // OPERATION:		PROCEDIMIENTOS ESPECIFICOS
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20190903
-- ////////////////////////////////////////////////////////////// 

USE [COT19_Cotizaciones_V9999_R0]
GO

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
	@PP_K_ESTATUS_FOB_POINT			INT,
	@PP_K_COUNTRY					INT,
	@PP_K_STATE_GEO_FOB_POINT		INT
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
				[K_COUNTRY],
				[K_STATE_GEO_FOB_POINT],
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_FOB_POINT, @PP_D_FOB_POINT,
				@PP_S_FOB_POINT, 1, 
				@PP_C_FOB_POINT, 1,
				@PP_K_ESTATUS_FOB_POINT,	
				@PP_K_COUNTRY,
				@PP_K_STATE_GEO_FOB_POINT,	
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
				[K_COUNTRY]					= @PP_K_COUNTRY,
				[K_STATE_GEO_FOB_POINT]		= @PP_K_STATE_GEO_FOB_POINT,
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

EXECUTE [dbo].[PG_CI_FOB_Point] 0, 139, 0, '(NO-FOBPoint)', '( N/C )' , 1 , '#0 // (NO-FOBPoint)' , 1,1,0,0
EXECUTE [dbo].[PG_CI_FOB_Point] 0, 139, 1, 'JUAREZ', 'JRZ,MX' , 1 , '#1 // JUAREZ' , 1,1,260,8


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
