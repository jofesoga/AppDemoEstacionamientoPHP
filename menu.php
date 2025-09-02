<?php
if (isset($_COOKIE["iduser"])) {
	mysql_connect("mysql","appuser","txori4737" ) or die("No se pudo conectar: " . mysql_error());
    mysql_select_db("estacionamiento");
	$ConsultaFoliosSinCobrar="SELECT COUNT(*) FROM carros WHERE Cobrado=0";
	$FoliosSinCobrar=mysql_query("$ConsultaFoliosSinCobrar");
	$RegistrosFoliosAbiertos=mysql_fetch_array($FoliosSinCobrar);
	$FoliosAbiertos=$RegistrosFoliosAbiertos[0];
	$htmlcode='<span style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">Folios Abiertos : '.$FoliosAbiertos.'</span><br><br>';	
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title></title>
</head>
<body>'.$htmlcode.'<span style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">Usuario Registrado : '.$_COOKIE["UserName"].'</span><div style="text-align: center;"><big><big><big><span
 style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;"><br>
<br>
Menu Principal</span></big></big></big><br
 style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
 <br
 style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
<a href="./ingreso.php"><span
 style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">Ingresar
Vehiculo</span></a><br
 style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
<br style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
<a href="./salida.php">
<span style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">Sale
Vehiculo</span></a><br
 style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
<br style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
<a href="./cierre.php">
<span style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">Cierre
De Caja</span></a><br
 style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
<br style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
<span style="color: rgb(0, 0, 102);  font-family: Calibri;font-weight: bold;">Reporte
X Dia</span>
<br style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
<br style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">
</a><a href="./close.php">
<span style="color: rgb(0, 0, 102); font-family: Calibri; font-weight: bold;">Cerrar Sesion</span></div> </body>
</html>';
} else {
echo 'Necesita Iniciar Sesion ';
}

?>