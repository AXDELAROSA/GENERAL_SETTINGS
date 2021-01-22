-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			STATE_GEO
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_STATE_GEO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_STATE_GEO]
GO


CREATE PROCEDURE [dbo].[PG_CI_STATE_GEO]
	--@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ========================================
	@PP_K_STATE_GEO					INT,			
	@PP_D_STATE_GEO					VARCHAR(100),
	@PP_S_STATE_GEO					VARCHAR(10),
	@PP_O_STATE_GEO					INT,
	@PP_C_STATE_GEO					VARCHAR(255),
	@PP_L_STATE_GEO					INT,
	-- =========================================
	@PP_K_COUNTRY			INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_STATE_GEO
							FROM	[STATE_GEO]
							WHERE	K_STATE_GEO=@PP_K_STATE_GEO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO [STATE_GEO]	
			(	[K_STATE_GEO], [D_STATE_GEO],
				[S_STATE_GEO], [O_STATE_GEO],
				[C_STATE_GEO], [L_STATE_GEO],
				[K_COUNTRY], 
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_STATE_GEO, @PP_D_STATE_GEO,
				@PP_S_STATE_GEO, @PP_O_STATE_GEO, 
				@PP_C_STATE_GEO, @PP_L_STATE_GEO,
				@PP_K_COUNTRY,		
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )							
	ELSE
		UPDATE	STATE_GEO
		SET		
				[D_STATE_GEO]				= @PP_D_STATE_GEO,					
				[S_STATE_GEO]				= @PP_S_STATE_GEO,					
				[C_STATE_GEO]				= @PP_C_STATE_GEO,
				[K_COUNTRY]					= @PP_K_COUNTRY,
				[O_STATE_GEO]				= @PP_O_STATE_GEO, 
				[L_STATE_GEO]				= @PP_L_STATE_GEO,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_STATE_GEO=@PP_K_STATE_GEO
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 0, '(NO-STATE-GEO)', '( N/ST )' , 1 , '#0 // (NO-STATE-GEO)' , 1,0
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 1, 'Aguascalientes', 'Aguas' , 1 , '#1 // Aguascalientes' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 2, 'Baja California', 'BCali' , 1 , '#2 // Baja California' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 3, 'Baja California Sur', 'BCSur' , 1 , '#3 // Baja California Sur' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 4, 'Campeche', 'Campe' , 1 , '#4 // Campeche' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 5, 'Coahuila de Zaragoza', 'Coahu' , 1 , '#5 // Coahuila de Zaragoza' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 6, 'Colima', 'Colim' , 1 , '#6 // Colima' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 7, 'Chiapas', 'Chiap' , 1 , '#7 // Chiapas' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 8, 'Chihuahua', 'Chihu' , 1 , '#8 // Chihuahua' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 9, 'Ciudad de México', 'CDMX' , 1 , '#9 // Ciudad de México' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 10, 'Durango', 'Duran' , 1 , '#10 // Durango' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 11, 'Guanajuato', 'Guana' , 1 , '#11 // Guanajuato' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 12, 'Guerrero', 'Guerr' , 1 , '#12 // Guerrero' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 13, 'Hidalgo', 'Hidal' , 1 , '#13 // Hidalgo' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 14, 'Jalisco', 'Jalis' , 1 , '#14 // Jalisco' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 15, 'México', 'Méxic' , 1 , '#15 // México' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 16, 'Michoacán de Ocampo', 'Micho' , 1 , '#16 // Michoacán de Ocampo' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 17, 'Morelos', 'Morel' , 1 , '#17 // Morelos' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 18, 'Nayarit', 'Nayar' , 1 , '#18 // Nayarit' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 19, 'Nuevo León', 'Nuevo' , 1 , '#19 // Nuevo León' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 20, 'Oaxaca', 'Oaxac' , 1 , '#20 // Oaxaca' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 21, 'Puebla', 'Puebl' , 1 , '#21 // Puebla' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 22, 'Querétaro', 'Queré' , 1 , '#22 // Querétaro' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 23, 'Quintana Roo', 'Quint' , 1 , '#23 // Quintana Roo' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 24, 'San Luis Potosí', 'SLuis' , 1 , '#24 // San Luis Potosí' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 25, 'Sinaloa', 'Sinal' , 1 , '#25 // Sinaloa' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 26, 'Sonora', 'Sonor' , 1 , '#26 // Sonora' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 27, 'Tabasco', 'Tabas' , 1 , '#27 // Tabasco' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 28, 'Tamaulipas', 'Tamau' , 1 , '#28 // Tamaulipas' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 29, 'Tlaxcala', 'Tlaxc' , 1 , '#29 // Tlaxcala' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 30, 'Veracruz de Ignacio de la Llav', 'Verac' , 1 , '#30 // Veracruz de Ignacio de la Llav' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 31, 'Yucatán', 'Yucat' , 1 , '#31 // Yucatán' , 1,260
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 32, 'Zacatecas', 'Zacat' , 1 , '#32 // Zacatecas' , 1,260

