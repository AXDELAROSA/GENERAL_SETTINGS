-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		BD_GENERAL
-- // MODULE:			SISTEMA
-- // OPERATION:		PROCEDIMIENTOS ESPECIFICOS
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200615
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////	CONTENIDO DEL SP:
--	[PG_LI_SISTEMA_TAG]
--	[PG_LI_SISTEMA_TAG_MENU]
--	[PG_LI_GRUPO_TAG]
--	[PG_SK_SISTEMA_TAG_MENU]
--	[PG_LI_SISTEMA]
--	[PG_LI_SISTEMA_TAG_X_USUARIO]
--	[PG_SK_SISTEMA]
--	[PG_IN_SISTEMA]
--	[PG_INDL_SISTEMA_X_USUARIO_PERMISO]
--	[PG_UP_SISTEMA]
--	[PG_DL_SISTEMA]
-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE USUARIO
-- // ES LA VISTA PARA LAS SECCIONES EN EL MENÚ DE LAS APLICACIONES
-- // DEL SISTEMA DE PEARL.
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_SISTEMA_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_SISTEMA_TAG]
GO
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,00
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,10
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,20
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,30
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,40
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,50		-- ENGINEERING
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,60
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,70
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,80
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG] 0,139, 139,90
CREATE PROCEDURE [dbo].[PG_LI_SISTEMA_TAG]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL				INT,
	@PP_K_GRUPO_TAG					INT
AS
	-- =========================================
	IF	@PP_K_GRUPO_TAG	IN (50)
	BEGIN
		SELECT	DISTINCT
				SISTEMA_TAG.K_GRUPO_TAG,
				SISTEMA_TAG.K_SISTEMA_TAG,
				D_SISTEMA_TAG,
				D_SISTEMA_TAG_MENU,
				O_SISTEMA_TAG
		FROM	SISTEMA_TAG				(NOLOCK)
		WHERE	SISTEMA_TAG.K_GRUPO_TAG	=	@PP_K_GRUPO_TAG
		AND		K_GRUPO_TAG				<>	0
		AND		K_SISTEMA_TAG			<>	0
		AND		L_SISTEMA_TAG			=	1
		AND		L_BORRADO				=	0
		ORDER	BY	K_GRUPO_TAG,	O_SISTEMA_TAG,		K_SISTEMA_TAG
	END
	ELSE
	BEGIN
		SELECT	DISTINCT
				SISTEMA_TAG.K_GRUPO_TAG,
				SISTEMA_TAG.K_SISTEMA_TAG,
				D_SISTEMA_TAG,
				D_SISTEMA_TAG_MENU,
				O_SISTEMA_TAG
		FROM	SISTEMA_TAG				(NOLOCK)
		WHERE	SISTEMA_TAG.K_GRUPO_TAG	=	@PP_K_GRUPO_TAG
		AND		K_GRUPO_TAG				<>	0
		AND		K_SISTEMA_TAG			<>	0
		AND		L_SISTEMA_TAG			=	1
		AND		L_BORRADO				=	0
		ORDER	BY	K_GRUPO_TAG,	K_SISTEMA_TAG
	END
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE MENU_EXPLORER
-- //	PARA CONOCER EL ORDEN POR USUARIO CONSULTAR [PG_LI_USUARIO_PERMISOS_SISTEMA_TAG_MENU]
-- //	EN EL SP DE PERMISOS.
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_SISTEMA_TAG_MENU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_SISTEMA_TAG_MENU]
GO
-- EXECUTE [dbo].[PG_LI_SISTEMA_TAG_MENU] 1,139,87,60
-- EXECUTE [dbo].[PG_LI_SISTEMA_TAG_MENU] 0,139,87,60
-- EXECUTE [dbo].[PG_LI_SISTEMA_TAG_MENU] 0,139,139,50
-- EXECUTE [dbo].[PG_LI_SISTEMA_TAG_MENU] 0,139,139,60
CREATE PROCEDURE [dbo].[PG_LI_SISTEMA_TAG_MENU]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL				INT,
	@PP_K_GRUPO_TAG					INT
