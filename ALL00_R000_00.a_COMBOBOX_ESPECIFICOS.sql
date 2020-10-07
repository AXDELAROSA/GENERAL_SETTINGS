-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		ALL
-- // MODULE:			COMBOBOX
-- // OPERATION:		GENERAR COMBOBOX
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			IT	
-- // CREATION DATE:	20200214
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO


/* CARGA COMBO DE LOCACIONES */
-- EXECUTE [PG_CB_IMLOCFIL_SQL] 001,144, 1
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_IMLOCFIL_SQL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_IMLOCFIL_SQL]
GO


CREATE PROCEDURE [dbo].[PG_CB_IMLOCFIL_SQL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS

	DECLARE @VP_TA_CATALOGO	AS TABLE
						(	TA_K_CATALOGO		INT IDENTITY(1,1) NOT NULL,
							TA_D_CATALOGO		VARCHAR(50))

	IF @PP_L_CON_TODOS=1
		BEGIN	
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	LTRIM(RTRIM(alt1_loc))		AS D_COMBOBOX	
			FROM	DATA_02.DBO.imlocfil_sql 
		END

	IF @PP_L_CON_TODOS=2
		BEGIN
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	LTRIM(RTRIM(alt1_loc))		AS D_COMBOBOX	
			FROM	DATA_02.DBO.imlocfil_sql 
			WHERE	SUBSTRING(LTRIM(RTRIM(alt1_loc)),1,1) IN ('T', 'G')
			UNION
			SELECT	LTRIM(RTRIM(alt1_loc))		AS D_COMBOBOX	
			FROM	DATA_02.DBO.imlocfil_sql 
			WHERE	 LTRIM(RTRIM(alt1_loc)) = 'MHI'
		END

	IF @PP_L_CON_TODOS=3
		BEGIN
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	LTRIM(RTRIM(alt1_loc))		AS D_COMBOBOX	
			FROM	DATA_02.DBO.imlocfil_sql 
			WHERE	SUBSTRING(LTRIM(RTRIM(alt1_loc)),1,1) NOT IN ('T', 'G') 
		END

	IF @PP_L_CON_TODOS=4
		BEGIN
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	LTRIM(RTRIM(loc_desc))		AS D_COMBOBOX	
			FROM	DATA_02.DBO.imlocfil_sql 
			WHERE	SUBSTRING(LTRIM(RTRIM(loc_desc)),1,1) = 'T'
		END

	IF @PP_L_CON_TODOS=5
		BEGIN
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	LTRIM(RTRIM(alt1_loc))		AS D_COMBOBOX	
			FROM	DATA_02.DBO.imlocfil_sql 

			INSERT INTO @VP_TA_CATALOGO (TA_D_CATALOGO)
			VALUES ( '( TODOS )'	)
		END
		
	IF @PP_L_CON_TODOS=6 -- PARA LISTADO DE GENERAR ORDEN EN GERBER
		BEGIN
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	LTRIM(RTRIM(loc_desc))		AS D_COMBOBOX	
			FROM	DATA_02.DBO.imlocfil_sql 
			WHERE	SUBSTRING(LTRIM(RTRIM(loc_desc)),1,1) = 'G'

			INSERT INTO @VP_TA_CATALOGO (TA_D_CATALOGO)
			VALUES ( '( TODOS )'	)
		END

	IF @PP_L_CON_TODOS=7 -- PARA FICHA DE GENERAR ORDEN EN GERBER
		BEGIN
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	LTRIM(RTRIM(loc_desc))		AS D_COMBOBOX	
			FROM	DATA_02.DBO.imlocfil_sql 
			WHERE	SUBSTRING(LTRIM(RTRIM(loc_desc)),1,1) = 'G'

		END

		-- ====================================================================================
		-- =======================		FO_INVENTARIO
		-- ====================================================================================
		--	PARA GENERAR COMBO DE LA FO_INVENTARIO, MUESTRA LAS LOCACIONES
	--IF @PP_L_CON_TODOS=10	OR	@PP_L_CON_TODOS=11
	--	BEGIN
	--		INSERT INTO @VP_TA_CATALOGO 
	--		SELECT	A4GLIDENTITY AS TA_K_CATALOGO,
	--				LTRIM(RTRIM(loc)) AS TA_D_CATALOGO
	--		FROM	[DATA_02].[dbo].imlocfil_sql
	--		WHERE	LTRIM(RTRIM(alt1_loc))=''
	--		ORDER BY TA_D_CATALOGO

			--	PARA GENERAR COMBO DE LA FO_INVENTARIO, MUESTRA LAS LOCACIONES CON EL TODOS CON (-1)
				--IF @PP_L_CON_TODOS=11
				--	BEGIN
				--		INSERT INTO @VP_TA_CATALOGO
				--			( TA_K_CATALOGO,	TA_D_CATALOGO	)
				--		VALUES
				--			( -1,				'( TODOS )'		)
				--	END
		--END
		-- ====================================================================================
		--SELECT * FROM [DATA_02].[dbo].imlocfil_sql
		-- ====================================================================================

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
			TA_D_CATALOGO	AS D_COMBOBOX 
	FROM	@VP_TA_CATALOGO
	ORDER BY  TA_D_CATALOGO 
		
	-- ////////////////////////////////////////////////////
GO


-- ////////////////////////////////////////////////////
-- //	CARGA COMBO DE LOCACIONES PARA LA FO_INVENTARIO
-- ////////////////////////////////////////////////////
-- EXECUTE [PG_CB_IMLOCFIL_INVENTARIO_SQL] 001,144, 10
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_IMLOCFIL_INVENTARIO_SQL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_IMLOCFIL_INVENTARIO_SQL]
GO
CREATE PROCEDURE [dbo].[PG_CB_IMLOCFIL_INVENTARIO_SQL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS

	DECLARE @VP_TA_CATALOGO	AS TABLE
						(	TA_K_CATALOGO		INT NOT NULL,
							TA_D_CATALOGO		VARCHAR(50))

		-- ====================================================================================
		-- =======================		FO_INVENTARIO
		-- ====================================================================================
		----	PARA GENERAR COMBO DE LA FO_INVENTARIO, MUESTRA LAS LOCACIONES
		IF @PP_L_CON_TODOS=10	OR	@PP_L_CON_TODOS=11
			BEGIN
				INSERT INTO @VP_TA_CATALOGO 
				SELECT	A4GLIDENTITY AS TA_K_CATALOGO,
						LTRIM(RTRIM(loc)) AS TA_D_CATALOGO
				FROM	[DATA_02].[dbo].imlocfil_sql
				WHERE	LTRIM(RTRIM(alt1_type))=''
				ORDER BY TA_D_CATALOGO

				----	PARA GENERAR COMBO DE LA FO_INVENTARIO, MUESTRA LAS LOCACIONES CON EL TODOS CON (-1)
					IF @PP_L_CON_TODOS=11
						BEGIN
							INSERT INTO @VP_TA_CATALOGO
								( TA_K_CATALOGO,	TA_D_CATALOGO	)
							VALUES
								( -1,				'( TODOS )'		)
						END
			END
		-- ====================================================================================
		--SELECT * FROM [DATA_02].[dbo].imlocfil_sql
		-- ====================================================================================

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
			TA_D_CATALOGO	AS D_COMBOBOX 
	FROM	@VP_TA_CATALOGO
	ORDER BY  TA_D_CATALOGO 
		
	-- ////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- EXECUTE [dbo].[PG_CB_CUSTOMER_ARCUSFIL_SQL] 0,0, 1
-- //////////////////////////////////////////////////////////////
-- // /* CARGA COMBO DE CLIENTES */
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_CUSTOMER_ARCUSFIL_SQL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_CUSTOMER_ARCUSFIL_SQL]
GO
CREATE PROCEDURE [dbo].[PG_CB_CUSTOMER_ARCUSFIL_SQL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50),
					TA_O_CATALOGO		INT,
					TA_L_DELETED		INT,	
					TA_L_ACTIVO			INT			 )
	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT	A4GLIDENTITY AS TA_K_CATALOGO,
			LTRIM(RTRIM(CUS_NO)) AS TA_D_CATALOGO, 
			0 AS TA_O_CATALOGO,
			0 AS L_DELETED, 
			1 AS L_ACTIVO
	FROM	[DATA_02].[dbo].ARCUSFIL_SQL
	ORDER BY TA_D_CATALOGO

	IF @PP_L_CON_TODOS=1
		INSERT INTO @VP_TA_CATALOGO
				( TA_K_CATALOGO,	TA_D_CATALOGO,	TA_O_CATALOGO, TA_L_DELETED, TA_L_ACTIVO	)
			VALUES
				( -1,				'( TODOS )',	-999,		   0,			 1				)

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX 
		FROM	@VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 

	-- ==========================================
		
	-- ////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- SELECT * FROM	[DATA_02].[dbo].ARCUSFIL_SQL
