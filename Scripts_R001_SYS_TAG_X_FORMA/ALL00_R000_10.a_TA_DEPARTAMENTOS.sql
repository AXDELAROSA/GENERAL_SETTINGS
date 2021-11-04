-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		ALL
-- // MODULE:			DEPARTAMENTOS SISTEMA
-- // OPERATION:		SP
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210805
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DEPARTAMENTO]') AND type in (N'U'))
	DROP TABLE [dbo].[DEPARTAMENTO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_DEPARTAMENTO]') AND type in (N'U'))
	DROP TABLE [dbo].[CLASE_DEPARTAMENTO]
GO


-- //////////////////////////////////////////////////////////////
-- SELECT * FROM CLASE_DEPARTAMENTO
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[CLASE_DEPARTAMENTO] (
	[K_CLASE_DEPARTAMENTO]		[INT] NOT NULL,
	-- ========================================
	[K_DEPARTAMENTO]			[INT] NOT NULL,
	[D_CLASE_DEPARTAMENTO]		[VARCHAR] (250) NOT NULL,
	[S_CLASE_DEPARTAMENTO]		[VARCHAR] (250) NOT NULL,
	[L_CLASE_DEPARTAMENTO]		[INT] NOT NULL DEFAULT 1,
	-- ========================================
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[CLASE_DEPARTAMENTO]
	ADD CONSTRAINT [PK_CLASE_DEPARTAMENTO]
		PRIMARY KEY CLUSTERED ([K_CLASE_DEPARTAMENTO])
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLASE_DEPARTAMENTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLASE_DEPARTAMENTO]
GO
CREATE PROCEDURE [dbo].[PG_CI_CLASE_DEPARTAMENTO]
	@PP_K_USUARIO_EXE			[INT],
	-- ========================================
	@PP_K_CLASE_DEPARTAMENTO	[INT],
	@PP_K_DEPARTAMENTO			[INT],
	@PP_D_CLASE_DEPARTAMENTO	[VARCHAR](250),
	@PP_S_CLASE_DEPARTAMENTO	[VARCHAR](250),
	@PP_L_CLASE_DEPARTAMENTO	[INT]
	-- ===============================
AS
	-- ===============================
	DECLARE @VP_K_EXISTE	INT
	SELECT	@VP_K_EXISTE			=	K_CLASE_DEPARTAMENTO
	FROM	CLASE_DEPARTAMENTO		(NOLOCK)
	WHERE	K_CLASE_DEPARTAMENTO	=	@PP_K_CLASE_DEPARTAMENTO
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO CLASE_DEPARTAMENTO
			(	K_CLASE_DEPARTAMENTO,			K_DEPARTAMENTO,
				D_CLASE_DEPARTAMENTO,			S_CLASE_DEPARTAMENTO,			
				L_CLASE_DEPARTAMENTO			)
		VALUES	
			(	@PP_K_CLASE_DEPARTAMENTO,		@PP_K_DEPARTAMENTO,
				@PP_D_CLASE_DEPARTAMENTO,		@PP_S_CLASE_DEPARTAMENTO,		
				@PP_L_CLASE_DEPARTAMENTO		)
	ELSE
		UPDATE	CLASE_DEPARTAMENTO
		SET		K_DEPARTAMENTO				= @PP_K_DEPARTAMENTO,
				D_CLASE_DEPARTAMENTO		= @PP_D_CLASE_DEPARTAMENTO,
				S_CLASE_DEPARTAMENTO		= @PP_S_CLASE_DEPARTAMENTO,
				L_CLASE_DEPARTAMENTO		= @PP_L_CLASE_DEPARTAMENTO
		WHERE	K_CLASE_DEPARTAMENTO		= @PP_K_CLASE_DEPARTAMENTO
	-- =========================================================
GO


SET NOCOUNT ON
-- ===============================================
-- ===============================================
EXECUTE [dbo].[PG_CI_CLASE_DEPARTAMENTO] 139	,00		,00		,'( SIN DEFINIR )'	,	'( SIN DEFINIR )'		,1
EXECUTE [dbo].[PG_CI_CLASE_DEPARTAMENTO] 139	,01		,05		,'INGENIERÍA'		,	'INGEN'					,1
EXECUTE [dbo].[PG_CI_CLASE_DEPARTAMENTO] 139	,02		,05		,'MANTENIMIENTO'	,	'MANTO'					,1
-- ===============================================
GO


-- //////////////////////////////////////////////////////////////
-- SELECT * FROM DEPARTAMENTO
-- //////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[DEPARTAMENTO] (
	[K_DEPARTAMENTO]			[INT] IDENTITY (1,1)	NOT NULL,
	-- ========================================
	[DP_DEPTO_HOWE]				[INT] NOT NULL,
	[D_DEPARTAMENTO]			[VARCHAR] (250) NOT NULL,
	[S_DEPARTAMENTO]			[VARCHAR] (250) NOT NULL,
	[O_DEPARTAMENTO]			[INT] NOT NULL DEFAULT 0,
	[C_DEPARTAMENTO]			[VARCHAR] (255) NOT NULL DEFAULT '',
	[L_DEPARTAMENTO]			[INT] NOT NULL DEFAULT 1,
	-- ========================================
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[DEPARTAMENTO]
	ADD CONSTRAINT [PK_DEPARTAMENTO]
		PRIMARY KEY CLUSTERED ([K_DEPARTAMENTO])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_DEPARTAMENTO_01_DESCRIPCION] 
	   ON [dbo].[DEPARTAMENTO] ( [D_DEPARTAMENTO] )
