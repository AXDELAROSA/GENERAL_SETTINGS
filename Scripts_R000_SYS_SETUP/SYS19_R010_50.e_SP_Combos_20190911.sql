-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		ALL
-- // MODULE:			COMBOS
-- // OPERATION:		SP
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20190912
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////



/****************************************************************/
/*					COMBO DIRECTO DE TABLA						*/
/****************************************************************/

-- EXECUTE [PG_CB_TABLA_N1] 0,0,COLOR

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_TABLA_N1]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_TABLA_N1]
GO

CREATE PROCEDURE [dbo].[PG_CB_TABLA_N1]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_NOMBRE_TABLA			VARCHAR(255)
AS

	--DECLARE @VP_INT_SHOW_K		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_COMBO_SHOW_K_GET]		--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--															@OU_SHOW_K = @VP_INT_SHOW_K					OUTPUT
	-- ==========================================

	DECLARE @PP_L_APLICAR_MAX_ROWS		INT
	
	--SET @PP_L_APLICAR_MAX_ROWS = 0
	
	--DECLARE @VP_LI_N_REGISTROS		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--														@PP_L_APLICAR_MAX_ROWS,
	--														@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- =========================================	

	DECLARE @VP_STR_SQL					NVARCHAR(MAX)

	--IF @PP_L_APLICAR_MAX_ROWS=1 
	--	--SET @VP_STR_SQL = 'SELECT TOP ('+ CONVERT(VARCHAR(100),@VP_LI_N_REGISTROS) +')' 
	--	SET @VP_STR_SQL = 'SELECT TOP (5000)' 
	--ELSE
		SET @VP_STR_SQL = 'SELECT ' 
	
	SET @VP_STR_SQL = @VP_STR_SQL + ' '
	SET @VP_STR_SQL = @VP_STR_SQL + ' K_'+@PP_NOMBRE_TABLA + ' AS K_CATALOGO'
	
	--IF @VP_INT_SHOW_K=1
	--	SET @VP_STR_SQL = @VP_STR_SQL + ', (D_'+@PP_NOMBRE_TABLA + '+' + '''' + ' [#' + '''' + ' + CONVERT(VARCHAR(100), K_'+@PP_NOMBRE_TABLA+')+' + '''' + ']' + '''' + ') AS D_CATALOGO'
	--ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', D_'+@PP_NOMBRE_TABLA + ' AS D_CATALOGO'
	
	SET @VP_STR_SQL = @VP_STR_SQL + ' '		
	SET @VP_STR_SQL = @VP_STR_SQL + 'FROM ' + @PP_NOMBRE_TABLA 

	SET @VP_STR_SQL = @VP_STR_SQL + ' '			
	SET @VP_STR_SQL = @VP_STR_SQL + 'ORDER BY D_'+@PP_NOMBRE_TABLA + ''
	
	-- ==========================================

	--SELECT @VP_STR_SQL AS 'SQL'
	EXECUTE sp_executesql @VP_STR_SQL 

	-- ==========================================
GO


-- ///////////////////////////////////////////////////////////////
-- //AX: AQUI SE GENERA LA INFORMACIÓN QUE CONTENDRÁ EL COMBO
-- ///////////////////////////////////////////////////////////////
-- [PG_CB_TABLA_N1_X_ORDEN_Select] 0, 0, 'COLOR'

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_TABLA_N1_X_ORDEN_Select]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_TABLA_N1_X_ORDEN_Select]
GO