-- =============================================================================================================================================
--			AX:		AGREGADOS EL 20210119		USA
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 33, 'Alabama ', 'AL' , 1 , '#33 // Alabama ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 34, 'Alaska ', 'AK' , 1 , '#34 // Alaska ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 35, 'Arizona ', 'AZ' , 1 , '#35 // Arizona ' , 1,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 36, 'Arkansas ', 'AR' , 1 , '#36 // Arkansas ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 37, 'California ', 'CA' , 1 , '#37 // California ' , 1,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 38, 'Colorado', 'CO' , 1 , '#38 // Colorado' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 39, 'Connecticut ', 'CT' , 1 , '#39 // Connecticut ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 40, 'Delaware ', 'DE' , 1 , '#40 // Delaware ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 41, 'Florida ', 'DL' , 1 , '#41 // Florida ' , 1,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 42, 'Georgia ', 'GA' , 1 , '#42 // Georgia ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 43, 'Hawaii ', 'HI' , 1 , '#43 // Hawaii ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 44, 'Idaho ', 'ID' , 1 , '#44 // Idaho ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 45, 'Illinois ', 'IL' , 1 , '#45 // Illinois ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 46, 'Indiana ', 'IN' , 1 , '#46 // Indiana ' , 1,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 47, 'Iowa', 'IA' , 1 , '#47 // Iowa' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 48, 'Kansas ', 'KS' , 1 , '#48 // Kansas ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 49, 'Kentucky ', 'KY' , 1 , '#49 // Kentucky ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 50, 'Louisiana ', 'LA' , 1 , '#50 // Louisiana ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 51, 'Maine ', 'ME' , 1 , '#51 // Maine ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 52, 'Maryland ', 'MD' , 1 , '#52 // Maryland ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 53, 'Massachusetts ', 'MA' , 1 , '#53 // Massachusetts ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 54, 'Michigan', 'MI' , 1 , '#54 // Michigan' , 1,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 55, 'Minnesota ', 'MN' , 1 , '#55 // Minnesota ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 56, 'Mississippi ', 'MS' , 1 , '#56 // Mississippi ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 57, 'Missouri ', 'MO' , 1 , '#57 // Missouri ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 58, 'Montana ', 'MT' , 1 , '#58 // Montana ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 59, 'Nebraska ', 'NE' , 1 , '#59 // Nebraska ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 60, 'Nevada ', 'NV' , 1 , '#60 // Nevada ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 61, 'New Hampshire ', 'NH' , 1 , '#61 // New Hampshire ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 62, 'New Jersey ', 'NJ' , 1 , '#62 // New Jersey ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 63, 'New Mexico ', 'NM' , 1 , '#63 // New Mexico ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 64, 'New York ', 'NY' , 1 , '#64 // New York ' , 1,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 65, 'North Carolina ', 'NC' , 1 , '#65 // North Carolina ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 66, 'North Dakota ', 'ND' , 1 , '#66 // North Dakota ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 67, 'Ohio', 'OH' , 1 , '#67 // Ohio' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 68, 'Oklahoma ', 'OK' , 1 , '#68 // Oklahoma ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 69, 'Oregon ', 'OR' , 1 , '#69 // Oregon ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 70, 'Pennsylvania ', 'PA' , 1 , '#70 // Pennsylvania ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 71, 'Rhode Island ', 'RI' , 1 , '#71 // Rhode Island ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 72, 'South Carolina ', 'SC' , 1 , '#72 // South Carolina ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 73, 'South Dakota ', 'SD' , 1 , '#73 // South Dakota ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 74, 'Tennessee ', 'TN' , 1 , '#74 // Tennessee ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 75, 'Texas ', 'TX' , 1 , '#75 // Texas ' , 1,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 76, 'Utah ', 'UT' , 1 , '#76 // Utah ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 77, 'Vermont ', 'VT' , 1 , '#77 // Vermont ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 78, 'Virginia ', 'VA' , 1 , '#78 // Virginia ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 79, 'Washington ', 'WA' , 1 , '#79 // Washington ' , 1,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 80, 'West Virginia ', 'WV' , 1 , '#80 // West Virginia ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 81, 'Wisconsin ', 'WI' , 1 , '#81 // Wisconsin ' , 0,221
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 82, 'Wyoming', 'WY' , 1 , '#82 // Wyoming' , 0,221

