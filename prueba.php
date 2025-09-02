<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
</head>
<body>
<h1></h1>
<p>Cantidad Pagada:</p>
<input id="numb" type="number">
<button type="button" onclick="myFunction()">Calcular</button>
<p id="demo"></p>
<script>
function myFunction() {
var x, text;
// Get the value of the input field with id="numb"
x = document.getElementById("numb").value;
// If x is Not a Number or less than one or greater than 10
if (isNaN(x)) {
text = "Entrada No Valida";
} else {
text = x-40;
}
document.getElementById("demo").innerHTML = text;
}
</script>
</body>
</html>