CREATE PROCEDURE [dbo].[PG_CB_TABLA_N1_X_ORDEN_Select]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_NOMBRE_TABLA			VARCHAR(255)
AS

	DECLARE @VP_L_BORRADO	INT

	IF  0=(		SELECT	COUNT(*) 
				FROM	INFORMATION_SCHEMA.COLUMNS AS COLUMNAS
				WHERE	COLUMNAS.TABLE_NAME=@PP_NOMBRE_TABLA
				AND		COLUMNAS.COLUMN_NAME='L_BORRADO'		) 
		SET @VP_L_BORRADO = 0
	ELSE
		SET @VP_L_BORRADO = 1

	-- ==========================================

	DECLARE @VP_L_TABLA		INT = 0

	IF  0=(		SELECT	COUNT(*) 
				FROM	INFORMATION_SCHEMA.COLUMNS AS COLUMNAS
				WHERE	COLUMNAS.TABLE_NAME=@PP_NOMBRE_TABLA
				AND		COLUMNAS.COLUMN_NAME='L_'+@PP_NOMBRE_TABLA		) 
		SET @VP_L_TABLA = 0
	ELSE
		SET @VP_L_TABLA = 1

	-- //////////////////////////////////////////

	--DECLARE @PP_L_APLICAR_MAX_ROWS		INT
	
	--SET @PP_L_APLICAR_MAX_ROWS = 0
	
	--DECLARE @VP_LI_N_REGISTROS		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--														@PP_L_APLICAR_MAX_ROWS,
	--														@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- =========================================	

	DECLARE @VP_STR_SQL					NVARCHAR(MAX)

	--IF @PP_L_APLICAR_MAX_ROWS=1 
	--	--SET @VP_STR_SQL = 'SELECT TOP ('+ CONVERT(VARCHAR(100),@VP_LI_N_REGISTROS) +')' 
	--	SET @VP_STR_SQL = 'SELECT TOP (5000)' 
	--ELSE
		SET @VP_STR_SQL = 'SELECT ' 
	
	SET @VP_STR_SQL = @VP_STR_SQL + ' '

	SET @VP_STR_SQL = @VP_STR_SQL +  ' K_'+@PP_NOMBRE_TABLA + ' AS K_CATALOGO'	
	SET @VP_STR_SQL = @VP_STR_SQL + ', D_'+@PP_NOMBRE_TABLA + ' AS D_CATALOGO'

	SET @VP_STR_SQL = @VP_STR_SQL + ', O_'+@PP_NOMBRE_TABLA + ' AS O_CATALOGO'	
-- WIWI ORDEN
--	SET @VP_STR_SQL = @VP_STR_SQL + ', 123  AS O_CATALOGO'

	IF @VP_L_BORRADO=1
		SET @VP_STR_SQL = @VP_STR_SQL + ', L_BORRADO AS L_DELETED'
	ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', 0 AS L_DELETED'

	IF @VP_L_TABLA=1
		SET @VP_STR_SQL = @VP_STR_SQL + ', L_'+@PP_NOMBRE_TABLA+' AS L_ACTIVO'		
	ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', 1 AS L_ACTIVO'		

	SET @VP_STR_SQL = @VP_STR_SQL + ' '		
	SET @VP_STR_SQL = @VP_STR_SQL + 'FROM ' + @PP_NOMBRE_TABLA  	

	-- ==========================================

	EXECUTE sp_executesql @VP_STR_SQL 

	-- ==========================================
GO


-- ///////////////////////////////////////////////////////////////
-- //
-- ///////////////////////////////////////////////////////////////
-- [PG_CB_TABLA_N1_Select] 0, 0, 'COLOR'


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_TABLA_N1_Select]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_TABLA_N1_Select]
GO

