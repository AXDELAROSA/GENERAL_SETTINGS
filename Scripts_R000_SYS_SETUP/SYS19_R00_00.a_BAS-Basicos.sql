-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		ALL
-- // MODULE:			BASICOS
-- // OPERATION:		SP
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20190903
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO


-- //////////////////////////////////////////////////////////////


--	DECLARE @VP_INT_N_RENGLON INT
--	EXECUTE [dbo].[PG_SK_CATALOGO_N_CONSECUTIVO_MAX_GET] 01,
--													'QUOTE_PATTERN',
--													'K_QUOTE_PATTERN',3,
--													'O_QUOTE_KIT',
--													@OU_N_CONSECUTIVO = @VP_INT_N_RENGLON		OUTPUT
													
--													SELECT @VP_INT_N_RENGLON							
													

-- //////////////////////////////////////////////////////////////
-- // [SUB_SK_CATALOGO_N_CONSECUTIVO_MAX_GET]
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_CATALOGO_N_CONSECUTIVO_MAX_GET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_CATALOGO_N_CONSECUTIVO_MAX_GET]
GO
CREATE PROCEDURE [dbo].[PG_SK_CATALOGO_N_CONSECUTIVO_MAX_GET]
	@PP_K_SISTEMA_EXE		INT,
	@PP_NOMBRE_TABLA		VARCHAR(255),
	@PP_CAMPO_AGRUPADOR		VARCHAR(255),
	@PP_K_AGRUPADOR			INT,
	@PP_CAMPO_MAX			VARCHAR(255),
	@OU_N_CONSECUTIVO		INT		OUTPUT
AS
	DECLARE @VP_SQL		NVARCHAR(MAX)
	SET		@VP_SQL =	'SELECT' 
	SET		@VP_SQL =	@VP_SQL + ' '
	SET		@VP_SQL =	@VP_SQL + '  @OU_K_TABLA_MAX_SQL = MAX('+@PP_CAMPO_MAX + ')'
	SET		@VP_SQL =	@VP_SQL + ' '
	SET		@VP_SQL =	@VP_SQL + 'FROM '  + @PP_NOMBRE_TABLA + ' '
	SET		@VP_SQL =	@VP_SQL + 'WHERE ' + @PP_CAMPO_AGRUPADOR + '=' + CONVERT(VARCHAR(50),@PP_K_AGRUPADOR)+' '
	-- ===============================
	DECLARE @VP_DEFINICION_PARAMETROS		NVARCHAR(500)	
	SET		@VP_DEFINICION_PARAMETROS =		N'@OU_K_TABLA_MAX_SQL INT OUTPUT'
	-- ===============================
	DECLARE @VP_K_TABLA_MAX			INT		
	DECLARE @VP_K_TABLA_SIGUIENTE	INT			
	EXECUTE sp_executesql	@VP_SQL, @VP_DEFINICION_PARAMETROS, 
							@OU_K_TABLA_MAX_SQL = @VP_K_TABLA_MAX		OUTPUT
	-- =============================== 
	IF @VP_K_TABLA_MAX IS NULL 
		SET @VP_K_TABLA_SIGUIENTE = 1
	ELSE
		SET @VP_K_TABLA_SIGUIENTE = ( @VP_K_TABLA_MAX + 1 )	
	-- ===============================
	SET @OU_N_CONSECUTIVO = @VP_K_TABLA_SIGUIENTE
	-- ===============================
GO


CREATE PROCEDURE [dbo].[PG_SK_CATALOGO_K_MAX_GET]
	@PP_K_SISTEMA_EXE			INT,
	@PP_NOMBRE_BD				VARCHAR(100),
	@PP_NOMBRE_TABLA			VARCHAR(100),
	@PP_NOMBRE_CAMPO			VARCHAR(255),
	@OU_K_TABLA_DISPONIBLE		INT OUTPUT