-- =============================================================================================================================================
--			AX:		AGREGADOS EL 20210119		CANADA
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 83, 'Ontario', 'ON' , 1 , '#83 // Ontario' , 1,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 84, 'Quebec', 'QC' , 1 , '#84 // Quebec' , 1,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 85, 'Nueva Escocia', 'NS' , 1 , '#85 // Nueva Escocia' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 86, 'Nuevo Brunswick', 'NB' , 1 , '#86 // Nuevo Brunswick' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 87, 'Manitoba', 'MB' , 1 , '#87 // Manitoba' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 88, 'Territorios del Noroeste', 'NT' , 1 , '#88 // Territorios del Noroeste' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 89, 'Columbia Británica', 'BC' , 1 , '#89 // Columbia Británica' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 90, 'Isla del Príncipe Eduardo', 'PE' , 1 , '#90 // Isla del Príncipe Eduardo' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 91, 'Yukón', 'YT' , 1 , '#91 // Yukón' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 92, 'Saskatchewan', 'SK' , 1 , '#92 // Saskatchewan' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 93, 'Alberta', 'AB' , 1 , '#93 // Alberta' , 1,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 94, 'Terranova y Labrador', 'NL' , 1 , '#94 // Terranova y Labrador' , 0,213
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 95, 'Nunavut', 'NU' , 1 , '#95 // Nunavut' , 0,213

-- =============================================================================================================================================
--			AX:		AGREGADOS EL 20210119		AUSTRALIA
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 96, 'Australia Meridional', 'AU-SA' , 1 , '#96 // Australia Meridional' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 97, 'Australia Occidental', 'AU-WA' , 1 , '#97 // Australia Occidental' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 98, 'Isla de Navidad', 'CX' , 1 , '#98 // Isla de Navidad' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 99, 'Isla Norfolk', 'NF' , 1 , '#99 // Isla Norfolk' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 100, 'Islas Ashmore y Cartier', 'ISASC' , 1 , '#100 // Islas Ashmore y Cartier' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 101, 'Islas Cocos', 'CC' , 1 , '#101 // Islas Cocos' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 102, 'Islas del Mar del Coral', 'ISMAC' , 1 , '#102 // Islas del Mar del Coral' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 103, 'Islas Heard y McDonald', 'HM' , 1 , '#103 // Islas Heard y McDonald' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 104, 'Nueva Gales del Sur', 'AU-NSW' , 1 , '#104 // Nueva Gales del Sur' , 1,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 105, 'Queensland', 'AU-QLD' , 1 , '#105 // Queensland' , 1,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 106, 'Tasmania', 'AU-TAS' , 1 , '#106 // Tasmania' , 1,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 107, 'Territorio Antártico Australiano', 'AQ' , 1 , '#107 // Territorio Antártico Australiano' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 108, 'Territorio de la Bahía de Jervis', 'JBT' , 1 , '#108 // Territorio de la Bahía de Jervis' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 109, 'Territorio de la Capital Australiana', 'AU-ACT' , 1 , '#109 // Territorio de la Capital Australiana' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 110, 'Territorio del Norte', 'AU-NT' , 1 , '#110 // Territorio del Norte' , 0,501
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 111, 'Victoria', 'AU-VIC' , 1 , '#111 // Victoria' , 1,501