CREATE PROCEDURE [dbo].[PG_CB_TABLA_N1_Select]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_NOMBRE_TABLA			VARCHAR(255)
AS

	DECLARE @VP_L_BORRADO	INT

	IF  0=(		SELECT	COUNT(*) 
				FROM	INFORMATION_SCHEMA.COLUMNS AS COLUMNAS
				WHERE	COLUMNAS.TABLE_NAME=@PP_NOMBRE_TABLA
				AND		COLUMNAS.COLUMN_NAME='L_BORRADO'		) 
		SET @VP_L_BORRADO = 0
	ELSE
		SET @VP_L_BORRADO = 1

	-- ==========================================

	DECLARE @VP_L_TABLA		INT = 0

	IF  0=(		SELECT	COUNT(*) 
				FROM	INFORMATION_SCHEMA.COLUMNS AS COLUMNAS
				WHERE	COLUMNAS.TABLE_NAME=@PP_NOMBRE_TABLA
				AND		COLUMNAS.COLUMN_NAME='L_'+@PP_NOMBRE_TABLA		) 
		SET @VP_L_TABLA = 0
	ELSE
		SET @VP_L_TABLA = 1

	-- //////////////////////////////////////////

	DECLARE @PP_L_APLICAR_MAX_ROWS		INT
	
	SET @PP_L_APLICAR_MAX_ROWS = 0
	
	--DECLARE @VP_LI_N_REGISTROS		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--														@PP_L_APLICAR_MAX_ROWS,
	--														@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- =========================================	

	DECLARE @VP_STR_SQL					NVARCHAR(MAX)

	--IF @PP_L_APLICAR_MAX_ROWS=1 
	--	--SET @VP_STR_SQL = 'SELECT TOP ('+ CONVERT(VARCHAR(100),@VP_LI_N_REGISTROS) +')' 
	--	SET @VP_STR_SQL = 'SELECT TOP (5000)' 
	--ELSE
		SET @VP_STR_SQL = 'SELECT ' 
	
	SET @VP_STR_SQL = @VP_STR_SQL + ' '

	SET @VP_STR_SQL = @VP_STR_SQL +  ' K_'+@PP_NOMBRE_TABLA + ' AS K_CATALOGO'	
	SET @VP_STR_SQL = @VP_STR_SQL + ', D_'+@PP_NOMBRE_TABLA + ' AS D_CATALOGO'

	SET @VP_STR_SQL = @VP_STR_SQL + ', 0 AS O_CATALOGO'	
--	SET @VP_STR_SQL = @VP_STR_SQL + ', 123  AS O_CATALOGO'

	IF @VP_L_BORRADO=1
		SET @VP_STR_SQL = @VP_STR_SQL + ', L_BORRADO AS L_DELETED'
	ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', 0 AS L_DELETED'

	IF @VP_L_TABLA=1
		SET @VP_STR_SQL = @VP_STR_SQL + ', L_'+@PP_NOMBRE_TABLA+' AS L_ACTIVO'		
	ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', 1 AS L_ACTIVO'		

	SET @VP_STR_SQL = @VP_STR_SQL + ' '		
	SET @VP_STR_SQL = @VP_STR_SQL + 'FROM ' + @PP_NOMBRE_TABLA  	

	-- ==========================================

	EXECUTE sp_executesql @VP_STR_SQL 

	-- ==========================================
GO



-- /////////////////////////////////////////////////////////////////
-- // CARGA DE COMBO NORMAL - PARA TODAS LAS FORMAS
-- /////////////////////////////////////////////////////////////////
-- [PG_CB_TABLA_N1_Load] 0,0,0, 'COLOR',-1,1
-- [dbo].[PG_CB_TABLA_N1_Load] 0,0010,139, 'STATUS_QUOTE', 0,1

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_TABLA_N1_Load]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_TABLA_N1_Load]
GO


CREATE PROCEDURE [dbo].[PG_CB_TABLA_N1_Load]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==============================
	@PP_NOMBRE_TABLA			VARCHAR(255),
	-- ==============================
	@PP_L_CON_TODOS				INT,
	@PP_L_USAR_ORDEN			INT