AS
	DECLARE @VP_K_TABLA_MAX				INT		
	DECLARE @VP_K_TABLA_SIGUIENTE		INT			
	DECLARE @VP_SQL						NVARCHAR(MAX)
	DECLARE @VP_DEFINICION_PARAMETROS	NVARCHAR(500)	
	-- ===============================
	SET @VP_SQL = 'SELECT' 
	SET @VP_SQL = @VP_SQL + ' '
	SET @VP_SQL = @VP_SQL + '  @OU_K_TABLA_MAX_SQL = MAX('+ @PP_NOMBRE_CAMPO + ')'
	SET @VP_SQL = @VP_SQL + ' '
	SET @VP_SQL = @VP_SQL + 'FROM ' + @PP_NOMBRE_BD+'.dbo.'+ @PP_NOMBRE_TABLA 
	
	SET @VP_DEFINICION_PARAMETROS = N'@OU_K_TABLA_MAX_SQL INT OUTPUT'	
	-- ===============================

	EXECUTE sp_executesql	@VP_SQL, @VP_DEFINICION_PARAMETROS, 
							@OU_K_TABLA_MAX_SQL = @VP_K_TABLA_MAX		OUTPUT	
	-- =============================== 

	IF @VP_K_TABLA_MAX IS NULL 
		SET @VP_K_TABLA_SIGUIENTE = 1
	ELSE
		SET @VP_K_TABLA_SIGUIENTE = ( @VP_K_TABLA_MAX + 1 )

	SET @OU_K_TABLA_DISPONIBLE = @VP_K_TABLA_SIGUIENTE
GO


-- //////////////////////////////////////////////////////////////
-- // [PG_RN_DATA_VER_BORRADOS] VER ELEMENTOS ELIMINADOS EN LISTADOS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_DATA_VER_BORRADOS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_DATA_VER_BORRADOS]
GO

CREATE PROCEDURE [dbo].[PG_RN_DATA_VER_BORRADOS]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@OU_L_VER_BORRADOS					[INT]		OUTPUT
AS	
	DECLARE	@VP_L_VER_BORRADOS		INT 

	IF @PP_K_USUARIO_ACCION IN (139)
		SET @VP_L_VER_BORRADOS = 1
	ELSE
		SET @VP_L_VER_BORRADOS = 0	
	-- ===========================
	SET @OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS
	-- /////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / ID
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]
GO


CREATE PROCEDURE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]
	@PP_REFERENCIA			VARCHAR(100),
	@OU_K_ELEMENTO			INT		OUTPUT
AS

	DECLARE @VP_TEXTO			VARCHAR(100)

	SET @VP_TEXTO = REPLACE(@PP_REFERENCIA,'+','')

	SET @VP_TEXTO = REPLACE(@VP_TEXTO,'-','')
	SET @VP_TEXTO = REPLACE(@VP_TEXTO,'.','')
	SET @VP_TEXTO = REPLACE(@VP_TEXTO,',','')
	SET @VP_TEXTO = REPLACE(@VP_TEXTO,'$','')
	SET @VP_TEXTO = REPLACE(@VP_TEXTO,'¢','')
	SET @VP_TEXTO = REPLACE(@VP_TEXTO,'€','')

	-- =============================================

	DECLARE @VP_K_ELEMENTO_TEMPORAL	INT

	SET @VP_K_ELEMENTO_TEMPORAL = -1

	-- =============================================

	IF LEN(@VP_TEXTO)=1
		BEGIN
		IF 0 = CHARINDEX ( @VP_TEXTO , '+-.$¢€' )
			IF ISNUMERIC(@VP_TEXTO)=1 
				SET @VP_K_ELEMENTO_TEMPORAL = CONVERT(INT, FLOOR( LEFT(@VP_TEXTO,9) ))
		END
	ELSE
		IF ISNUMERIC(@VP_TEXTO)=1 
			SET @VP_K_ELEMENTO_TEMPORAL = CONVERT(INT, FLOOR( LEFT(@VP_TEXTO,9) ))
	
	-- =============================================

	SET @OU_K_ELEMENTO = @VP_K_ELEMENTO_TEMPORAL

GO



-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