GO

ALTER TABLE [dbo].[DEPARTAMENTO]
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL DEFAULT 139,
			[F_ALTA]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL DEFAULT 139,
			[F_CAMBIO]						[DATETIME]	NOT NULL DEFAULT GETDATE(),
			[L_BORRADO]						[INT]		NOT NULL DEFAULT 0,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_DEPARTAMENTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_DEPARTAMENTO]
GO
CREATE PROCEDURE [dbo].[PG_CI_DEPARTAMENTO]
	@PP_K_USUARIO_EXE			[INT],
	-- ========================================
	@PP_DP_DEPTO_HOWE			[INT],
	@PP_D_DEPARTAMENTO			[VARCHAR](250),
	@PP_S_DEPARTAMENTO			[VARCHAR](250),
	@PP_O_DEPARTAMENTO			[INT],
	@PP_C_DEPARTAMENTO			[VARCHAR](255),
	@PP_L_DEPARTAMENTO			[INT]
	-- ===============================
AS
	-- ===============================
	DECLARE @VP_K_EXISTE	INT
	SELECT	@VP_K_EXISTE	=	K_DEPARTAMENTO
	FROM	DEPARTAMENTO	(NOLOCK)
	WHERE	DP_DEPTO_HOWE	=	@PP_DP_DEPTO_HOWE
	-- ===============================
	IF @VP_K_EXISTE IS NULL
		INSERT INTO DEPARTAMENTO
			(	DP_DEPTO_HOWE,			
				D_DEPARTAMENTO,			S_DEPARTAMENTO,			
				O_DEPARTAMENTO,			C_DEPARTAMENTO,
				L_DEPARTAMENTO			)
		VALUES	
			(	@PP_DP_DEPTO_HOWE,		
				@PP_D_DEPARTAMENTO,		@PP_S_DEPARTAMENTO,		
				@PP_O_DEPARTAMENTO,		@PP_C_DEPARTAMENTO,
				@PP_L_DEPARTAMENTO		)
	ELSE
		UPDATE	DEPARTAMENTO
		SET		DP_DEPTO_HOWE		= @PP_DP_DEPTO_HOWE,
				D_DEPARTAMENTO		= @PP_D_DEPARTAMENTO,	
				S_DEPARTAMENTO		= @PP_S_DEPARTAMENTO,			
				O_DEPARTAMENTO		= @PP_O_DEPARTAMENTO,
				C_DEPARTAMENTO		= @PP_C_DEPARTAMENTO,
				L_DEPARTAMENTO		= @PP_L_DEPARTAMENTO
		WHERE	DP_DEPTO_HOWE		= @PP_DP_DEPTO_HOWE
	-- =========================================================
GO


SET NOCOUNT ON
-- ===============================================
-- ===============================================
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,00		,'( SIN DEFINIR )'					, '( SIN DEFINIR )'				,000		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,04		,'DEPTO 4  (CONTROL DE CALIDAD)'	, 'CALIDAD'						,010		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,08		,'FINANZAS'							, 'FINANZAS'					,020		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,10		,'FULL HIDES'						, 'FULL HIDES'					,030		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,09		,'GERENCIA'							, 'GERENCIA'					,040		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,05		,'INGENIERIA-MANTENIMIENTO'			, 'ING-MANTO'					,050		,''		,1
--EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,05		,'MANTENIMIENTO'					, 'MANTENIMIENTO'				,060		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,03		,'DEPTO 3 (MATERIALES)'				, 'MATERIALES'					,070		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,11		,'PERFORACION'						, 'PERFORACIÓN'					,080		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,02		,'DEPTO 2 (PRODUCCION)'				, 'PRODUCCIÓN'					,090		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,06		,'PRODUCCION'						, 'PRODUCCIÓN'					,090		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,12		,'INGENIERIA DE PROYECTOS'			, 'PROYECTOS'					,100		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,01		,'DEPTO 1 (ADMINISTRACION)'			, 'RECURSOS HUMANOS'			,110		,''		,1
EXECUTE [dbo].[PG_CI_DEPARTAMENTO] 139	,07		,'SISTEMAS'							, 'SISTEMAS'					,120		,''		,1

-- ===============================================
GO

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////

--SELECT TOP (1000) [DP_DEPTO]
--      ,[DP_DESC_DEPTO]
--      ,[DP_CLASEID]
--      ,[DP_ACTIVO]
--      ,[DP_DESC_OPC]
-- FROM [HOWE_2020].[dbo].[DEPTOS]
-- order by DP_DEPTO

--select * from HOWE.DBO.VISTA_GAFETES	where dp_depto in (2)


--select distinct(en_num_dept) from HOWE.DBO.VISTA_GAFETES
--select distinct(DP_DEPTO) from HOWE.DBO.VISTA_GAFETES order by DP_DEPTO
--select distinct(DP_DESC_DEPTO) from HOWE.DBO.VISTA_GAFETES


--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (1)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (2)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (3)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (4)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (5)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (6)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (7)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (8)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (9)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (11)
--select top (1) (DP_DESC_DEPTO) from [HOWE_2020].[dbo].[DEPTOS]	where dp_depto in (12)

--	select * from HOWE.DBO.VISTA_GAFETES	where dp_depto in (6)
