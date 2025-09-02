<html>
<head>
<title> Sale Vehiculo</title>
</head>
<body>
<?php
if (isset($_COOKIE["iduser"])){
	$htmlcode="";
    mysql_connect("127.0.0.1","root","" ) or die("No se pudo conectar: " . mysql_error());
    mysql_select_db("estacionamiento");
	$ConsultaCajasAbiertas="SELECT COUNT(*) FROM caja WHERE Cerrada=0";
	$ConsultaFoliosSinCobrar="SELECT COUNT(*) FROM carros WHERE Cobrado=0";
	$FoliosSinCobrar=mysql_query("$ConsultaFoliosSinCobrar");
	$RegistrosFoliosAbiertos=mysql_fetch_array($FoliosSinCobrar);
	$FoliosAbiertos=$RegistrosFoliosAbiertos[0];
	$ConsultaFolio="SELECT * FROM carros WHERE IdFolio=".$_POST["NumDFolio"]." AND Cobrado=0";
    $RecordSetFolios=mysql_query($ConsultaFolio);
	$htmlcode.='Folios Abiertos: '.$FoliosAbiertos.'<br><br><br><br><br>';
	if ($RegistrosCarros=mysql_fetch_array($RecordSetFolios)){
	   $RecordsCajaAbierta=mysql_query($ConsultaCajasAbiertas);
	   $CajaAbierta=mysql_fetch_array($RecordsCajaAbierta);
       if ($CajaAbierta[0] > 0) {
		   
	   } else {
         $htmlcode='No habia caja abierta, se inicio apertura. <br><br>';		   
	     $ConsultaInsertCaja="INSERT INTO caja (IdUsuario,FechaApertura) VALUES ('".$_COOKIE["iduser"]."',NOW())";
		 mysql_query($ConsultaInsertCaja);
	   }
        $ConsultaCierreFolio="UPDATE carros SET FechaSalida=NOW(), UsuarioCerro='".$_COOKIE["iduser"]."' WHERE IdFolio=".$_POST["NumDFolio"];
        if ($CierreFolio=mysql_query($ConsultaCierreFolio)) {
           $ConsultaFolio="SELECT * FROM carros WHERE idFolio=".$_POST["NumDFolio"];
           $RecordSetFolios=mysql_query($ConsultaFolio);
           if ($RegistrosCarros=mysql_fetch_array($RecordSetFolios)){
	          $htmlcode.='Folio:' .$RegistrosCarros["IdFolio"] .'<br> Fecha Entrada:'.$RegistrosCarros["FechaEntrada"].'<br> Fecha Salida'.$RegistrosCarros["FechaSalida"].'<br> Tiempo Total: '.$RegistrosCarros["MinutosReales"].'<br> Total Por Pagar'.$RegistrosCarros["Total"].'<br><br>';
			 $htmlcode.='<p>Cantidad Pagada:</p>
                         <input id="numb" type="number">
                        <button type="button" onclick="myFunction()">Calcular Cambio</button>
                        <p id="demo"></p> <script>
                        function myFunction() {
                        var x, text;
                       // Get the value of the input field with id="numb"
                       x = document.getElementById("numb").value;
                       // If x is Not a Number or less than one or greater than 10
                       if (isNaN(x)) {
                       text = "Entrada No Valida";
                       } else {
                       text = x-'.$RegistrosCarros["Total"].';
                       }
                       document.getElementById("demo").innerHTML = "Cambio Por Entregar: " + text;
                       }
                       </script>
					   <br><br><a href="./menu.php"><big style="font-family: Calibri;"><span
                        style="color: rgb(0, 0, 102); font-weight: bold;">Menu
                        Principal</span></big></a>';			
			  echo $htmlcode;       	     
           } else {
              $htmlcode='Registro no existe <br><a href="./menu.php"><big style="font-family: Calibri;"><span
                         style="color: rgb(0, 0, 102); font-weight: bold;">Menu
                         Principal</span></big></a>';
              echo $htmlcode;
           }
        } else {
	      $htmlcode.='Registro no se puede actualizar debido a '.mysql_error().'<br><a href="./menu.php"><big style="font-family: Calibri;"><span
                     style="color: rgb(0, 0, 102); font-weight: bold;">Menu
                     Principal</span></big></a>';
          echo $htmlcode;
	    }
	} else {
       $htmlcode='Este Numero De Folio Ya Esta Cerrado o No Existe <br><a href="./menu.php"><big style="font-family: Calibri;"><span
                  style="color: rgb(0, 0, 102); font-weight: bold;">Menu
                  Principal</span></big></a>';
       echo $htmlcode;		
	}
} else {
	echo 'Necesitas inicar sesion para continuar <br><a href="./index.php"><big style="font-family: Calibri;"><span
          style="color: rgb(0, 0, 102); font-weight: bold;">Iniciar
          Sesion</span></big></a>';
}
?>
</body>
</html>