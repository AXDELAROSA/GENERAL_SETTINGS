-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	[BD_GENERAL]
-- // OPERACION:		MES EN LETRAS
-- //////////////////////////////////////////////////////////////
-- // Autor:			FEG
-- // Fecha creación:	14-ABR-2022
-- //////////////////////////////////////////////////////////////  

USE [BD_GENERAL]
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
--	DROP FUNCTION [dbo].[FN_MES_EN_LETRA]

/*
  SELECT [BD_GENERAL].dbo.FN_MES_EN_LETRA(1)
*/

CREATE FUNCTION [dbo].[FN_MES_EN_LETRA]
(
    @PP_N_MES             INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    
	DECLARE @VP_MES VARCHAR(50) = ( CASE	WHEN @PP_N_MES = 1 THEN 'Enero'
											WHEN @PP_N_MES = 2 THEN 'Febrero'
											WHEN @PP_N_MES = 3 THEN 'Marzo'
											WHEN @PP_N_MES = 4 THEN 'Abril'
											WHEN @PP_N_MES = 5 THEN 'Mayo'
											WHEN @PP_N_MES = 6 THEN 'Junio'
											WHEN @PP_N_MES = 7 THEN 'Julio'
											WHEN @PP_N_MES = 8 THEN 'Agosto'
											WHEN @PP_N_MES = 9 THEN 'Septiembre'
											WHEN @PP_N_MES = 10 THEN 'Octubre'
											WHEN @PP_N_MES = 11 THEN 'Noviembre'
											WHEN @PP_N_MES = 12 THEN 'Diciembre'
									END )

   RETURN @VP_MES
END
GO
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