AS
	-- =========================================
	--IF	@PP_K_GRUPO_TAG	IN (50)
	--BEGIN
		SELECT DISTINCT		
				SISTEMA_TAG.K_GRUPO_TAG,
				SISTEMA_TAG.K_SISTEMA_TAG,
				CONCAT(D_SISTEMA_TAG,' ',S_SISTEMA_TAG) AS D_SISTEMA_TAG,
				CONCAT(D_SISTEMA_TAG_MENU,' ',S_SISTEMA_TAG) AS D_SISTEMA_TAG_MENU,
				K_IMAGEN_SISTEMA_TAG,
				O_SISTEMA_TAG
		FROM	SISTEMA_TAG				(NOLOCK)
		WHERE	SISTEMA_TAG.K_GRUPO_TAG	=	@PP_K_GRUPO_TAG
		AND		K_GRUPO_TAG				<>	0
		AND		K_SISTEMA_TAG			<>	0
		AND		L_BORRADO				=	0
		ORDER	BY	K_GRUPO_TAG,	O_SISTEMA_TAG,		K_SISTEMA_TAG
	--END
	--ELSE
	--BEGIN
	--	SELECT DISTINCT		
	--			SISTEMA_TAG.K_GRUPO_TAG,
	--			SISTEMA_TAG.K_SISTEMA_TAG,
	--			CONCAT(D_SISTEMA_TAG,' ',S_SISTEMA_TAG) AS D_SISTEMA_TAG,
	--			CONCAT(D_SISTEMA_TAG_MENU,' ',S_SISTEMA_TAG) AS D_SISTEMA_TAG_MENU,
	--			K_IMAGEN_SISTEMA_TAG,
	--			O_SISTEMA_TAG
	--	FROM	SISTEMA_TAG				(NOLOCK)
	--	WHERE	SISTEMA_TAG.K_GRUPO_TAG	=	@PP_K_GRUPO_TAG
	--	AND		K_GRUPO_TAG				<>	0
	--	AND		K_SISTEMA_TAG			<>	0
	--	AND		L_BORRADO				=	0
	--	ORDER	BY	K_GRUPO_TAG,	K_SISTEMA_TAG
	--END
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE USUARIO:
-- //			PARA CARGAR LOS NODOS DE CADA UNA DE LAS SECCIONES.
-- // SE UTILIZA EN LA FORMA DE MENU_EXPLORER:
-- //			
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_GRUPO_TAG]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_GRUPO_TAG]
GO
-- EXECUTE [dbo].[PG_LI_GRUPO_TAG] 0,139,139
-- EXECUTE [dbo].[PG_LI_GRUPO_TAG] 1,139,139
-- EXECUTE [dbo].[PG_LI_GRUPO_TAG] 1,87,87
CREATE PROCEDURE [dbo].[PG_LI_GRUPO_TAG]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_USUARIO_PEARL			INT
AS
	-- =========================================
	IF	@PP_K_SISTEMA_EXE	= 0
	BEGIN
		SELECT	GRUPO_TAG.K_GRUPO_TAG,
				D_GRUPO_TAG
		FROM	GRUPO_TAG		(NOLOCK)
		WHERE	K_GRUPO_TAG		<>	0
		AND		L_BORRADO		=	0
		ORDER	BY	K_GRUPO_TAG
	END
	ELSE
	BEGIN
		SELECT	GRUPO_TAG.K_GRUPO_TAG,
				D_GRUPO_TAG
		FROM	GRUPO_TAG		(NOLOCK)
		WHERE	K_GRUPO_TAG		<>	0
		AND		L_GRUPO_TAG		=	1
		AND		L_BORRADO		=	0
		ORDER	BY	K_GRUPO_TAG
	END
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // MUESTRA LOS USUARIOS QUE TIENEN ACCESO A CADA UNA DE LAS
-- // PANTALLAS DEL SISTEMA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_SISTEMA_TAG_X_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_SISTEMA_TAG_X_USUARIO]
GO
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG_X_USUARIO] 0,139, 0
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG_X_USUARIO] 0,139, 10
--		 EXECUTE [dbo].[PG_LI_SISTEMA_TAG_X_USUARIO] 0,139, 70
CREATE PROCEDURE [dbo].[PG_LI_SISTEMA_TAG_X_USUARIO]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_SISTEMA_TAG				INT
AS
	-- =========================================
	SELECT	USUARIO_PEARL.K_USUARIO_PEARL,
			--@PP_K_SISTEMA_TAG	AS K_SISTEMA_TAG,
			S_DEPARTAMENTO,
			D_USUARIO_PEARL,
			CONCAT(NOMBRE, ' ', APELLIDO_PATERNO) AS NOMBRE_USUARIO,
			(CASE
				WHEN	ISNULL(USUARIO_PERMISOS.K_SISTEMA_TAG,0)	<> 0 THEN	1
				ELSE	0
			END)		AS L_HABILITADO
	FROM	USUARIO_PEARL	(NOLOCK)
	LEFT JOIN	USUARIO_PERMISOS		(NOLOCK) ON USUARIO_PEARL.K_USUARIO_PEARL	= USUARIO_PERMISOS.K_USUARIO_PEARL
	--AND			K_SISTEMA_TAG	IN (SELECT K_SISTEMA_TAG FROM USUARIO_PERMISOS (NOLOCK) WHERE USUARIO_PERMISOS.K_USUARIO_PEARL	= USUARIO_PEARL.K_USUARIO_PEARL)
	AND		K_SISTEMA_TAG	= @PP_K_SISTEMA_TAG
	LEFT JOIN	DEPARTAMENTO		(NOLOCK) ON DEPARTAMENTO.DP_DEPTO_HOWE		= USUARIO_PEARL.K_USUARIO_DEPARTAMENTO
	--LEFT JOIN	SISTEMA_TAG			(NOLOCK) ON SISTEMA_TAG.K_SISTEMA_TAG		= USUARIO_PERMISOS.K_SISTEMA_TAG
	ORDER BY	D_USUARIO_PEARL
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE MENU_EXPLORER
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_SISTEMA_TAG_MENU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_SISTEMA_TAG_MENU]
GO
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,139,004,999
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,139,004,120
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,138,004,999
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,179,002,223
-- EXECUTE [dbo].[PG_SK_SISTEMA_TAG_MENU] 0,179,'PPMS #003',999
CREATE PROCEDURE [dbo].[PG_SK_SISTEMA_TAG_MENU]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_SISTEMA					VARCHAR(100),
	@PP_VERSION						INT
