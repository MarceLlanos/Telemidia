<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="descritores" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">  

<head>
	<!--Referencia a regiones base. -->
	<regionBase>
		<importBase alias="reg" documentURI="regiones.ncl" />
	</regionBase>
		
	<!--Descriptor base -->
	<descriptorBase>
		<descriptor id="desVideo"   region="reg#regionVideo"/>
		<descriptor id="desInfoBtn" region="reg#regionInfBtn"/>
		
		<descriptor id="desBg"     region="reg#regionBg"/>
		<descriptor id="desFuente" region="reg#regionFuente"/>
		<descriptor id="desColor"  region="reg#regionColor"/>
		<descriptor id="desHtml"   region="reg#regionHtml">
			<descriptorParam name="scroll" value="horizontal"/>
		</descriptor>
			
		<descriptor id="desSalir"  region="reg#regionSalir"/>
		
		<descriptor id="desMenuBg" region="reg#regionMenuBg"/>
		<descriptor id="desPq"     region="reg#regionBtnPq"/>
		<descriptor id="desMd"     region="reg#regionBtnMd"/>
		<descriptor id="desGd"     region="reg#regionBtnGd"/>
		<descriptor id="desSl"     region="reg#regionBtnSl"/>
		
		<descriptor id="desSelPq"  region="reg#regionSelBtnPq"/>
		<descriptor id="desSelMd"  region="reg#regionSelBtnMd"/>
		<descriptor id="desSelGd"  region="reg#regionSelBtnGd"/>
		<descriptor id="desSelSl"  region="reg#regionSelBtnSl"/>
	</descriptorBase>		
</head>
</ncl>