-- SELECT * FROM	[DATA_02].[dbo].IMCATFIL_SQL
-- EXECUTE [dbo].[PG_CB_PRODUCT_CATEGORY_IMCATFIL_SQL] 0,0, 1
-- //////////////////////////////////////////////////////////////
-- // /* CARGA COMBO DE PRODUCT_CATEGORY */
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_PRODUCT_CATEGORY_IMCATFIL_SQL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_PRODUCT_CATEGORY_IMCATFIL_SQL]
GO


CREATE PROCEDURE [dbo].[PG_CB_PRODUCT_CATEGORY_IMCATFIL_SQL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50),
					TA_O_CATALOGO		INT,
					TA_L_DELETED		INT,	
					TA_L_ACTIVO			INT			 )
	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT	A4GLIDENTITY			AS TA_K_CATALOGO,
			LTRIM(RTRIM(PROD_CAT))	AS TA_D_CATALOGO, 
			0 AS TA_O_CATALOGO,
			0 AS L_DELETED, 
			1 AS L_ACTIVO
	FROM	[DATA_02].[dbo].IMCATFIL_SQL
	WHERE	PROD_CAT_DESC<>'OBSOLETE' 
	AND		PROD_CAT_DESC<>'DO NOT DELETE'
	ORDER BY TA_D_CATALOGO

	IF @PP_L_CON_TODOS=1
		INSERT INTO @VP_TA_CATALOGO
				( TA_K_CATALOGO,	TA_D_CATALOGO,	TA_O_CATALOGO, TA_L_DELETED, TA_L_ACTIVO	)
			VALUES
				( -1,				'( TODOS )',	-999,		   0,			 1				)

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX 
		FROM	@VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 
	-- ==========================================		
	-- ////////////////////////////////////////////////////