AS
	DECLARE @PP_K_SISTEMA	INT
	SET		@PP_K_SISTEMA = RIGHT(@PP_D_SISTEMA,3)
	
	IF @PP_VERSION < 999
		BEGIN
			SELECT		SISTEMA_TAG.K_SISTEMA_TAG,
						D_SISTEMA_TAG	AS D_FORMA,
						R_SISTEMA_TAG	AS RUTA_FORMA,
						L_ARCHIVO_TAG	AS TIPO_FORMA 
			FROM		SISTEMA_TAG			(NOLOCK) 
			LEFT JOIN	USUARIO_PERMISOS	(NOLOCK) ON SISTEMA_TAG.K_SISTEMA_TAG=USUARIO_PERMISOS.K_SISTEMA_TAG
			LEFT JOIN	USUARIO_PEARL		(NOLOCK) ON USUARIO_PERMISOS.K_USUARIO_PEARL=USUARIO_PEARL.K_USUARIO_PEARL
			WHERE		SISTEMA_TAG.K_SISTEMA_TAG		=	@PP_K_SISTEMA
			AND			USUARIO_PEARL.K_USUARIO_PEARL	=	@PP_K_USUARIO_ACCION
			AND			L_SISTEMA_TAG					<>	0
			AND			SISTEMA_TAG.L_BORRADO			=	0
		END
	ELSE
		BEGIN
			SELECT		SISTEMA_TAG.K_SISTEMA_TAG,
						D_SISTEMA_TAG	AS D_FORMA,
						R_SISTEMA_TAG	AS RUTA_FORMA,
						L_ARCHIVO_TAG	AS TIPO_FORMA 
			FROM		SISTEMA_TAG			(NOLOCK)
			WHERE		SISTEMA_TAG.K_SISTEMA_TAG	=	@PP_K_SISTEMA
			AND			SISTEMA_TAG.L_BORRADO		=	0
		END
	-- /////////////////////////////////////////////////////////////////////
