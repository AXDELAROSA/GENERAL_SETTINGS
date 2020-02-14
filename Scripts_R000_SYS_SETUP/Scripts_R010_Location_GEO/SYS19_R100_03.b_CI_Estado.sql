-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			STATE_GEO
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_STATE_GEO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_STATE_GEO]
GO


CREATE PROCEDURE [dbo].[PG_CI_STATE_GEO]
	--@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ========================================
	@PP_K_STATE_GEO					INT,			
	@PP_D_STATE_GEO					VARCHAR(100),
	@PP_S_STATE_GEO					VARCHAR(10),
	@PP_O_STATE_GEO					INT,
	@PP_C_STATE_GEO					VARCHAR(255),
	@PP_L_STATE_GEO					INT,
	-- =========================================
	@PP_K_COUNTRY			INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_STATE_GEO
							FROM	[STATE_GEO]
							WHERE	K_STATE_GEO=@PP_K_STATE_GEO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO [STATE_GEO]	
			(	[K_STATE_GEO], [D_STATE_GEO],
				[S_STATE_GEO], [O_STATE_GEO],
				[C_STATE_GEO], [L_STATE_GEO],
				[K_COUNTRY], 
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_STATE_GEO, @PP_D_STATE_GEO,
				@PP_S_STATE_GEO, 1, 
				@PP_C_STATE_GEO, 1,
				@PP_K_COUNTRY,		
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )							
	ELSE
		UPDATE	STATE_GEO
		SET		
				[D_STATE_GEO]				= @PP_D_STATE_GEO,					
				[S_STATE_GEO]				= @PP_S_STATE_GEO,					
				[C_STATE_GEO]				= @PP_C_STATE_GEO,
				[K_COUNTRY]				= @PP_K_COUNTRY,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_STATE_GEO=@PP_K_STATE_GEO
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 0, '(NO-STATE-GEO)', '( N/ST )' , 1 , '#0 // (NO-STATE-GEO)' , 1,0
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 1, 'Aguascalientes', 'Aguas' , 1 , '#1 // Aguascalientes' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 2, 'Baja California', 'BCali' , 1 , '#2 // Baja California' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 3, 'Baja California Sur', 'BCSur' , 1 , '#3 // Baja California Sur' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 4, 'Campeche', 'Campe' , 1 , '#4 // Campeche' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 5, 'Coahuila de Zaragoza', 'Coahu' , 1 , '#5 // Coahuila de Zaragoza' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 6, 'Colima', 'Colim' , 1 , '#6 // Colima' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 7, 'Chiapas', 'Chiap' , 1 , '#7 // Chiapas' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 8, 'Chihuahua', 'Chihu' , 1 , '#8 // Chihuahua' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 9, 'Ciudad de México', 'CDMX' , 1 , '#9 // Ciudad de México' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 10, 'Durango', 'Duran' , 1 , '#10 // Durango' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 11, 'Guanajuato', 'Guana' , 1 , '#11 // Guanajuato' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 12, 'Guerrero', 'Guerr' , 1 , '#12 // Guerrero' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 13, 'Hidalgo', 'Hidal' , 1 , '#13 // Hidalgo' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 14, 'Jalisco', 'Jalis' , 1 , '#14 // Jalisco' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 15, 'México', 'Méxic' , 1 , '#15 // México' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 16, 'Michoacán de Ocampo', 'Micho' , 1 , '#16 // Michoacán de Ocampo' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 17, 'Morelos', 'Morel' , 1 , '#17 // Morelos' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 18, 'Nayarit', 'Nayar' , 1 , '#18 // Nayarit' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 19, 'Nuevo León', 'Nuevo' , 1 , '#19 // Nuevo León' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 20, 'Oaxaca', 'Oaxac' , 1 , '#20 // Oaxaca' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 21, 'Puebla', 'Puebl' , 1 , '#21 // Puebla' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 22, 'Querétaro', 'Queré' , 1 , '#22 // Querétaro' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 23, 'Quintana Roo', 'Quint' , 1 , '#23 // Quintana Roo' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 24, 'San Luis Potosí', 'SLuis' , 1 , '#24 // San Luis Potosí' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 25, 'Sinaloa', 'Sinal' , 1 , '#25 // Sinaloa' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 26, 'Sonora', 'Sonor' , 1 , '#26 // Sonora' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 27, 'Tabasco', 'Tabas' , 1 , '#27 // Tabasco' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 28, 'Tamaulipas', 'Tamau' , 1 , '#28 // Tamaulipas' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 29, 'Tlaxcala', 'Tlaxc' , 1 , '#29 // Tlaxcala' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 30, 'Veracruz de Ignacio de la Llav', 'Verac' , 1 , '#30 // Veracruz de Ignacio de la Llav' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 31, 'Yucatán', 'Yucat' , 1 , '#31 // Yucatán' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 32, 'Zacatecas', 'Zacat' , 1 , '#32 // Zacatecas' , 1,260


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
