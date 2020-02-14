-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		COT19
-- // MODULE:			COUNTRY
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_COUNTRY]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_COUNTRY]
GO


CREATE PROCEDURE [dbo].[PG_CI_COUNTRY]
	--@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ========================================
	@PP_K_COUNTRY				INT,			
	@PP_D_COUNTRY				VARCHAR(100),
	@PP_S_COUNTRY				VARCHAR(10),
	@PP_O_COUNTRY				INT,
	@PP_C_COUNTRY				VARCHAR(255),
	@PP_L_COUNTRY				INT,
	-- =========================================
	@PP_K_CONTINENTE			INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_COUNTRY
							FROM	[COUNTRY]
							WHERE	K_COUNTRY=@PP_K_COUNTRY

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO [COUNTRY]	
			(	[K_COUNTRY], [D_COUNTRY],
				[S_COUNTRY], [O_COUNTRY],
				[C_COUNTRY], [L_COUNTRY],
				[K_CONTINENTE], 
			-- ============================================
				[K_USUARIO_ALTA], [F_ALTA], 
				[K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )		
		VALUES	
			(	@PP_K_COUNTRY, @PP_D_COUNTRY,
				@PP_S_COUNTRY, 1, 
				@PP_C_COUNTRY, 1,
				@PP_K_CONTINENTE,		
			-- ============================================
				@PP_K_USUARIO_ACCION, GETDATE(), 
				@PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )							
	ELSE
		UPDATE	COUNTRY
		SET		
				[D_COUNTRY]				= @PP_D_COUNTRY,					
				[S_COUNTRY]				= @PP_S_COUNTRY,					
				[C_COUNTRY]				= @PP_C_COUNTRY,
				[K_CONTINENTE]			= @PP_K_CONTINENTE,
			-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_COUNTRY=@PP_K_COUNTRY
	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 0, '(NO-COUNTRY)', '( N/CT )' , 1 , '#0 // (NO-COUNTRY)' , 1,0
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 101, 'República de Angola', 'ANGOL' , 1 , '#101 // República de Angola' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 102, 'República Democrática y Popular de Argelia', 'ARGEL' , 1 , '#102 // República Democrática y Popular de Argelia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 104, 'República de Benín', 'BENÍN' , 1 , '#104 // República de Benín' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 105, 'República de Botswana', 'BOTSW' , 1 , '#105 // República de Botswana' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 106, 'Burkina Faso', 'BURKI' , 1 , '#106 // Burkina Faso' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 107, 'República de Burundi', 'BURUN' , 1 , '#107 // República de Burundi' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 108, 'República de Cabo Verde', 'CABO' , 1 , '#108 // República de Cabo Verde' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 109, 'República de Camerún', 'CAMER' , 1 , '#109 // República de Camerún' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 112, 'República de Ruanda', 'RUAND' , 1 , '#112 // República de Ruanda' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 113, 'República Popular del Congo', 'PCONGO' , 1 , '#113 // República Popular del Congo' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 114, 'República de Costa de Marfi l', 'CMARF' , 1 , '#114 // República de Costa de Marfi l' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 115, 'República de Chad', 'CHAD' , 1 , '#115 // República de Chad' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 116, 'República de Djibouti', 'DJIBO' , 1 , '#116 // República de Djibouti' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 117, 'República Árabe deEgipto', 'EGYP' , 1 , '#117 // República Árabe deEgipto' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 118, 'Estado de Eritrea', 'EERIT' , 1 , '#118 // Estado de Eritrea' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 119, 'República Federal Democrática de Etiopía', 'ETIOP' , 1 , '#119 // República Federal Democrática de Etiopía' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 120, 'República Gabonesa', 'GABON' , 1 , '#120 // República Gabonesa' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 121, 'República de Gambia', 'GAMBI' , 1 , '#121 // República de Gambia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 122, 'República de Ghana', 'GHANA' , 1 , '#122 // República de Ghana' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 123, 'República de Guinea', 'GUINE' , 1 , '#123 // República de Guinea' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 124, 'República de Guinea Bissau', 'GBISS' , 1 , '#124 // República de Guinea Bissau' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 125, 'República de Guinea Ecuatoria', 'GECUA' , 1 , '#125 // República de Guinea Ecuatoria' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 126, 'República de Kenia', 'KENIA' , 1 , '#126 // República de Kenia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 127, 'Reino de Lesotho', 'LESOT' , 1 , '#127 // Reino de Lesotho' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 128, 'República de Liberia', 'LIBER' , 1 , '#128 // República de Liberia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 129, 'Libia', 'LIBIA' , 1 , '#129 // Libia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 130, 'República de Madagascar', 'MADAG' , 1 , '#130 // República de Madagascar' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 133, 'República de Malawi', 'MALAW' , 1 , '#133 // República de Malawi' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 134, 'República de Malí', 'MALÍ' , 1 , '#134 // República de Malí' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 135, 'Reino de Marruecos', 'MARRU' , 1 , '#135 // Reino de Marruecos' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 136, 'República de Mauricio', 'MAURI' , 1 , '#136 // República de Mauricio' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 137, 'República Islámica de Maurita', 'MAURC' , 1 , '#137 // República Islámica de Maurita' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 138, 'Islas Anglonormandas', 'ANGLO' , 1 , '#138 // Islas Anglonormandas' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 139, 'República de Mozambique', 'MOZAM' , 1 , '#139 // República de Mozambique' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 140, 'República de Namibia', 'NAMIB' , 1 , '#140 // República de Namibia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 141, 'República de Níger', 'NÍGER' , 1 , '#141 // República de Níger' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 142, 'República Federal de Nigeria', 'NIGRIA' , 1 , '#142 // República Federal de Nigeria' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 143, 'República Centroafricana', 'CAFRI' , 1 , '#143 // República Centroafricana' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 145, 'Colectividad territorial de San Pedro y Miquelón', 'SPEDR' , 1 , '#145 // Colectividad territorial de San Pedro y Miquelón' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 147, 'Isla Santa Helena', 'ISELE' , 1 , '#147 // Isla Santa Helena' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 148, 'República Democrática de Santo Tome y Príncipe', 'STYPR' , 1 , '#148 // República Democrática de Santo Tome y Príncipe' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 149, 'República de Senegal', 'SENEG' , 1 , '#149 // República de Senegal' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 150, 'República de Isla Seychelles', 'SEYCH' , 1 , '#150 // República de Isla Seychelles' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 151, 'República de Sierra Leona', 'SLEON' , 1 , '#151 // República de Sierra Leona' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 152, 'Unión de las Comoras', 'UCOMO' , 1 , '#152 // Unión de las Comoras' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 153, 'República de Somalia', 'SOMAL' , 1 , '#153 // República de Somalia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 154, 'República de Sudáfrica', 'SUDÁF' , 1 , '#154 // República de Sudáfrica' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 160, 'Reino de Suazilandia', 'RSUAZ' , 1 , '#160 // Reino de Suazilandia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 161, 'República Unida de Tanzania', 'TANZA' , 1 , '#161 // República Unida de Tanzania' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 162, 'República Togolesa', 'TOGOL' , 1 , '#162 // República Togolesa' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 164, 'República de Túnez', 'TÚNEZ' , 1 , '#164 // República de Túnez' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 165, 'República de Uganda', 'UGAND' , 1 , '#165 // República de Uganda' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 167, 'República de Zambia', 'ZAMBI' , 1 , '#167 // República de Zambia' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 168, 'República de Zimbabwe', 'ZIMBA' , 1 , '#168 // República de Zimbabwe' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 169, 'República Democrática del Congo', 'DCONGO' , 1 , '#169 // República Democrática del Congo' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 170, 'República Árabe Saharaui Democrática', 'ARABE' , 1 , '#170 // República Árabe Saharaui Democrática' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 171, 'República de Sudán', 'SUDÁN' , 1 , '#171 // República de Sudán' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 172, 'República de Sudán del Sur', 'SUDSU' , 1 , '#172 // República de Sudán del Sur' , 1,100
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 201, 'Anguila', 'ANGUI' , 1 , '#201 // Anguila' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 202, 'Antigua y Barbuda', 'AYBAR' , 1 , '#202 // Antigua y Barbuda' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 204, 'República Argentina', 'ARGEN' , 1 , '#204 // República Argentina' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 205, 'Aruba', 'ARUBA' , 1 , '#205 // Aruba' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 206, 'Commonwealth de las Bahamas', 'BAHAM' , 1 , '#206 // Commonwealth de las Bahamas' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 207, 'Barbados', 'BARBA' , 1 , '#207 // Barbados' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 208, 'Belice', 'BELIC' , 1 , '#208 // Belice' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 209, 'Islas Bermudas', 'IBERM' , 1 , '#209 // Islas Bermudas' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 210, 'República de Bolivia', 'BOLIV' , 1 , '#210 // República de Bolivia' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 211, 'República Federativa de Brasil', 'BRASI' , 1 , '#211 // República Federativa de Brasil' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 212, 'Islas Caimán', 'ICAIM' , 1 , '#212 // Islas Caimán' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 213, 'Canadá', 'CANAD' , 1 , '#213 // Canadá' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 214, 'República de Colombia', 'COLOM' , 1 , '#214 // República de Colombia' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 215, 'República de Costa rica', 'CRICA' , 1 , '#215 // República de Costa rica' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 216, 'República de Cuba', 'CUBA' , 1 , '#216 // República de Cuba' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 217, 'República de Chile', 'CHILE' , 1 , '#217 // República de Chile' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 218, 'Commonwealth de Dominica', 'DMNCA' , 1 , '#218 // Commonwealth de Dominica' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 219, 'República de Ecuador', 'ECUAD' , 1 , '#219 // República de Ecuador' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 220, 'República de El Salvador', 'SALVA' , 1 , '#220 // República de El Salvador' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 221, 'Estados Unidos de América', 'USA' , 1 , '#221 // Estados Unidos de América' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 222, 'Granada', 'GRANA' , 1 , '#222 // Granada' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 223, 'Groenlandia', 'GROEN' , 1 , '#223 // Groenlandia' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 224, 'Departamento de Guadalupe', 'GDLPE' , 1 , '#224 // Departamento de Guadalupe' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 225, 'República de Guatemala', 'GUATE' , 1 , '#225 // República de Guatemala' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 226, 'República Cooperativa de Guyana', 'GUYAN' , 1 , '#226 // República Cooperativa de Guyana' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 227, 'Guayana Francesa', 'GFRAN' , 1 , '#227 // Guayana Francesa' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 228, 'República de Haití', 'HAITÍ' , 1 , '#228 // República de Haití' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 229, 'República de Honduras', 'HONDU' , 1 , '#229 // República de Honduras' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 230, 'Jamaica', 'JAMAI' , 1 , '#230 // Jamaica' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 231, 'Islas Malvinas', 'IMALV' , 1 , '#231 // Islas Malvinas' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 233, 'Isla de Montserrat', 'IMONT' , 1 , '#233 // Isla de Montserrat' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 234, 'República de Nicaragua', 'NICAR' , 1 , '#234 // República de Nicaragua' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 235, 'República de Panamá', 'PANAM' , 1 , '#235 // República de Panamá' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 236, 'República de Paraguay', 'PARAG' , 1 , '#236 // República de Paraguay' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 237, 'República de Perú', 'PERÚ' , 1 , '#237 // República de Perú' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 238, 'Estado Libre Asociado de Puerto Rico', 'PRICO' , 1 , '#238 // Estado Libre Asociado de Puerto Rico' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 239, 'República Dominicana', 'RDOMI' , 1 , '#239 // República Dominicana' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 240, 'Federación de San Cristóbal y Nieves', 'SCYNI' , 1 , '#240 // Federación de San Cristóbal y Nieves' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 241, 'Islas de Man', 'IMAN' , 1 , '#241 // Islas de Man' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 242, 'San Vicente y las Granadinas', 'SVYGR' , 1 , '#242 // San Vicente y las Granadinas' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 243, 'Santa Lucía', 'STALU' , 1 , '#243 // Santa Lucía' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 244, 'República de Surinam', 'SURIN' , 1 , '#244 // República de Surinam' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 245, 'República de Trinidad y Tobago', 'TYTOB' , 1 , '#245 // República de Trinidad y Tobago' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 246, 'Islas Turcas y Caicos', 'ITURC' , 1 , '#246 // Islas Turcas y Caicos' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 247, 'República Oriental del Uruguay', 'URUGU' , 1 , '#247 // República Oriental del Uruguay' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 248, 'Islas Vírgenes de los Estados Unidos', 'IVÍES' , 1 , '#248 // Islas Vírgenes de los Estados Unidos' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 249, 'Islas Vírgenes Británicas', 'IVÍBR' , 1 , '#249 // Islas Vírgenes Británicas' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 250, 'República Boliviana de Venezuela', 'VENEZ' , 1 , '#250 // República Boliviana de Venezuela' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 251, 'Curazao', 'CURAZ' , 1 , '#251 // Curazao' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 252, 'Isla de Saint Marteen', 'ISTMA' , 1 , '#252 // Isla de Saint Marteen' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 253, 'Bonaire, San Eustaquio, Saba', 'BEUST' , 1 , '#253 // Bonaire, San Eustaquio, Saba' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 260, 'Estados Unidos Mexicanos', 'MEX' , 1 , '#260 // Estados Unidos Mexicanos' , 1,200
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 301, 'Estado Islámico de Afganistán', 'AFGAN' , 1 , '#301 // Estado Islámico de Afganistán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 302, 'Reino de Arabia Saudita', 'ASAUD' , 1 , '#302 // Reino de Arabia Saudita' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 303, 'República de Armenia', 'ARMEN' , 1 , '#303 // República de Armenia' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 304, 'República de Azerbaiyán', 'AZERB' , 1 , '#304 // República de Azerbaiyán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 305, 'Reino de Bahréin', 'RBAHR' , 1 , '#305 // Reino de Bahréin' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 306, 'República Popular de Bangladesh', 'BANGL' , 1 , '#306 // República Popular de Bangladesh' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 307, 'Reino de Bhutan', 'BHUTA' , 1 , '#307 // Reino de Bhutan' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 308, 'Estado de Brunei Darussalam', 'BRUNE' , 1 , '#308 // Estado de Brunei Darussalam' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 309, 'Reino de Camboya', 'CAMBO' , 1 , '#309 // Reino de Camboya' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 312, 'República Popular democrática de Corea', 'RCORE' , 1 , '#312 // República Popular democrática de Corea' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 313, 'República de Corea', 'COREA' , 1 , '#313 // República de Corea' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 315, 'República Popular China', 'CHINA' , 1 , '#315 // República Popular China' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 316, 'Taiwán', 'TAIWA' , 1 , '#316 // Taiwán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 318, 'República de Chipre', 'CHIPR' , 1 , '#318 // República de Chipre' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 321, 'Emiratos Árabes Unidos', 'EAUNI' , 1 , '#321 // Emiratos Árabes Unidos' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 322, 'República de Filipinas', 'FILIP' , 1 , '#322 // República de Filipinas' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 323, 'República de Georgia', 'GEORG' , 1 , '#323 // República de Georgia' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 325, 'República de la India', 'INDIA' , 1 , '#325 // República de la India' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 326, 'República de Indonesia', 'INDON' , 1 , '#326 // República de Indonesia' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 327, 'República Islámica de Irán', 'IRÁN' , 1 , '#327 // República Islámica de Irán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 328, 'República de Iraq', 'IRAQ' , 1 , '#328 // República de Iraq' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 329, 'Estado de Israel', 'ISRAE' , 1 , '#329 // Estado de Israel' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 330, 'Estado de Japón', 'JAPÓN' , 1 , '#330 // Estado de Japón' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 331, 'Reino Hachemí de Jordania', 'JORDA' , 1 , '#331 // Reino Hachemí de Jordania' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 332, 'República de Kazajstán', 'KAZAJ' , 1 , '#332 // República de Kazajstán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 333, 'República Kirguisa', 'KIRGU' , 1 , '#333 // República Kirguisa' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 334, 'Estado de Kuwait', 'KUWAI' , 1 , '#334 // Estado de Kuwait' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 335, 'República Libanesa', 'LIBAN' , 1 , '#335 // República Libanesa' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 337, 'Malasia', 'MALAS' , 1 , '#337 // Malasia' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 338, 'República de Maldivas', 'MALDI' , 1 , '#338 // República de Maldivas' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 339, 'Mongolia', 'MONGOL' , 1 , '#339 // Mongolia' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 340, 'Unión de Myanmar', 'MYANM' , 1 , '#340 // Unión de Myanmar' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 341, 'República Federal Democrática de Nepal', 'NEPAL' , 1 , '#341 // República Federal Democrática de Nepal' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 342, 'Sultanato de Omán', 'OMÁN' , 1 , '#342 // Sultanato de Omán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 343, 'República Islámica de Pakistán', 'PAKIS' , 1 , '#343 // República Islámica de Pakistán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 344, 'Estado de Qatar', 'QATAR' , 1 , '#344 // Estado de Qatar' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 345, 'República Democrática Popular de Laos', 'LAOS' , 1 , '#345 // República Democrática Popular de Laos' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 346, 'República de Singapur', 'SINGA' , 1 , '#346 // República de Singapur' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 347, 'República árabe Siria', 'SIRIA' , 1 , '#347 // República árabe Siria' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 348, 'República Democrática Socialista Sri Lanka', 'SRILA' , 1 , '#348 // República Democrática Socialista Sri Lanka' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 349, 'Reino de Tailandia', 'TAILA' , 1 , '#349 // Reino de Tailandia' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 350, 'República de Tayikistán', 'TAYIK' , 1 , '#350 // República de Tayikistán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 351, 'Turkmenistán', 'TURKE' , 1 , '#351 // Turkmenistán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 352, 'República de Turquía', 'TURQU' , 1 , '#352 // República de Turquía' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 353, 'República de Uzbekistán', 'UZBEK' , 1 , '#353 // República de Uzbekistán' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 354, 'República Socialista de Vietnam', 'VIETN' , 1 , '#354 // República Socialista de Vietnam' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 355, 'República de Yemen', 'YEMEN' , 1 , '#355 // República de Yemen' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 356, 'República de Palaos', 'PALAO' , 1 , '#356 // República de Palaos' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 357, 'República Democrática de Timor Oriental', 'TIMOR' , 1 , '#357 // República Democrática de Timor Oriental' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 358, 'Estado de Palestina', 'PALES' , 1 , '#358 // Estado de Palestina' , 1,300
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 401, 'República de Albania', 'ALBAN' , 1 , '#401 // República de Albania' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 402, 'República Federal de Alemania', 'ALEMA' , 1 , '#402 // República Federal de Alemania' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 403, 'Principado de Andorra', 'ANDOR' , 1 , '#403 // Principado de Andorra' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 405, 'República de Austria', 'AUSTR' , 1 , '#405 // República de Austria' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 407, 'República de Bielorrusia', 'BIELO' , 1 , '#407 // República de Bielorrusia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 408, 'Reino de Bélgica', 'BELGI' , 1 , '#408 // Reino de Bélgica' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 409, 'Bosnia y Herzegovina', 'BSNHE' , 1 , '#409 // Bosnia y Herzegovina' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 410, 'República de Bulgaria', 'BULGA' , 1 , '#410 // República de Bulgaria' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 411, 'República de Croacia', 'CROAC' , 1 , '#411 // República de Croacia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 412, 'Reino de Dinamarca', 'DINAM' , 1 , '#412 // Reino de Dinamarca' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 413, 'República Eslovaca', 'SLVAC' , 1 , '#413 // República Eslovaca' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 414, 'República de Eslovenia', 'SLOVN' , 1 , '#414 // República de Eslovenia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 415, 'Reino de España', 'ESPAÑ' , 1 , '#415 // Reino de España' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 416, 'República de Estonia', 'ESTON' , 1 , '#416 // República de Estonia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 417, 'Islas Feroe', 'FEROE' , 1 , '#417 // Islas Feroe' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 418, 'República de Finlandia', 'FINLA' , 1 , '#418 // República de Finlandia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 419, 'República Francesa', 'FRANC' , 1 , '#419 // República Francesa' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 420, 'Gibraltar', 'GIBRA' , 1 , '#420 // Gibraltar' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 421, 'República Helénica', 'HELEN' , 1 , '#421 // República Helénica' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 422, 'República de Hungría', 'HUNGR' , 1 , '#422 // República de Hungría' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 423, 'República de Irlanda', 'IRLAN' , 1 , '#423 // República de Irlanda' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 424, 'República de Islandia', 'ISLAN' , 1 , '#424 // República de Islandia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 425, 'República Italiana', 'ITALI' , 1 , '#425 // República Italiana' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 426, 'República de Letonia', 'LETON' , 1 , '#426 // República de Letonia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 427, 'Principado de Liechtenstein', 'LIECH' , 1 , '#427 // Principado de Liechtenstein' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 428, 'República de Lituania', 'LITUA' , 1 , '#428 // República de Lituania' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 429, 'Gran Ducado de Luxemburgo', 'LUXEM' , 1 , '#429 // Gran Ducado de Luxemburgo' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 430, 'Antigua República Yugoslava de Macedonia', 'MACED' , 1 , '#430 // Antigua República Yugoslava de Macedonia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 431, 'República de Malta', 'MALTA' , 1 , '#431 // República de Malta' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 433, 'República de Moldavia', 'MOLDA' , 1 , '#433 // República de Moldavia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 434, 'Principado de Mónaco', 'MÓNAC' , 1 , '#434 // Principado de Mónaco' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 435, 'Reino de Noruega', 'NORUE' , 1 , '#435 // Reino de Noruega' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 436, 'Reino de los Países Bajos', 'PBAJO' , 1 , '#436 // Reino de los Países Bajos' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 437, 'República de Polonia', 'POLON' , 1 , '#437 // República de Polonia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 438, 'República Portuguesa', 'PORTU' , 1 , '#438 // República Portuguesa' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 439, 'Reino Unido de Gran Bretaña e Irlanda', 'RUNID' , 1 , '#439 // Reino Unido de Gran Bretaña e Irlanda' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 440, 'República Checa', 'CHECA' , 1 , '#440 // República Checa' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 441, 'Rumania', 'RUMAN' , 1 , '#441 // Rumania' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 442, 'Federación de Rusia', 'RUSIA' , 1 , '#442 // Federación de Rusia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 443, 'República de San Marino', 'SMARI' , 1 , '#443 // República de San Marino' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 444, 'Estado de la Ciudad del Vaticano', 'VATIC' , 1 , '#444 // Estado de la Ciudad del Vaticano' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 445, 'Reino de Suecia', 'SUECI' , 1 , '#445 // Reino de Suecia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 446, 'Confederación Suiza', 'SUIZA' , 1 , '#446 // Confederación Suiza' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 447, 'Ucrania', 'UCRAN' , 1 , '#447 // Ucrania' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 452, 'República de Serbia', 'SERBI' , 1 , '#452 // República de Serbia' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 453, 'República de Montenegro', 'MONTE' , 1 , '#453 // República de Montenegro' , 1,400
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 501, 'Commonwealth de Australia', 'ASTRL' , 1 , '#501 // Commonwealth de Australia' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 503, 'Islas Cook', 'ICOOK' , 1 , '#503 // Islas Cook' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 505, 'Guam', 'GUAM' , 1 , '#505 // Guam' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 507, 'República de Kiribati', 'KIRIB' , 1 , '#507 // República de Kiribati' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 512, 'Islas Marianas del Norte', 'IMARN' , 1 , '#512 // Islas Marianas del Norte' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 513, 'República de las Islas Marsha', 'IMARS' , 1 , '#513 // República de las Islas Marsha' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 514, 'Estados Federados de Micronesia', 'EFMIC' , 1 , '#514 // Estados Federados de Micronesia' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 516, 'República de Nauru', 'NAURU' , 1 , '#516 // República de Nauru' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 517, 'Niue', 'NIUE' , 1 , '#517 // Niue' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 520, 'Nueva Zelanda', 'NVAZE' , 1 , '#520 // Nueva Zelanda' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 522, 'Isla Wake', 'IWAKE' , 1 , '#522 // Isla Wake' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 523, 'Estado Independiente de Papúa Nueva Guinea', 'NVAGU' , 1 , '#523 // Estado Independiente de Papúa Nueva Guinea' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 524, 'islas Pitcairn', 'IPITC' , 1 , '#524 // islas Pitcairn' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 526, 'Islas Salomón', 'ISALO' , 1 , '#526 // Islas Salomón' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 527, 'Estado Independiente de Samoa', 'SAMOA' , 1 , '#527 // Estado Independiente de Samoa' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 528, 'Samoa Americana', 'SAMAM' , 1 , '#528 // Samoa Americana' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 530, 'Tokelau', 'TOKEL' , 1 , '#530 // Tokelau' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 531, 'Reino de Tonga', 'TONGA' , 1 , '#531 // Reino de Tonga' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 532, 'Tuvalu', 'TUVAL' , 1 , '#532 // Tuvalu' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 533, 'República de Vanuatu', 'VANUA' , 1 , '#533 // República de Vanuatu' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 534, 'Territorio de las Islas Walli', 'IWALL' , 1 , '#534 // Territorio de las Islas Walli' , 1,500
EXECUTE [dbo].[PG_CI_COUNTRY] 0, 139, 535, 'República de Las Islas Fiji', 'IFIJI' , 1 , '#535 // República de Las Islas Fiji' , 1,500



GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