GO
--SELECT LEFT('PPMS #001',LEN(D_SISTEMA_TAG)-3)
--SELECT LEN(D_SISTEMA_TAG) FROM SISTEMA_TAG
--SELECT RIGHT('PPMS #013',3)

-- //////////////////////////////////////////////////////////////
-- /// LOS SP DE LA PARTE ALTA CORRESPONDE A LOS PERMISOS DE 
-- /// USUARIOS, DE AQUI HACIA ABAJO SON DE LA FORMA DE SISTEMA
-- /// PARA DAR DE ALTA LAS NUEVAS FORMAS EN LA BD Y EN EL
-- /// MENÚ EXPLORER.	( #ALTAFORMAS )
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- // SE UTILIZA EN LA FORMA DE SISTEMA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_SISTEMA]
GO
--	execute [dbo].[PG_LI_SISTEMA] 0,139,''
CREATE PROCEDURE [dbo].[PG_LI_SISTEMA]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ==============================================
	@PP_BUSCAR							VARCHAR(200)
	-- ==============================================
AS
	DECLARE @VP_MENSAJE					VARCHAR(300) = ''
	DECLARE @VP_L_APLICAR_MAX_ROWS		INT = 0
	-- ///////////////////////////////////////////
	SELECT	TOP (1000)
			-- =====================
			K_SISTEMA_TAG,
			D_SISTEMA_TAG_MENU,			D_SISTEMA_TAG,
			R_SISTEMA_TAG,				C_SISTEMA_TAG,
			S_GRUPO_TAG,				K_IMAGEN_SISTEMA_TAG,
			O_SISTEMA_TAG,
			(	CASE
				WHEN	L_SISTEMA_TAG=0		THEN	'NO'
				WHEN	L_SISTEMA_TAG>=1	THEN	'SI'
			END ) AS L_SISTEMA_TAG
			-- =====================
	FROM	SISTEMA_TAG		(NOLOCK),	GRUPO_TAG	(NOLOCK)
			-- =====================
	WHERE	SISTEMA_TAG.K_GRUPO_TAG=GRUPO_TAG.K_GRUPO_TAG
			-- =====================
	AND		( SISTEMA_TAG.L_BORRADO=0 )
			-- =====================		
	-- COMENTADO PARA PRUEBAS
	AND		( K_SISTEMA_TAG > 0 )
	ORDER BY GRUPO_TAG.K_GRUPO_TAG ASC,	O_SISTEMA_TAG ASC,	D_SISTEMA_TAG_MENU DESC
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_SISTEMA]
GO
-- EXECUTE [dbo].[PG_SK_SISTEMA] 0,139,21
-- EXECUTE [dbo].[PG_SK_SISTEMA] 0,139,69
CREATE PROCEDURE [dbo].[PG_SK_SISTEMA]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_SISTEMA						INT
AS
	-- =========================================
	SELECT	TOP (1)
			-- =====================
				K_SISTEMA_TAG,
				D_SISTEMA_TAG_MENU,			D_SISTEMA_TAG,
				R_SISTEMA_TAG,				C_SISTEMA_TAG,
				L_ARCHIVO_TAG,				L_SISTEMA_TAG,
				GRUPO_TAG.K_GRUPO_TAG,		S_GRUPO_TAG,
				K_IMAGEN_SISTEMA_TAG,
				O_SISTEMA_TAG
			-- =====================
	FROM	SISTEMA_TAG		(NOLOCK),	GRUPO_TAG	(NOLOCK)
			-- =====================
	WHERE		SISTEMA_TAG.K_GRUPO_TAG=GRUPO_TAG.K_GRUPO_TAG
			-- =====================
	AND		( SISTEMA_TAG.L_BORRADO=0 )
			-- =====================
	AND		( K_SISTEMA_TAG > 0 )
	AND		K_SISTEMA_TAG=@PP_K_SISTEMA
	--ORDER BY GRUPO_TAG.K_GRUPO_TAG ASC,D_SISTEMA_TAG_MENU DESC
	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_SISTEMA]
