-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			CITY
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CITY]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CITY]
GO


CREATE PROCEDURE [dbo].[PG_CI_CITY]
	--@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ========================================
	@PP_K_CITY					INT,			
	@PP_D_CITY					VARCHAR(100),
	@PP_S_CITY					VARCHAR(10),
	@PP_C_CITY					VARCHAR(255),
	-- =========================================
	@PP_K_STATE_GEO			INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_CITY
							FROM	[CITY]
							WHERE	K_CITY=@PP_K_CITY

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO [CITY]	
			(	[K_CITY], [D_CITY],
				[S_CITY], [O_CITY],
				[C_CITY], [L_CITY],
				[K_STATE_GEO], 
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_CITY, @PP_D_CITY,
				@PP_S_CITY, 1, 
				@PP_C_CITY, 1,
				@PP_K_STATE_GEO,		
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )							
	ELSE
		UPDATE	CITY
		SET		
				[D_CITY]				= @PP_D_CITY,					
				[S_CITY]				= @PP_S_CITY,					
				[C_CITY]				= @PP_C_CITY,
				[K_STATE_GEO]				= @PP_K_STATE_GEO,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_CITY=@PP_K_CITY
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_CITY] 0,139,001,'AHUMADA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,002,'ALDAMA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,003,'ALLENDE','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,004,'AQUILES SERDÁN','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,005,'ASCENSIÓN','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,006,'BACHÍNIVA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,007,'BALLEZA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,008,'BATOPILAS DE MANUEL GÓMEZ MORÍN','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,009,'BOCOYNA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,010,'BUENAVENTURA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,011,'CAMARGO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,012,'CARICHÍ','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,013,'CASAS GRANDES','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,019,'CHIHUAHUA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,020,'CHÍNIPAS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,014,'CORONADO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,015,'COYAME DEL SOTOL','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,017,'CUAUHTÉMOC','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,018,'CUSIHUIRIACHI','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,021,'DELICIAS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,022,'DR. BELISARIO DOMÍNGUEZ','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,064,'EL TULE','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,023,'GALEANA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,025,'GÓMEZ FARÍAS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,026,'GRAN MORELOS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,027,'GUACHOCHI','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,028,'GUADALUPE','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,029,'GUADALUPE Y CALVO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,030,'GUAZAPARES','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,031,'GUERRERO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,032,'HIDALGO DEL PARRAL','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,033,'HUEJOTITÁN','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,034,'IGNACIO ZARAGOZA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,035,'JANOS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,036,'JIMÉNEZ','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,037,'JUÁREZ','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,038,'JULIMES','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,016,'LA CRUZ','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,039,'LÓPEZ','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,040,'MADERA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,041,'MAGUARICHI','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,042,'MANUEL BENAVIDES','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,043,'MATACHÍ','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,044,'MATAMOROS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,045,'MEOQUI','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,046,'MORELOS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,047,'MORIS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,048,'NAMIQUIPA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,049,'NONOAVA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,050,'NUEVO CASAS GRANDES','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,051,'OCAMPO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,052,'OJINAGA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,053,'PRAXEDIS G. GUERRERO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,054,'RIVA PALACIO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,055,'ROSALES','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,056,'ROSARIO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,057,'SAN FRANCISCO DE BORJA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,058,'SAN FRANCISCO DE CONCHOS','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,059,'SAN FRANCISCO DEL ORO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,060,'SANTA BÁRBARA','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,024,'SANTA ISABEL','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,061,'SATEVÓ','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,062,'SAUCILLO','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,063,'TEMÓSACHIC','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,065,'URIQUE','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,066,'URUACHI','','',08
EXECUTE [dbo].[PG_CI_CITY] 0,139,067,'VALLE DE ZARAGOZA','','',08


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
