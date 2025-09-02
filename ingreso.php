<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title></title>
</head>
<body>
<?php
if (isset($_COOKIE["iduser"])){
mysql_connect("mysql","appuser","txori4737" ) or die("No se pudo conectar: " . mysql_error());
mysql_select_db("estacionamiento");
$ConsultaFolios="SELECT COUNT(*) FROM carros";
$RCuantosFolios=mysql_query($ConsultaFolios);
$ACuantosFolios=mysql_fetch_array($RCuantosFolios);
$CuantosFolios=$ACuantosFolios[0]+1;
$codigoHTML='<form method="post" action="ingresa.php"
name="IngresaVehiculo">
<div style="text-align: center; font-weight: bold; font-family: Calibri; color: rgb(0, 0, 102);"><br>
<big>Ingreso De Vehiculo</big><br> </div>
<br style="color: rgb(0, 0, 102);"> <span style="color: rgb(0, 0, 102); font-weight: bold; font-family: Calibri;">
Cajero:  &nbsp;</span>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
&nbsp; &nbsp;
<input name="Cajero" value="'.$_COOKIE["iduser"].'"><br>
<span style="color: rgb(0, 0, 102); font-weight: bold; font-family: Calibri;">
<span style="font-family: Calibri;">Folio: &nbsp;  </span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
</span><input readonly="readonly" name="Folio" value=' .$CuantosFolios; $codigoHTML.='><br
 style="color: rgb(0, 0, 102); font-weight: bold; font-family: Calibri;">
<span style="color: rgb(0, 0, 102); font-weight: bold; font-family: Calibri;">
<span style="font-family: Calibri;">Fecha y Hora:</span>
&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<input readonly="readonly" name="Fecha" value=' .date("d-M-Y");
$codigoHTML.="," .date("H:i:s");
$codigoHTML.='> </span><br
style="color: rgb(0, 0, 102); font-weight: bold; font-family: Calibri;">
<span style="color: rgb(0, 0, 102); font-weight: bold; font-family: Calibri;">Placas:</span>
<span style="font-family: Calibri;"> </span>&nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
&nbsp;&nbsp;
<input name="Placas" value="0"><br>
<br style="font-weight: bold;">
<span style="font-family: Calibri; color: rgb(0, 0, 102); font-weight: bold;">Tipo
De Vehiculo: </span>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<style="font-weight: bold;">
  <select style="font-family: Calibri;"
 name="TipoDeVehiculo">
  <option>Automovil</option>
  <option>Motocicleta</option>
  <option>Bicicleta</option>
  </select>
  <br>
  <br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;&nbsp; &nbsp; &nbsp; <input value="Aceptar"
 type="submit">
</form><br><br><a href="./menu.php"><style="font-family: Calibri;"><span
 style="color: rgb(0, 0, 102); font-weight: bold;">Regresar Al Menu
Principal</span></a>';
echo $codigoHTML;
} else {
	echo 'Necesita iniciar sesion para poder continuar';
}

?>
</body>
</html>