AS

	--DECLARE @VP_INT_SHOW_K		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_COMBO_SHOW_K_GET]		--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--															@OU_SHOW_K = @VP_INT_SHOW_K			OUTPUT
	-- ==========================================
		
	CREATE TABLE	#VP_TA_CATALOGO	
					(	TA_K_CATALOGO		INT,
						TA_D_CATALOGO		VARCHAR(200),
						TA_O_CATALOGO		INT,
						TA_L_DELETED		INT,	
						TA_L_ACTIVO			INT			 )

	DECLARE @VP_STR_SQL		NVARCHAR(MAX)

	IF @PP_L_USAR_ORDEN=1
		SET @VP_STR_SQL = 'INSERT INTO #VP_TA_CATALOGO EXEC [dbo].[PG_CB_TABLA_N1_X_ORDEN_Select] 0, '+ '''' +@PP_NOMBRE_TABLA+ '''' 
	ELSE
		SET @VP_STR_SQL = 'INSERT INTO #VP_TA_CATALOGO EXEC [dbo].[PG_CB_TABLA_N1_Select] 0, '+ '''' +@PP_NOMBRE_TABLA+ '''' 
	
	-- ==========================================
									
	EXECUTE sp_executesql @VP_STR_SQL 
	
	-- ==========================================

	IF @PP_L_CON_TODOS=1
		INSERT INTO #VP_TA_CATALOGO
				( TA_K_CATALOGO,	TA_D_CATALOGO,	TA_O_CATALOGO, TA_L_DELETED, TA_L_ACTIVO	)
			VALUES
				( -1,				'( TODOS )',	-999,		   0,			 1				)

	-- ==========================================
	
	--IF @VP_INT_SHOW_K=1
	--	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
	--		  ( (CASE WHEN (TA_L_ACTIVO=1 AND TA_L_DELETED=0) THEN '' ELSE '<X> ' END ) +
	--			TA_D_CATALOGO ) AS D_COMBOBOX --+ ' [#' + CONVERT(VARCHAR(100), TA_K_CATALOGO) + ']' ) 
								
	--	FROM	#VP_TA_CATALOGO
	--	ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 
	--ELSE
		SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX
		FROM	#VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 

	-- ==========================================

	DROP TABLE #VP_TA_CATALOGO

	-- ==========================================
GO




/****************************************************************/
/*					COMBO DIRECTO DE TABLA						*/
/****************************************************************/

-- EXECUTE [dbo].[PG_CB_TABLA_N2_Load] 1,2004, 'TIPO_MOVIMIENTO_RH', 'CLASE_MOVIMIENTO_RH', 1


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_TABLA_N2_Load]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_TABLA_N2_Load]
GO



CREATE PROCEDURE [dbo].[PG_CB_TABLA_N2_Load]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==============================
	@PP_NOMBRE_TABLA			VARCHAR(255),
	@PP_TABLA_PADRE				VARCHAR(255),
	@PP_K_PADRE					INT,
	-- ==============================
	@PP_L_CON_TODOS				INT,
	@PP_L_USAR_ORDEN			INT
AS

	DECLARE @VP_STR_SQL					NVARCHAR(MAX)
	--DECLARE @VP_INT_SHOW_K				INT

	--DECLARE @VP_LI_N_REGISTROS			INT
	--DECLARE @PP_L_APLICAR_MAX_ROWS		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_COMBO_SHOW_K_GET]		--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--															@OU_SHOW_K = @VP_INT_SHOW_K					OUTPUT	
	-- ==========================================

	--SET @PP_L_APLICAR_MAX_ROWS = 1

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--														@PP_L_APLICAR_MAX_ROWS,
	--														@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- ==========================================
	--	SET @VP_LI_N_REGISTROS = 1000
	--	SELECT * FROM VALOR_PARAMETRO