GO
CREATE PROCEDURE [dbo].[PG_IN_SISTEMA]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_SISTEMA_TAG_MENU			VARCHAR(100),
	@PP_D_SISTEMA_TAG				VARCHAR(100),
	@PP_C_SISTEMA_TAG				VARCHAR(255),
	@PP_R_SISTEMA_TAG				VARCHAR(255),
	-- ===============================
	@PP_K_GRUPO_TAG					INT,
	@PP_L_ARCHIVO_TAG				INT,
	@PP_L_SISTEMA_TAG				INT,
	@PP_K_IMAGEN_SISTEMA_TAG		INT,
	-- ===============================
	@PP_O_SISTEMA_TAG				INT

AS			
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- /////////////////////////////////////////////////////////////////////	
	DECLARE @VP_K_SISTEMA		INT = 0	
	EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_K_SISTEMA_EXE, 'BD_GENERAL',
												'SISTEMA_TAG', 'K_SISTEMA_TAG',
												@OU_K_TABLA_DISPONIBLE = @VP_K_SISTEMA			OUTPUT
	-- ==================================
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_SISTEMA_TAG_INSERT]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@VP_K_SISTEMA,
													@PP_D_SISTEMA_TAG, @PP_D_SISTEMA_TAG_MENU,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT															
	-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
	BEGIN
		DECLARE @VP_SIGLAS VARCHAR(10)
		SET @VP_SIGLAS = '#'+RIGHT('000' + Ltrim(Rtrim(@VP_K_SISTEMA)),3)
		INSERT INTO SISTEMA_TAG
			(	K_SISTEMA_TAG,			
				D_SISTEMA_TAG,			D_SISTEMA_TAG_MENU, 
				S_SISTEMA_TAG,			O_SISTEMA_TAG,
				C_SISTEMA_TAG,			R_SISTEMA_TAG,
				L_SISTEMA_TAG,			K_GRUPO_TAG	,
				L_ARCHIVO_TAG,			K_IMAGEN_SISTEMA_TAG,
				-- =============================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@VP_K_SISTEMA,		
				@PP_D_SISTEMA_TAG,		@PP_D_SISTEMA_TAG_MENU,	
				@VP_SIGLAS,				@PP_O_SISTEMA_TAG,
				@PP_C_SISTEMA_TAG,		@PP_R_SISTEMA_TAG,
				@PP_L_SISTEMA_TAG,		@PP_K_GRUPO_TAG	,
				@PP_L_ARCHIVO_TAG,		@PP_K_IMAGEN_SISTEMA_TAG,
				-- =============================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )

		IF @@ROWCOUNT = 0
		BEGIN
			SET @VP_MENSAJE	= 'No se ingreso el permiso, verifique...'
		END
	END
	IF @VP_MENSAJE	= ''
	BEGIN
		INSERT INTO	USUARIO_PERMISOS
		(	K_SISTEMA_TAG,		K_USUARIO_PEARL		)
		SELECT	@VP_K_SISTEMA,
				K_USUARIO_PEARL
		FROM	USUARIO_PEARL		(NOLOCK)
		WHERE	K_USUARIO_PEARL	IN (41, 139, 144)
		IF @@ROWCOUNT = 0
		BEGIN
			RAISERROR ('No se ingreso el permiso, verifique...', 16, 1 ) 
		END
	END
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
		BEGIN		
		SET		@VP_MENSAJE = 'No es posible insertar el [SISTEMA]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIS.'+CONVERT(VARCHAR(10),@VP_K_SISTEMA)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_SISTEMA AS CLAVE	
	-- //////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'INSERT',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_IN_SISTEMA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@VP_K_SISTEMA, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													--0, 0, @PP_C_SISTEMA, '', 0.00, 0.00,
													0, 0, '', @VP_MENSAJE, 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '@VP_MENSAJE', '', ''
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_INDL_SISTEMA_X_USUARIO_PERMISO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_INDL_SISTEMA_X_USUARIO_PERMISO]
GO
--		 EXECUTE [dbo].[PG_INDL_SISTEMA_X_USUARIO_PERMISO]	1,139, 182,87,0
CREATE PROCEDURE [dbo].[PG_INDL_SISTEMA_X_USUARIO_PERMISO]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_USUARIO_PEARL				INT,
	@PP_K_SISTEMA_TAG				INT,
	-- ===============================
	@PP_L_HABILITAR_PERMISO			INT