-- =============================================================================================================================================
--			AX:		AGREGADOS EL 20210119		TAILANDIA
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 112, 'Amnat Charoen', 'Amnat Charoen' , 1 , '#112 // Amnat Charoen' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 113, 'Ang Thong', 'Ang Thong' , 1 , '#113 // Ang Thong' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 114, 'Bangkok', 'Bangkok' , 1 , '#114 // Bangkok' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 115, 'Bueng Kan', 'Bueng Kan' , 1 , '#115 // Bueng Kan' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 116, 'Buri Ram', 'Buri Ram' , 1 , '#116 // Buri Ram' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 117, 'Chachoengsao', 'Chachoengsao' , 1 , '#117 // Chachoengsao' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 118, 'Chainat', 'Chainat' , 1 , '#118 // Chainat' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 119, 'Chaiyaphum', 'Chaiyaphum' , 1 , '#119 // Chaiyaphum' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 120, 'Chanthaburi', 'Chanthaburi' , 1 , '#120 // Chanthaburi' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 121, 'Chiang Mai', 'Chiang Mai' , 1 , '#121 // Chiang Mai' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 122, 'Chiang Rai', 'Chiang Rai' , 1 , '#122 // Chiang Rai' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 123, 'Chon Buri', 'Chon Buri' , 1 , '#123 // Chon Buri' , 1,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 124, 'Chumphon', 'Chumphon' , 1 , '#124 // Chumphon' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 125, 'Kalasin', 'Kalasin' , 1 , '#125 // Kalasin' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 126, 'Kamphaeng Phet', 'Kamphaeng Phet' , 1 , '#126 // Kamphaeng Phet' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 127, 'Kanchanaburi', 'Kanchanaburi' , 1 , '#127 // Kanchanaburi' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 128, 'Khon Kaen', 'Khon Kaen' , 1 , '#128 // Khon Kaen' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 129, 'Krabi', 'Krabi' , 1 , '#129 // Krabi' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 130, 'Lampang', 'Lampang' , 1 , '#130 // Lampang' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 131, 'Lamphun', 'Lamphun' , 1 , '#131 // Lamphun' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 132, 'Loei', 'Loei' , 1 , '#132 // Loei' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 133, 'Lop Buri', 'Lop Buri' , 1 , '#133 // Lop Buri' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 134, 'Mae Hong Son', 'Mae Hong Son' , 1 , '#134 // Mae Hong Son' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 135, 'Maha Sarakham', 'Maha Sarakham' , 1 , '#135 // Maha Sarakham' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 136, 'Mukdahan', 'Mukdahan' , 1 , '#136 // Mukdahan' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 137, 'Nakhon Nayok', 'Nakhon Nayok' , 1 , '#137 // Nakhon Nayok' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 138, 'Nakhon Pathom', 'Nakhon Pathom' , 1 , '#138 // Nakhon Pathom' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 139, 'Nakhon Phanom', 'Nakhon Phanom' , 1 , '#139 // Nakhon Phanom' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 140, 'Nakhon Ratchasima', 'Nakhon Ratchasima' , 1 , '#140 // Nakhon Ratchasima' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 141, 'Nakhon Sawan', 'Nakhon Sawan' , 1 , '#141 // Nakhon Sawan' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 142, 'Nakhon Si Thammarat', 'Nakhon Si Thammarat' , 1 , '#142 // Nakhon Si Thammarat' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 143, 'Nan', 'Nan' , 1 , '#143 // Nan' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 144, 'Narathiwat', 'Narathiwat' , 1 , '#144 // Narathiwat' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 145, 'Nong Bua Lam Phu', 'Nong Bua Lam Phu' , 1 , '#145 // Nong Bua Lam Phu' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 146, 'Nong Khai', 'Nong Khai' , 1 , '#146 // Nong Khai' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 147, 'Nonthaburi', 'Nonthaburi' , 1 , '#147 // Nonthaburi' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 148, 'Pathum Thani', 'Pathum Thani' , 1 , '#148 // Pathum Thani' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 149, 'Pattani', 'Pattani' , 1 , '#149 // Pattani' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 150, 'Phang Nga', 'Phang Nga' , 1 , '#150 // Phang Nga' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 151, 'Phatthalung', 'Phatthalung' , 1 , '#151 // Phatthalung' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 152, 'Phayao', 'Phayao' , 1 , '#152 // Phayao' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 153, 'Phetchabun', 'Phetchabun' , 1 , '#153 // Phetchabun' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 154, 'Phetchaburi', 'Phetchaburi' , 1 , '#154 // Phetchaburi' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 155, 'Phichit', 'Phichit' , 1 , '#155 // Phichit' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 156, 'Phitsanulok', 'Phitsanulok' , 1 , '#156 // Phitsanulok' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 157, 'Phra Nakhon Si Ayutthaya', 'Phra Nakhon Si Ayutthaya' , 1 , '#157 // Phra Nakhon Si Ayutthaya' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 158, 'Phrae', 'Phrae' , 1 , '#158 // Phrae' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 159, 'Phuket', 'Phuket' , 1 , '#159 // Phuket' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 160, 'Prachin Buri', 'Prachin Buri' , 1 , '#160 // Prachin Buri' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 161, 'Prachuap Khiri Khan', 'Prachuap Khiri Khan' , 1 , '#161 // Prachuap Khiri Khan' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 162, 'Ranong', 'Ranong' , 1 , '#162 // Ranong' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 163, 'Ratchaburi', 'Ratchaburi' , 1 , '#163 // Ratchaburi' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 164, 'Rayong', 'Rayong' , 1 , '#164 // Rayong' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 165, 'Roi Et', 'Roi Et' , 1 , '#165 // Roi Et' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 166, 'Sa Kaeo', 'Sa Kaeo' , 1 , '#166 // Sa Kaeo' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 167, 'Sakon Nakhon', 'Sakon Nakhon' , 1 , '#167 // Sakon Nakhon' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 168, 'Samut Prakan', 'Samut Prakan' , 1 , '#168 // Samut Prakan' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 169, 'Samut Sakhon', 'Samut Sakhon' , 1 , '#169 // Samut Sakhon' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 170, 'Samut Songkhram', 'Samut Songkhram' , 1 , '#170 // Samut Songkhram' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 171, 'Saraburi', 'Saraburi' , 1 , '#171 // Saraburi' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 172, 'Satun', 'Satun' , 1 , '#172 // Satun' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 173, 'Si Sa Ket', 'Si Sa Ket' , 1 , '#173 // Si Sa Ket' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 174, 'Sing Buri', 'Sing Buri' , 1 , '#174 // Sing Buri' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 175, 'Songkhla', 'Songkhla' , 1 , '#175 // Songkhla' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 176, 'Sukhothai', 'Sukhothai' , 1 , '#176 // Sukhothai' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 177, 'Suphan Buri', 'Suphan Buri' , 1 , '#177 // Suphan Buri' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 178, 'Surat Thani', 'Surat Thani' , 1 , '#178 // Surat Thani' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 179, 'Surin', 'Surin' , 1 , '#179 // Surin' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 180, 'Tak', 'Tak' , 1 , '#180 // Tak' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 181, 'Trang', 'Trang' , 1 , '#181 // Trang' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 182, 'Trat', 'Trat' , 1 , '#182 // Trat' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 183, 'Ubon Ratchathani', 'Ubon Ratchathani' , 1 , '#183 // Ubon Ratchathani' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 184, 'Udon Thani', 'Udon Thani' , 1 , '#184 // Udon Thani' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 185, 'Uthai Thani', 'Uthai Thani' , 1 , '#185 // Uthai Thani' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 186, 'Uttaradit', 'Uttaradit' , 1 , '#186 // Uttaradit' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 187, 'Yala', 'Yala' , 1 , '#187 // Yala' , 0,349
EXECUTE [dbo].[PG_CI_STATE_GEO] 0, 139, 188, 'Yasothon', 'Yasothon' , 1 , '#188 // Yasothon' , 0,349

GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////