--	IF @PP_L_DEBUG>0
--		PRINT @VP_LI_N_REGISTROS

	--IF @PP_L_APLICAR_MAX_ROWS=1 
		--SET @VP_STR_SQL = 'SELECT TOP (5000)' 
		--SET @VP_STR_SQL = 'SELECT TOP ('+ CONVERT(VARCHAR(100),@VP_LI_N_REGISTROS) +')' 
	--ELSE
		SET @VP_STR_SQL = 'SELECT ' 
	
	SET @VP_STR_SQL = @VP_STR_SQL + ' '
	SET @VP_STR_SQL = @VP_STR_SQL + ' K_'+@PP_NOMBRE_TABLA + ' AS K_COMBOBOX'
	
	--IF @VP_INT_SHOW_K=1
	--	SET @VP_STR_SQL = @VP_STR_SQL + ', (D_'+@PP_NOMBRE_TABLA + '+' + '''' + ' [#' + '''' + ' + CONVERT(VARCHAR(100), K_'+@PP_NOMBRE_TABLA+')+' + '''' + ']' + '''' + ') AS D_COMBOBOX'
	--ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', D_'+@PP_NOMBRE_TABLA + ' AS D_COMBOBOX'
	
	SET @VP_STR_SQL = @VP_STR_SQL + ' '		
	SET @VP_STR_SQL = @VP_STR_SQL + 'FROM ' + @PP_NOMBRE_TABLA 

	SET @VP_STR_SQL = @VP_STR_SQL + ' '		
	SET @VP_STR_SQL = @VP_STR_SQL + 'WHERE K_' + @PP_TABLA_PADRE + '=' + CONVERT(VARCHAR(100),@PP_K_PADRE)

	SET @VP_STR_SQL = @VP_STR_SQL + ' '			
	SET @VP_STR_SQL = @VP_STR_SQL + 'ORDER BY D_'+@PP_NOMBRE_TABLA + ''

	-- ==========================================	
	--SELECT @VP_STR_SQL AS 'SQL'
	EXECUTE sp_executesql @VP_STR_SQL 

	-- ==========================================
GO



-- /////////////////////////////////////////////////////////////////
-- // CARGA DE COMBO ESPECIAL PARA LOS USUARIOS DE LA BD DATA_02 DE PEARL_SYSTEM
-- /////////////////////////////////////////////////////////////////

-- EXECUTE [dbo].[PG_CB_USERS_PEARL_Load] 0, 0, 0, 0



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_USERS_PEARL_Load]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_USERS_PEARL_Load]
GO


CREATE PROCEDURE [dbo].[PG_CB_USERS_PEARL_Load]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ======================================
	@PP_L_CON_TODOS				INT
AS

	--DECLARE @VP_INT_SHOW_K		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_COMBO_SHOW_K_GET]		--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--															@OU_SHOW_K = @VP_INT_SHOW_K			OUTPUT
	-- ==========================================
	
	CREATE TABLE	#VP_TA_CATALOGO		
					(	TA_K_CATALOGO		INT,
						TA_O_CATALOGO		INT,
					-- =========================
						D_CATALOGO			VARCHAR(200)
					)

	-- ==========================================

			INSERT INTO #VP_TA_CATALOGO 
			(		TA_K_CATALOGO, TA_O_CATALOGO,
				-- =========================
					[D_CATALOGO]
			)
			SELECT	CODIGO, 10,
				-- =========================
					usuario
			FROM	[DATA_02].[dbo].[USERS_PEARL]
			--WHERE	USERS_PEARL.L_BORRADO=0

	-- ==========================================
	

	IF @PP_L_CON_TODOS=1
		INSERT INTO #VP_TA_CATALOGO
				(	TA_K_CATALOGO,	TA_O_CATALOGO,	
					-- =========================
					[D_CATALOGO]
				)
			VALUES
				(	-1,				-999,		 					
					'(TODOS)'
				)

	-- ==========================================
	
	--SET @VP_INT_SHOW_K = 1

	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
			[D_CATALOGO] 
			--+ ( CASE WHEN @VP_INT_SHOW_K=1 
			--		THEN (' [#'+CONVERT(VARCHAR(100),TA_K_CATALOGO)+'] ') 
			--		ELSE '' END )
							AS D_COMBOBOX
	FROM	#VP_TA_CATALOGO
	ORDER BY	TA_O_CATALOGO,
				[D_CATALOGO] 

	-- ==========================================

	DROP TABLE #VP_TA_CATALOGO

	-- ==========================================
GO


