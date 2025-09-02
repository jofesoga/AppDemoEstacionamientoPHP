<?php
if (isset($_COOKIE["iduser"])) {
	mysql_connect("127.0.0.1","root","" ) or die("No se pudo conectar: " . mysql_error());
    mysql_select_db("estacionamiento");
	$ConsultaObtenerCajaAbierta="SELECT * FROM caja WHERE Cerrada=0";
	$RecordsCaja=mysql_query($ConsultaObtenerCajaAbierta);
  if ($RecordSetsCaja=mysql_fetch_array($RecordsCaja)){
      $IdCaja=$RecordSetsCaja["IdCierre"];	   
	  $ConsultaCierre="UPDATE caja SET FechaCierre=NOW(), IdUsuarioCerro='".$_COOKIE["iduser"]."' , DineroRecibido=".$_POST["efectivo"]." WHERE Cerrada=0";
	 if ($CajaCerradaBien=mysql_query($ConsultaCierre)) {
	    $ConsultaObtenerCajaCerrada="SELECT * FROM caja WHERE IdCierre='".$IdCaja."'";
	    $RecordsCaja=mysql_query($ConsultaObtenerCajaCerrada);
	    $RecordSetsCajaActualizada=mysql_fetch_array($RecordsCaja);
        $htmlcode='Caja Cerrada Exitosamente
	    <br> IdCierre:'.$RecordSetsCajaActualizada["IdCierre"].'<br>Total Cobrado: '.$RecordSetsCajaActualizada["SaldoFinal"].'<br><a href="./menu.php"><big style="font-family: Calibri;"><span
        style="color: rgb(0, 0, 102); font-weight: bold;">Menu
        Principal</span></big></a>';
        echo $htmlcode;
	 } else {
	    $htmlcode='No fue posible cerrar caja '.$IdCaja.'<br>'.mysql_error().'<br><a href="./menu.php"><big style="font-family: Calibri;"><span
        style="color: rgb(0, 0, 102); font-weight: bold;">Menu
        Principal</span></big></a>';
        echo $htmlcode; 	
	 } 
  } else {
	 $htmlcode='No hay cajas pendientes por cerrar <br><a href="./menu.php"><big style="font-family: Calibri;"><span
     style="color: rgb(0, 0, 102); font-weight: bold;">Menu
     Principal</span></big></a>';
     echo $htmlcode;  
   }	
}else {
  $htmlcode='Necesita Iniciar Sesion  <br><a href="./menu.php"><big style="font-family: Calibri;"><span
  style="color: rgb(0, 0, 102); font-weight: bold;">Menu
  Principal</span></big></a>';
  echo $htmlcode;
}
?>