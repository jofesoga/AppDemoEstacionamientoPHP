<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title></title>
</head>
<body>
<?php
mysql_connect("mysql","appuser","txori4737" ) or die("No se pudo conectar: " . mysql_error());
mysql_select_db("estacionamiento");
$ConsultaUsuarios="SELECT * FROM cajeros";
$usuarios=mysql_query($ConsultaUsuarios);
$MiCodigoHTML='<form method="post" action="sesion.php"
 name="iniciosesion"><br>
  <div
 style="text-align: center; color: rgb(0, 0, 102); font-family: Calibri;"><span
 style="font-weight: bold;">SISTEMA PARA CONTROL DEL
ESTACIONAMIENTO</span><br>
  </div>
  <br>
  <br>
  <br>
  <br>
  <div style="text-align: center; font-family: Calibri; color: rgb(0, 0, 102);">Usuario:
  <select style="font-family: Calibri;"
 name="NombreUsuario">';
 while ($fila=mysql_fetch_array($usuarios)){
	 $MiCodigoHTML.='<option>' .$fila['Nombre'] .'</option>';
	 }
 $MiCodigoHTML.=' </select>
  <br>
  <br>
Clave: <input type="password" name="Password"><br>
  </div>
  <br>
  <br>
  <div style="text-align: center; font-family: Calibri; color: rgb(0, 0, 102);"><input
 value="Iniciar Sesion" type="submit">
  <br>
  </div>
  <br>
  <br>
  <br>
</form>';
echo $MiCodigoHTML;

?>
</body>
</html>