-- ///////////////////////////////////////////////////////////////
-- //AX:	AQUI SE GENERA LA INFORMACIÓN QUE CONTENDRÁ EL COMBO ESPECIAL
--//		PARA MOSTRAR LA VISTA POR SIGLAS.
--//		ESTE PROCEDIMIENTO FUNCIONA CUANDO LA TABLA TIENE EL CAMPO "ORDEN"
-- ///////////////////////////////////////////////////////////////
-- [PG_CB_TABLA_N1_X_ORDEN_Select_SIGLAS] 0, 0, 'CUSTOMER'

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_TABLA_N1_X_ORDEN_Select_SIGLAS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_TABLA_N1_X_ORDEN_Select_SIGLAS]
GO

CREATE PROCEDURE [dbo].[PG_CB_TABLA_N1_X_ORDEN_Select_SIGLAS]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_NOMBRE_TABLA			VARCHAR(255)
AS

	DECLARE @VP_L_BORRADO	INT

	IF  0=(		SELECT	COUNT(*) 
				FROM	INFORMATION_SCHEMA.COLUMNS AS COLUMNAS
				WHERE	COLUMNAS.TABLE_NAME=@PP_NOMBRE_TABLA
				AND		COLUMNAS.COLUMN_NAME='L_BORRADO'		) 
		SET @VP_L_BORRADO = 0
	ELSE
		SET @VP_L_BORRADO = 1

	-- ==========================================

	DECLARE @VP_L_TABLA		INT = 0

	IF  0=(		SELECT	COUNT(*) 
				FROM	INFORMATION_SCHEMA.COLUMNS AS COLUMNAS
				WHERE	COLUMNAS.TABLE_NAME=@PP_NOMBRE_TABLA
				AND		COLUMNAS.COLUMN_NAME='L_'+@PP_NOMBRE_TABLA		) 
		SET @VP_L_TABLA = 0
	ELSE
		SET @VP_L_TABLA = 1

	-- //////////////////////////////////////////

	--DECLARE @PP_L_APLICAR_MAX_ROWS		INT
	
	--SET @PP_L_APLICAR_MAX_ROWS = 0
	
	--DECLARE @VP_LI_N_REGISTROS		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--														@PP_L_APLICAR_MAX_ROWS,
	--														@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- =========================================	

	DECLARE @VP_STR_SQL					NVARCHAR(MAX)

	--IF @PP_L_APLICAR_MAX_ROWS=1 
	--	SET @VP_STR_SQL = 'SELECT TOP ('+ CONVERT(VARCHAR(100),@VP_LI_N_REGISTROS) +')' 
	--ELSE
		SET @VP_STR_SQL = 'SELECT ' 
	
	SET @VP_STR_SQL = @VP_STR_SQL + ' '

	SET @VP_STR_SQL = @VP_STR_SQL +  ' K_'+@PP_NOMBRE_TABLA + ' AS K_CATALOGO'	
	SET @VP_STR_SQL = @VP_STR_SQL + ', S_'+@PP_NOMBRE_TABLA + ' AS S_CATALOGO'

	SET @VP_STR_SQL = @VP_STR_SQL + ', O_'+@PP_NOMBRE_TABLA + ' AS O_CATALOGO'	

--	SET @VP_STR_SQL = @VP_STR_SQL + ', 123  AS O_CATALOGO'

	IF @VP_L_BORRADO=1
		SET @VP_STR_SQL = @VP_STR_SQL + ', L_BORRADO AS L_DELETED'
	ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', 0 AS L_DELETED'

	IF @VP_L_TABLA=1
		SET @VP_STR_SQL = @VP_STR_SQL + ', L_'+@PP_NOMBRE_TABLA+' AS L_ACTIVO'		
	ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', 1 AS L_ACTIVO'		

	SET @VP_STR_SQL = @VP_STR_SQL + ' '		
	SET @VP_STR_SQL = @VP_STR_SQL + 'FROM ' + @PP_NOMBRE_TABLA
	
	SET @VP_STR_SQL = @VP_STR_SQL + ' '			
	SET @VP_STR_SQL = @VP_STR_SQL + 'ORDER BY S_'+@PP_NOMBRE_TABLA + ''  	

	-- ==========================================

	EXECUTE sp_executesql @VP_STR_SQL 

	-- ==========================================
