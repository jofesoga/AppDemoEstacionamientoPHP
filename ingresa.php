<html>
<head>
<title> Ingresa Vehiculo</title>
</head>
<body>
<?php
if (isset($_COOKIE["iduser"])){
mysql_connect("127.0.0.1","root","" ) or die("No se pudo conectar: " . mysql_error());
mysql_select_db("estacionamiento");
$IdCajero=$_POST["Cajero"];
$PlacaVehiculo=$_POST["Placas"];
$Tipo=$_POST["TipoDeVehiculo"];
$NumeroFolio=$_POST["Folio"];
if ($Tipo<>"Bicicleta"){
$CostoHora=10;
} else {
$CostoHora=5;
}
$ConsultaCajaAbierta="SELECT * FROM caja WHERE Cerrada=0";
$CajasAbiertas=mysql_query($ConsultaCajaAbierta);
if ($arreglocajas=mysql_fetch_array($CajasAbiertas)) {
	$NumeroCaja=$arreglocajas["IdCierre"];
	$consultaINSERTVehiculo="INSERT INTO carros (IdUsuario,IdCliente,FechaEntrada,Placas,TipoVehiculo,CostoHora,IdCierre,IdCierreApertura) VALUES ('$IdCajero','1',NOW(),'$PlacaVehiculo','$Tipo','$CostoHora','$NumeroCaja','$NumeroCaja')";
	if (mysql_query($consultaINSERTVehiculo)){
	echo 'Folio Agregado Correctamente <br><a href="./menu.php"><big style="font-family: Calibri;"><span
 style="color: rgb(0, 0, 102); font-weight: bold;">Menu
Principal</span></big></a>';
	} else {echo 'Hubo un error '.mysql_error();}
} else {
	$ConsultaInsertCaja="INSERT INTO caja (IdUsuario,FechaApertura,FolioInicial) VALUES ('$IdCajero',NOW(),'$NumeroFolio')";
	if (mysql_query($ConsultaInsertCaja)) {
	$CajasAbiertas=mysql_query($ConsultaCajaAbierta);
	$arreglocajas=mysql_fetch_array($CajasAbiertas);
	$NumeroCaja=$arreglocajas["IdCierre"];
	$consultaINSERTVehiculo="INSERT INTO carros (IdUsuario,IdCliente,FechaEntrada,Placas,TipoVehiculo,CostoHora,IdCierre,IdCierreApertura) VALUES ('$IdCajero','1',NOW(),'$PlacaVehiculo','$Tipo','$CostoHora','$NumeroCaja',$NumeroCaja)";
	if (mysql_query($consultaINSERTVehiculo)){
	echo 'Folio Agregado Correctamente, por ser el primero se inicia  con apertura de caja <br><a href="./menu.php"><big style="font-family: Calibri;"><span
 style="color: rgb(0, 0, 102); font-weight: bold;">Menu
Principal</span></big></a>';
	} else { echo 'Hubo un error '.$NumeroCaja;}
	}
}
} else {
	echo 'Necesita iniciar sesion para poder continuar';
}
?>
</body>
</html>