AS			
	DECLARE @VP_MENSAJE				NVARCHAR(MAX) = ''
BEGIN TRANSACTION 
BEGIN TRY

	IF @PP_L_HABILITAR_PERMISO	IN (0)
	BEGIN
		IF	(	SELECT	COUNT(K_USUARIO_PEARL)
				FROM	USUARIO_PERMISOS	(NOLOCK)
				WHERE	K_SISTEMA_TAG		= @PP_K_SISTEMA_TAG
				AND		K_USUARIO_PEARL		= @PP_K_USUARIO_PEARL	)	> 0
		BEGIN
			DELETE	FROM	USUARIO_PERMISOS
			WHERE	K_SISTEMA_TAG		= @PP_K_SISTEMA_TAG
			AND		K_USUARIO_PEARL		= @PP_K_USUARIO_PEARL
		END
		ELSE
		BEGIN
			RAISERROR('El registro ya fue eliminado desde otra instancia, verifique...', 16, 1 )
		END
	END
	ELSE
	BEGIN
		IF	(	SELECT	COUNT(K_USUARIO_PEARL)
				FROM	USUARIO_PERMISOS	(NOLOCK)
				WHERE	K_SISTEMA_TAG		= @PP_K_SISTEMA_TAG
				AND		K_USUARIO_PEARL		= @PP_K_USUARIO_PEARL	)	> 0
		BEGIN
			RAISERROR('El usuario ya tiene habilitada la FORMA, verifique...', 16, 1 )
		END
		ELSE
		BEGIN
			INSERT INTO	USUARIO_PERMISOS
			(	K_SISTEMA_TAG,		K_USUARIO_PEARL		)
			VALUES
			(	@PP_K_SISTEMA_TAG,	@PP_K_USUARIO_PEARL	)
			IF @@ROWCOUNT = 0
			BEGIN
				RAISERROR ('No se ingreso el permiso, verifique...', 16, 1 ) 
			END
		END
	END

COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	--	OCURRIÓ UN ERROR, DESHACEMOS LOS CAMBIOS
	ROLLBACK TRANSACTION
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR: // ' + @ErrorMessage
END CATCH
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
		BEGIN
			SET		@VP_MENSAJE = 'No es posible insertar el registro: ' + @VP_MENSAJE 
		END	

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_SISTEMA_TAG AS SISTEMA, @PP_K_USUARIO_PEARL AS CLAVE	
	-- //////////////////////////////////////////////////////////////
	-- //////////////////////////////////////////////////////////////