GO


-- ///////////////////////////////////////////////////////////////
-- //AX:	AQUI SE GENERA LA INFORMACIÓN QUE CONTENDRÁ EL COMBO ESPECIAL
--//		PARA MOSTRAR LA VISTA POR SIGLAS.
--//		ESTE PROCEDIMIENTO FUNCIONA CUANDO LA TABLA ""NO"" TIENE EL CAMPO "ORDEN"
-- ///////////////////////////////////////////////////////////////
-- [PG_CB_TABLA_N1_Select] 0, 0, 'COLOR'


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_TABLA_N1_Select_SIGLAS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_TABLA_N1_Select_SIGLAS]
GO

CREATE PROCEDURE [dbo].[PG_CB_TABLA_N1_Select_SIGLAS]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_NOMBRE_TABLA			VARCHAR(255)
AS

	DECLARE @VP_L_BORRADO	INT

	IF  0=(		SELECT	COUNT(*) 
				FROM	INFORMATION_SCHEMA.COLUMNS AS COLUMNAS
				WHERE	COLUMNAS.TABLE_NAME=@PP_NOMBRE_TABLA
				AND		COLUMNAS.COLUMN_NAME='L_BORRADO'		) 
		SET @VP_L_BORRADO = 0
	ELSE
		SET @VP_L_BORRADO = 1

	-- ==========================================

	DECLARE @VP_L_TABLA		INT = 0

	IF  0=(		SELECT	COUNT(*) 
				FROM	INFORMATION_SCHEMA.COLUMNS AS COLUMNAS
				WHERE	COLUMNAS.TABLE_NAME=@PP_NOMBRE_TABLA
				AND		COLUMNAS.COLUMN_NAME='L_'+@PP_NOMBRE_TABLA		) 
		SET @VP_L_TABLA = 0
	ELSE
		SET @VP_L_TABLA = 1

	-- //////////////////////////////////////////

	--DECLARE @PP_L_APLICAR_MAX_ROWS		INT
	
	--SET @PP_L_APLICAR_MAX_ROWS = 0
	
	--DECLARE @VP_LI_N_REGISTROS		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--														@PP_L_APLICAR_MAX_ROWS,
	--														@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- =========================================	

	DECLARE @VP_STR_SQL					NVARCHAR(MAX)

	--IF @PP_L_APLICAR_MAX_ROWS=1 
	--	SET @VP_STR_SQL = 'SELECT TOP ('+ CONVERT(VARCHAR(100),@VP_LI_N_REGISTROS) +')' 
	--ELSE
	
	
	SET @VP_STR_SQL = 'SELECT ' 			
	SET @VP_STR_SQL = @VP_STR_SQL + ' '
	SET @VP_STR_SQL = @VP_STR_SQL +  ' K_'+@PP_NOMBRE_TABLA + ' AS K_CATALOGO'	
	SET @VP_STR_SQL = @VP_STR_SQL + ', S_'+@PP_NOMBRE_TABLA + ' AS S_CATALOGO'
	SET @VP_STR_SQL = @VP_STR_SQL + ', 0 AS O_CATALOGO'	

	IF @VP_L_BORRADO=1
		SET @VP_STR_SQL = @VP_STR_SQL + ', L_BORRADO AS L_DELETED'
	ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', 0 AS L_DELETED'
	IF @VP_L_TABLA=1
		SET @VP_STR_SQL = @VP_STR_SQL + ', L_'+@PP_NOMBRE_TABLA+' AS L_ACTIVO'		
	ELSE
		SET @VP_STR_SQL = @VP_STR_SQL + ', 1 AS L_ACTIVO'		

	SET @VP_STR_SQL = @VP_STR_SQL + ' '		
	SET @VP_STR_SQL = @VP_STR_SQL + 'FROM ' + @PP_NOMBRE_TABLA 			
	SET @VP_STR_SQL = @VP_STR_SQL + ' '			
	SET @VP_STR_SQL = @VP_STR_SQL + 'ORDER BY S_'+@PP_NOMBRE_TABLA + ''  	
	
	-- ==========================================

	EXECUTE sp_executesql @VP_STR_SQL 

	-- ==========================================
