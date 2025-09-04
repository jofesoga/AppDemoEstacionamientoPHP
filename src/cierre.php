<?php
if (isset($_COOKIE["iduser"])) {
$htmlcode='<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title></title>
</head>
<body>
<br>
<br>
<br>
<br>
<form method="post" action="./cerrarcaja.php"
 name="cierrecaja"><span
 style="color: rgb(0, 0, 102); font-weight: bold; font-family: Calibri;">Ingresar Cantidad De Efectivo:</span>&nbsp;<input
 name="efectivo"> &nbsp;&nbsp; <input type="submit" value="Ok"></form>
 <br>
 <br>
 <a href="./menu.php"><big style="font-family: Calibri;"><span
 style="color: rgb(0, 0, 102); font-weight: bold;">Regresar Al Menu Principal</span></big></a>
</body>
</html>';
echo $htmlcode;
}else {
$htmlcode='Necesita Iniciar Sesion';
echo $htmlcode;
}
?>