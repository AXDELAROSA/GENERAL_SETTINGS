-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190325
-- // MODULO:			
-- // OPERACION:		LIBERACION / DATOS
-- //////////////////////////////////////////////////////////////

USE [COT19_Cotizaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////
-- SELECT * FROM SISTEMA_TAG
-- //////////////////////////////////////////////////////////////
-- K_SISTEMA | #0 DEFAULT | #01 QUOTES

DECLARE @VP_K_SISTEMA INT

SET		@VP_K_SISTEMA =	0001		-- #0001 COTIZACIONES

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

-- //////////////////////////////////////////////////////////////
-- SELECT * FROM [dbo].[SISTEMA] 
-- SELECT * FROM [dbo].[VALOR_PARAMETRO] 

--UPDATE	VALOR_PARAMETRO 
--SET		K_SISTEMA = @VP_K_SISTEMA


-- //////////////////////////////////////////////////////////////

DECLARE @VP_S_SISTEMA		VARCHAR(200)

SELECT	@VP_S_SISTEMA =		S_SISTEMA
							FROM	SISTEMA
							WHERE	K_SISTEMA=@VP_K_SISTEMA

IF @VP_S_SISTEMA IS NULL
	SET @VP_S_SISTEMA = '?????'


DECLARE @VP_D_TEXTO VARCHAR(200)
DECLARE @VP_C_TEXTO VARCHAR(200)

-- //////////////////////////////////////////////////////////////
-- SELECT * FROM SISTEMA_TAG

-- ========================================================
---- LIBERACION // VERSION // BASE DE DATOS
--SET @VP_D_TEXTO = @VP_S_SISTEMA+' > BD/RELEASE'
--SET @VP_C_TEXTO = '01/SEP/2019'
--SET @VP_C_TEXTO = 'BD/RELASE ['+ @VP_C_TEXTO +']'

--EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 0,@VP_K_SISTEMA,	20190901.1,	@VP_D_TEXTO, 'BD.V0001', 1, @VP_C_TEXTO, 1


-- ========================================================
-- LIBERACION // VERSION // EJECUTABLE
SET @VP_D_TEXTO = @VP_S_SISTEMA+' > EXE/RELEASE'
SET @VP_C_TEXTO = '01/SEP/2019'
SET @VP_C_TEXTO = 'EXE/RELASE ['+ @VP_C_TEXTO +']'

EXECUTE [dbo].[PG_CI_SISTEMA_TAG] @VP_K_SISTEMA,   20190901.2,	@VP_D_TEXTO, 'EXE.V0001', 1, @VP_C_TEXTO, 1

-- ========================================================
-- EJECUCION SCRIPT
--SET @VP_D_TEXTO = @VP_S_SISTEMA+' > EJECUCION SCRIPT'

--SET @VP_C_TEXTO = GETDATE()
--SET @VP_C_TEXTO = 'EJECUCION ['+ @VP_C_TEXTO +']'

--EXECUTE [dbo].[PG_CI_SISTEMA_TAG] 0,@VP_K_SISTEMA,	0010,	@VP_D_TEXTO, 'INIT/SQL', 1, @VP_C_TEXTO, 1


-- ========================================================

-- ========================================================
-- SELECT * FROM SISTEMA_TAG




-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////