GO

-- //////////////////////////////////////////////////////////////
-- // /* CARGA COMBO DE COLORES */
-- //////////////////////////////////////////////////////////////
-- EXECUTE [dbo].[PG_CB_COLOR_IMITMIDX_SQL] 1,139,4
-- USE [BD_GENERAL]
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_COLOR_IMITMIDX_SQL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_COLOR_IMITMIDX_SQL]
GO


CREATE PROCEDURE [dbo].[PG_CB_COLOR_IMITMIDX_SQL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50),
					TA_O_CATALOGO		INT,
					TA_L_DELETED		INT,	
					TA_L_ACTIVO			INT			 )
		-- ==========================================

	IF @PP_L_CON_TODOS=0
	INSERT INTO @VP_TA_CATALOGO 
	SELECT	A4GLIDENTITY			AS TA_K_CATALOGO,
			LTRIM(RTRIM(ITEM_NO))	AS TA_D_CATALOGO,
			0						AS TA_O_CATALOGO,
			0						AS L_DELETED, 
			1						AS L_ACTIVO
	FROM [DATA_02].[dbo].IMITMIDX_SQL 
	WHERE ITEM_NO LIKE 'F%'
	AND LEN(RTRIM(LTRIM(ITEM_NO)))=7
	ORDER BY TA_D_CATALOGO 

	-- ==========================================
	IF @PP_L_CON_TODOS=1
		BEGIN
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	A4GLIDENTITY			AS TA_K_CATALOGO,
					LTRIM(RTRIM(ITEM_NO))	AS TA_D_CATALOGO,
					0						AS TA_O_CATALOGO,
					0						AS L_DELETED, 
					1						AS L_ACTIVO
			FROM [DATA_02].[dbo].IMITMIDX_SQL 
			WHERE ITEM_NO LIKE 'F%'
			AND LEN(RTRIM(LTRIM(ITEM_NO)))=7
			ORDER BY TA_D_CATALOGO 

			INSERT INTO @VP_TA_CATALOGO
					( TA_K_CATALOGO,	TA_D_CATALOGO,	TA_O_CATALOGO, TA_L_DELETED, TA_L_ACTIVO	)
				VALUES
					( -1,				'( TODOS )',	-999,		   0,			 1				)

		END
			-- ==========================================

		IF @PP_L_CON_TODOS=2
			INSERT INTO @VP_TA_CATALOGO 
			SELECT	A4GLIDENTITY			AS TA_K_CATALOGO,
					LTRIM(RTRIM(ITEM_NO))	AS TA_D_CATALOGO,
					0						AS TA_O_CATALOGO,
					0						AS L_DELETED, 
					1						AS L_ACTIVO
			FROM [DATA_02].[dbo].IMITMIDX_SQL 
			WHERE ITEM_NO IN (SELECT COLOR FROM [DATA_02].DBO.COLORES_CONTROLADOS WHERE COLOR <> 'FMCKSTT')
			AND LEN(RTRIM(LTRIM(ITEM_NO)))=7
			ORDER BY TA_D_CATALOGO 
			-- ==========================================

		IF @PP_L_CON_TODOS=3
		INSERT INTO @VP_TA_CATALOGO 
		SELECT	A4GLIDENTITY			AS TA_K_CATALOGO,
				LTRIM(RTRIM(ITEM_NO))	AS TA_D_CATALOGO,
				0						AS TA_O_CATALOGO,
				0						AS L_DELETED, 
				1						AS L_ACTIVO
		FROM [DATA_02].[dbo].IMITMIDX_SQL 
		WHERE ITEM_NO LIKE 'F%'
		AND LEN(RTRIM(LTRIM(ITEM_NO)))=7
		ORDER BY TA_D_CATALOGO 
			-- ==========================================
					
		SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX 
		FROM	@VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 

	

	-- ==========================================
	-- ==========================================
		
	-- ////////////////////////////////////////////////////