GO



-- /////////////////////////////////////////////////////////////////
-- // CARGA DE COMBO NORMAL MOSTRANDO LAS SIGLAS EN LA VISTA DEL COMBO
--//AX: 20190918
-- /////////////////////////////////////////////////////////////////
-- [PG_CB_TABLA_N1_Load_SIGLAS] 0,0,0, 'COLOR',-1,1
-- [PG_CB_TABLA_N1_Load_SIGLAS] 0,0,0, 'COLOR',-1,-1
-- [PG_CB_TABLA_N1_Load_SIGLAS] 0,0,0, 'CUSTOMER',1,1


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_TABLA_N1_Load_SIGLAS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_TABLA_N1_Load_SIGLAS]
GO


CREATE PROCEDURE [dbo].[PG_CB_TABLA_N1_Load_SIGLAS]
--	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==============================
	@PP_NOMBRE_TABLA			VARCHAR(255),
	-- ==============================
	@PP_L_CON_TODOS				INT,
	@PP_L_USAR_ORDEN			INT
AS

	--DECLARE @VP_INT_SHOW_K		INT

	--EXECUTE [dbo].[PG_SK_CONFIGURACION_COMBO_SHOW_K_GET]		--@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
	--															@OU_SHOW_K = @VP_INT_SHOW_K			OUTPUT
	-- ==========================================
		
	CREATE TABLE	#VP_TA_CATALOGO	
					(	TA_K_CATALOGO		INT,
						TA_S_CATALOGO		VARCHAR(50),
						TA_O_CATALOGO		INT,
						TA_L_DELETED		INT,	
						TA_L_ACTIVO			INT			 )

	DECLARE @VP_STR_SQL		NVARCHAR(MAX)

	IF @PP_L_USAR_ORDEN=1
		SET @VP_STR_SQL = 'INSERT INTO #VP_TA_CATALOGO EXEC [dbo].[PG_CB_TABLA_N1_X_ORDEN_Select_SIGLAS] 0, '+ 
					'''' +@PP_NOMBRE_TABLA+ ''''
	ELSE
		SET @VP_STR_SQL = 'INSERT INTO #VP_TA_CATALOGO EXEC [dbo].[PG_CB_TABLA_N1_Select_SIGLAS] 0, '+ 
					'''' +@PP_NOMBRE_TABLA+ ''''
						
	-- ==========================================
									
	EXECUTE sp_executesql @VP_STR_SQL 
	
	-- ==========================================

	IF @PP_L_CON_TODOS=1
		INSERT INTO #VP_TA_CATALOGO
				( TA_K_CATALOGO,	TA_S_CATALOGO,	TA_O_CATALOGO, TA_L_DELETED, TA_L_ACTIVO	)
			VALUES
				( -1,				'( TODOS )',	-999,		   0,			 1				)

	-- ==========================================
	
	--IF @VP_INT_SHOW_K=1
	--	SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
	--		  ( (CASE WHEN (TA_L_ACTIVO=1 AND TA_L_DELETED=0) THEN '' ELSE '<X> ' END ) +
	--			TA_S_CATALOGO	)			--+ ' [#' + CONVERT(VARCHAR(100), TA_K_CATALOGO) + ']' ) 
	--							AS D_COMBOBOX
	--	FROM	#VP_TA_CATALOGO
	--	ORDER BY TA_O_CATALOGO, TA_S_CATALOGO 
	--ELSE
		SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_S_CATALOGO	AS S_COMBOBOX 
		FROM	#VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_S_CATALOGO 

	-- ==========================================

	DROP TABLE #VP_TA_CATALOGO

	-- ==========================================
GO




-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