GO	

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_SISTEMA]
GO
CREATE PROCEDURE [dbo].[PG_UP_SISTEMA]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ========================================
	@PP_K_SISTEMA_TAG				INT,
	@PP_D_SISTEMA_TAG_MENU			VARCHAR(100),
	@PP_D_SISTEMA_TAG				VARCHAR(100),
	@PP_C_SISTEMA_TAG				VARCHAR(255),
	@PP_R_SISTEMA_TAG				VARCHAR(255),
	-- ===============================
	@PP_K_GRUPO_TAG					INT,
	@PP_L_ARCHIVO_TAG				INT,
	@PP_L_SISTEMA_TAG				INT,
	@PP_K_IMAGEN_SISTEMA_TAG		INT,
	-- ===============================
	@PP_O_SISTEMA_TAG				INT
AS			
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_SISTEMA_TAG_UPDATE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_SISTEMA_TAG, 
													@PP_D_SISTEMA_TAG, @PP_D_SISTEMA_TAG_MENU,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE=''
		BEGIN
		UPDATE	SISTEMA_TAG
		SET		
				[D_SISTEMA_TAG]				= @PP_D_SISTEMA_TAG,
				[D_SISTEMA_TAG_MENU]		= @PP_D_SISTEMA_TAG_MENU,	
				[C_SISTEMA_TAG]				= @PP_C_SISTEMA_TAG,
				[R_SISTEMA_TAG]				= @PP_R_SISTEMA_TAG,
				[O_SISTEMA_TAG]				= @PP_O_SISTEMA_TAG,
				[K_GRUPO_TAG]				= @PP_K_GRUPO_TAG,
				[L_ARCHIVO_TAG]				= @PP_L_ARCHIVO_TAG,
				[L_SISTEMA_TAG]				= @PP_L_SISTEMA_TAG,
				[K_IMAGEN_SISTEMA_TAG]		= @PP_K_IMAGEN_SISTEMA_TAG,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG
		END			
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
		BEGIN		
		SET		@VP_MENSAJE = 'No es posible actualizar el [SISTEMA]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIS.'+CONVERT(VARCHAR(10),@PP_K_SISTEMA_TAG)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'		
		END	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_SISTEMA_TAG AS CLAVE
	-- //////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
													@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'UPDATE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_UP_SISTEMA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_SISTEMA_TAG, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													--0, 0, @PP_C_SISTEMA, '', 0.00, 0.00,
													0, 0, '', @VP_MENSAJE, 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '@VP_MENSAJE', '', ''
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_SISTEMA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_SISTEMA]
GO
CREATE PROCEDURE [dbo].[PG_DL_SISTEMA]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_SISTEMA_TAG			INT
AS
	DECLARE @VP_MENSAJE		VARCHAR(300) = ''
	-- //////////////////////////////////////////////	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_SISTEMA_TAG_DELETE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_SISTEMA_TAG, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- //////////////////////////////////////////////	
	IF @VP_MENSAJE=''
		BEGIN
		UPDATE	SISTEMA_TAG
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_SISTEMA_TAG=@PP_K_SISTEMA_TAG
		END
	-- /////////////////////////////////////////////////////////////////////	
	IF @VP_MENSAJE<>''
		BEGIN		
		SET		@VP_MENSAJE = 'No es posible borrar el [SISTEMA]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIS.'+CONVERT(VARCHAR(10),@PP_K_SISTEMA_TAG)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		END	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_SISTEMA_TAG AS CLAVE
	-- /////////////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	--  @PP_L_DEBUG, 
													@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'DELETE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_DL_SISTEMA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_SISTEMA_TAG, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''
	-- /////////////////////////////////////////////////////////////////////
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////