GO


-- USE BD_GENERAL
-- EXECUTE [dbo].[PG_CB_PIEL_CLASIFICACION] 0,0, 1
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_PIEL_CLASIFICACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_PIEL_CLASIFICACION]
GO


CREATE PROCEDURE [dbo].[PG_CB_PIEL_CLASIFICACION]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50),
					TA_O_CATALOGO		INT
					)
	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT	K_PIEL_CLASIFICACION AS TA_K_CATALOGO,
			D_PIEL_CLASIFICACION AS TA_D_CATALOGO, 
			O_PIEL_CLASIFICACION AS TA_O_CATALOGO
	FROM	[DATA_02].[dbo].PIEL_CLASIFICACION
	ORDER BY TA_D_CATALOGO

	IF @PP_L_CON_TODOS=1
		INSERT INTO @VP_TA_CATALOGO
				( TA_K_CATALOGO,	TA_D_CATALOGO,	TA_O_CATALOGO)
			VALUES
				( -1,				'( TODOS )',	-999			)

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX 
		FROM	@VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 

	-- ==========================================
		
	-- ////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- EXECUTE [dbo].[PG_CB_SYSCDEFIL_SQL] 0,0, 1
-- //////////////////////////////////////////////////////////////
-- // /* CODIGO UTILIZACION */ sycdefil_sql
-- //////////////////////////////////////////////////////////////
--	USE [BD_GENERAL]
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_SYSCDEFIL_SQL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_SYSCDEFIL_SQL]
GO


