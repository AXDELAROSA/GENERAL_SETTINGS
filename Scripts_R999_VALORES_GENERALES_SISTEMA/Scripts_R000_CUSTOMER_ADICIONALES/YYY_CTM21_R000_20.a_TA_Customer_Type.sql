-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			CUSTOMER
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
--		20210831
--	EN LA TABLA EL CAMPO SE LLAMA CUSTOMER_TYPE_CD, PERO NO SE HA 
--	CAMBIADO DEBIDO A REFERENCIA QUE TIENE EN OTRAS VENTANAS
--	Y OBTIENE INFORMACIÓN DE ESTE CAMPO EN TIPO VARCHAR Y NO CON ID.
--	MIENTRAS NO SE ELIMINEN LAS REFERENCIAS NO SERÁ POSIBLE INCLUIR 
--	ESTA TABLA.
--	VERIFICAR PARA HACER REFERENCIA CON LAS SIGLAS.

--		SELECT * FROM	[CUSTOMER_TYPE]
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CUSTOMER_TYPE]') AND type in (N'U'))
	DROP TABLE [dbo].[CUSTOMER_TYPE]
GO


-- ////////////////////////////////////////////////////////////////
-- //					CUSTOMER_TYPE				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[CUSTOMER_TYPE] (
	[K_CUSTOMER_TYPE]				[INT]			NOT NULL,
	[D_CUSTOMER_TYPE]				[VARCHAR](100)	NOT NULL,
	[C_CUSTOMER_TYPE]				[VARCHAR](255)	NOT NULL,
	[S_CUSTOMER_TYPE]				[VARCHAR](10)	NOT NULL,
	[O_CUSTOMER_TYPE]				[INT]			NOT NULL,
	[L_CUSTOMER_TYPE]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[CUSTOMER_TYPE]
	ADD CONSTRAINT [PK_CUSTOMER_TYPE]
		PRIMARY KEY CLUSTERED ([K_CUSTOMER_TYPE])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CUSTOMER_TYPE_01_DESCRIPCION] 
	   ON [dbo].[CUSTOMER_TYPE] ( [D_CUSTOMER_TYPE] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CUSTOMER_TYPE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CUSTOMER_TYPE]
GO
-- //////////////////////////////////////////////////////////////
-- //				CI - CUSTOMER_TYPE
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_CUSTOMER_TYPE]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_CUSTOMER_TYPE				INT,
	@PP_D_CUSTOMER_TYPE				VARCHAR(100),
	@PP_C_CUSTOMER_TYPE				VARCHAR(255),
	@PP_S_CUSTOMER_TYPE				VARCHAR(10),
	@PP_O_CUSTOMER_TYPE				INT,
	@PP_L_CUSTOMER_TYPE				INT
AS				
	-- ===========================
	INSERT INTO CUSTOMER_TYPE
			(	[K_CUSTOMER_TYPE], [D_CUSTOMER_TYPE], 
				[C_CUSTOMER_TYPE], [S_CUSTOMER_TYPE], 
				[O_CUSTOMER_TYPE], [L_CUSTOMER_TYPE]		)
	VALUES	
			(	@PP_K_CUSTOMER_TYPE, @PP_D_CUSTOMER_TYPE, 
				@PP_C_CUSTOMER_TYPE, @PP_S_CUSTOMER_TYPE,
				@PP_O_CUSTOMER_TYPE, @PP_L_CUSTOMER_TYPE	 )
GO

EXECUTE [DBO].[PG_CI_CUSTOMER_TYPE] 0,139,01, 'MEX COMP USD EX',						'', 'MCUEX'		, 01	,1
EXECUTE [DBO].[PG_CI_CUSTOMER_TYPE] 0,139,02, 'MEX FH USD EXPT',						'', 'MFUEX'		, 02	,1
EXECUTE [DBO].[PG_CI_CUSTOMER_TYPE] 0,139,03, 'MEX SRP USD EXP',						'', 'MSUEX'		, 03	,1
EXECUTE [DBO].[PG_CI_CUSTOMER_TYPE] 0,139,04, 'MISC. SALES',							'', 'MISC'		, 04	,1
-- =================================================================================
GO