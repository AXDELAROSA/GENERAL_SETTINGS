-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		BD_GENERAL
-- // MODULE:			ALL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20200912
-- ////////////////////////////////////////////////////////////// 

USE [BD_GENERAL]
GO

-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PAYMENT_METHOD]') AND type in (N'U'))
	DROP TABLE [dbo].[PAYMENT_METHOD]
GO

-- ////////////////////////////////////////////////////////////////
-- //					PAYMENT_METHOD				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PAYMENT_METHOD] (
	[K_PAYMENT_METHOD]			[INT]			NOT NULL,
	[D_PAYMENT_METHOD]			[VARCHAR](100)	NOT NULL,
	[C_PAYMENT_METHOD]			[VARCHAR](255)	NOT NULL,
	[S_PAYMENT_METHOD]			[VARCHAR](10)	NOT NULL,
	[O_PAYMENT_METHOD]			[INT]			NOT NULL,
	[L_PAYMENT_METHOD]			[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[PAYMENT_METHOD]
	ADD CONSTRAINT [PK_PAYMENT_METHOD]
		PRIMARY KEY CLUSTERED ([K_PAYMENT_METHOD])
GO
--CREATE UNIQUE NONCLUSTERED 
--	INDEX [UN_PAYMENT_METHOD_01_DESCRIPCION] 
--	   ON [dbo].[PAYMENT_METHOD] ( [D_PAYMENT_METHOD] )
--GO
--ALTER TABLE [dbo].[PAYMENT_METHOD] ADD 
--	CONSTRAINT [FK_UNIT_CLASS_01] 
--		FOREIGN KEY ( [K_UNIT_CLASS] ) 
--		REFERENCES [dbo].[UNIT_CLASS] ( [K_UNIT_CLASS] )
--GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_PAYMENT_METHOD]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_PAYMENT_METHOD]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - PAYMENT_METHOD
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_PAYMENT_METHOD]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PAYMENT_METHOD			INT,
	@PP_D_PAYMENT_METHOD			VARCHAR(100),
	@PP_C_PAYMENT_METHOD			VARCHAR(255),
	@PP_S_PAYMENT_METHOD			VARCHAR(10),
	@PP_O_PAYMENT_METHOD			INT,
	@PP_L_PAYMENT_METHOD			INT
AS				
	-- ===========================
	INSERT INTO PAYMENT_METHOD
			(	[K_PAYMENT_METHOD], [D_PAYMENT_METHOD], 
				[C_PAYMENT_METHOD], [S_PAYMENT_METHOD], 
				[O_PAYMENT_METHOD], [L_PAYMENT_METHOD])
	VALUES	
			(	@PP_K_PAYMENT_METHOD, @PP_D_PAYMENT_METHOD, 
				@PP_C_PAYMENT_METHOD, @PP_S_PAYMENT_METHOD,
				@PP_O_PAYMENT_METHOD, @PP_L_PAYMENT_METHOD)
		
	-- //////////////////////////////////////////////////////////////
GO

EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  1,	'Efectivo'									,'' , '',  10 , 1
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  2,	'Cheque nominativo'							,'' , '',  10 , 1
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  3,	'Transferencia electrónica de fondos'		,'' , '',  10 , 1
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  4,	'Tarjeta de crédito'						,'' , '',  10 , 1
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  5,	'Monedero electrónico'						,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  6,	'Dinero electrónico'						,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  8,	'Vales de despensa'							,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  12,	'Dación en pago'							,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  13,	'Pago por subrogación'						,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  14,	'Pago por consignación'						,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  15,	'Condonación'								,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  17,	'Compensación'								,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  23,	'Novación'									,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  24,	'Confusión'									,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  25,	'Remisión de deuda'							,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  26,	'Prescripción o caducidad'					,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  27,	'A satisfacción del acreedor'				,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  28,	'Tarjeta de débito'							,'' , '',  10 , 1
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  29,	'Tarjeta de servicios'						,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  30,	'Aplicación de anticipos'					,'' , '',  10 , 0
EXECUTE [dbo].[PG_CI_PAYMENT_METHOD]  0, 139,  99,	'Por definir'								,'' , '',  10 , 0

GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////