CREATE PROCEDURE [dbo].[PG_CB_SYSCDEFIL_SQL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)
							 )
	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT	A4GLIDENTITY AS TA_K_CATALOGO,
			CONCAT(LTRIM(RTRIM(sy_terms_cd)), ' - ', LTRIM(RTRIM(filler_0001))) AS TA_D_CATALOGO
	FROM	[DATA_02].[dbo].sycdefil_sql
	WHERE	cd_type = 'R' 
	AND		sy_terms_cd LIKE 'H%' 
	ORDER BY	sy_terms_cd

	IF @PP_L_CON_TODOS=1
		INSERT INTO @VP_TA_CATALOGO
				( TA_K_CATALOGO,	TA_D_CATALOGO)
			VALUES
				( -1,				'( TODOS )')

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
			TA_D_CATALOGO	AS D_COMBOBOX 
	FROM	@VP_TA_CATALOGO
	ORDER BY  TA_D_CATALOGO 

	-- ==========================================
		
	-- ////////////////////////////////////////////////////
GO



-- USE BD_GENERAL
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_ITEM_INSPECCION_CONFIGURADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_ITEM_INSPECCION_CONFIGURADA]
GO
/*
 EXECUTE [dbo].[PG_CB_ITEM_INSPECCION_CONFIGURADA] 0,0, 1
*/
CREATE PROCEDURE [dbo].[PG_CB_ITEM_INSPECCION_CONFIGURADA]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50),
					TA_O_CATALOGO		INT
					)
	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT DISTINCT	ITEM.K_ITEM AS TA_K_CATALOGO,
			PART_NUMBER_ITEM_PEARL AS TA_D_CATALOGO, 
			O_ITEM AS TA_O_CATALOGO
	FROM	COMPRAS_PRUEBAS.dbo.ITEM 
	INNER JOIN [DATA_02Pruebas].[dbo].INSPECCION_MATERIAL ON ITEM.K_ITEM = INSPECCION_MATERIAL.K_ITEM
	ORDER BY TA_D_CATALOGO

	IF @PP_L_CON_TODOS=1
		INSERT INTO @VP_TA_CATALOGO
				( TA_K_CATALOGO,	TA_D_CATALOGO,	TA_O_CATALOGO)
			VALUES
				( -1,				'( TODOS )',	-999			)

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX 
		FROM	@VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 

	-- ==========================================
		
	-- ////////////////////////////////////////////////////
GO



-- USE BD_GENERAL
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_HIDESHDR_SQL_TYPE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_HIDESHDR_SQL_TYPE]
GO
/*
 EXECUTE [dbo].[PG_CB_HIDESHDR_SQL_TYPE] 0,0, 2
*/
CREATE PROCEDURE [dbo].[PG_CB_HIDESHDR_SQL_TYPE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT IDENTITY (1,1),
					TA_D_CATALOGO		VARCHAR(50),
					TA_O_CATALOGO		INT DEFAULT 1
					)
	
	--IF @PP_L_CON_TODOS=1
	--INSERT INTO @VP_TA_CATALOGO 
	--SELECT	DISTINCT LTRIM(RTRIM(TYPE)) , 0
	--FROM	[DATA_02].[dbo].HIDESHDR_SQL 

	IF @PP_L_CON_TODOS=1
		INSERT INTO @VP_TA_CATALOGO 
		SELECT DISTINCT
				LTRIM(RTRIM(search_desc))	AS TA_D_CATALOGO,
				0
		FROM [DATA_02].[dbo].IMITMIDX_SQL 
		WHERE ITEM_NO LIKE 'F%'
		AND LEN(RTRIM(LTRIM(ITEM_NO)))=7
		ORDER BY TA_D_CATALOGO 
			-- ==========================================
	--IF @PP_L_CON_TODOS=1
	--	INSERT INTO @VP_TA_CATALOGO
	--			( TA_K_CATALOGO,	TA_D_CATALOGO,	TA_O_CATALOGO)
	--		VALUES
	--			( -1,				'( TODOS )',	-999			)

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX 
		FROM	@VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 

	-- ==========================================
		
	-- ////////////////////////////////////////////////////
GO

