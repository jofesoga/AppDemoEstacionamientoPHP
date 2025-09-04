<html>
<head>
<title> Sale Vehiculo</title>
</head>
<body>
<?php
if (isset($_COOKIE["iduser"])){
	$htmlcode="";
    mysql_connect("mysql","appuser","txori4737" ) or die("No se pudo conectar: " . mysql_error());
    mysql_select_db("estacionamiento");
	$Consulta="SELECT * FROM carros WHERE Cobrado=0"
	
} else {
	echo 'Necesitas inicar sesion para continuar <br><a href="./index.php"><big style="font-family: Calibri;"><span
          style="color: rgb(0, 0, 102); font-weight: bold;">Iniciar
          Sesion</span></big></a>';
}	
?>
</body>
</html>