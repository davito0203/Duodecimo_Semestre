var fs     = require('fs');
var server = require("./server");
var router = require("./router");
var ADC_DEV_NAME = '/proyecto/salida';

function iniciar(response) {
  console.log("Manipulador de Peticion 'iniciar' fue llamado.");
  fs.writeFile(ADC_DEV_NAME, "Y" );
  
  var body = '<html>'+
    '<head>'+
    '<title>Digital Oscilloscope - Embedded Systems</title>'+
    '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'+
    '<link href="http://192.168.50.1/lib/examples.css" rel="stylesheet" type="text/css">'+
    '<script language="javascript" type="text/javascript" src="http://192.168.50.1/lib/jquery.js"></script>'+
    '<script language="javascript" type="text/javascript" src="http://192.168.50.1/lib/jquery.flot.js"></script>'+
    '</head>'+
    '<body>'+
    '<div id="header">'+
    '<h3>Osciloscopio Digital - Sistemas Embebidos</h3>'+
    '</div>'+

    '<div id="content">'+

'<b>Presentaci&oacuten</b>'+
'<br/>'+
'<br/>'+

'<p>Mediante esta aplicaci&oacuten se pretende facilitar la realizaci&oacuten de pr&aacutecticas de laboratorio de F&iacutesica en colegios.'+ 
' Esta p&aacutegina funciona como un osciloscopio digital, la tarjeta a la cual est&aacute asociada la p&aacutegina se encarga de realizar'+
' la adquisici&oacuten de datos y el env&iacuteo de los mismos para que sean graficados en este lugar.</p>'+
'<br/>'+

'<p>Por favor conecte el dispositivo de medici&oacuten a los terminales del circuito que desea probar. Una vez haya verificado que las '+
'conexiones realizadas son correctas y que los valores esperados a la salida no sobrepasan los rangos de operaci&oacuten del dispositivo '+ 'oprima el bot&oacuten <b><i>Graficar Salida</i></b> para que la adquisici&oacuten de datos comience. Este bot&oacuten lo llevara a una nueva '+ 'p&aacutegina donde usted podr&aacute observar la señal de salida medida de su circuito.</p>'+
'<br/>'+

    '<p>'+
    '<form action="/subir" method="post">'+
    '<input type="submit" value="Graficar Salida" FONT-SIZE= 12px />'+
    '</form>'+
    '</p>'+
    '</div>'+    
    '</body>'+
    '</html>';
  
response.writeHead(200, {"Content-Type": "text/html"});
response.write(body);
response.end();
}
 

function subir(response,output) {
  console.log("Manipulador de Peticion 'subir' fue llamado.");
  console.log("Taking Samples from ADC: ");
  fs.writeFile(ADC_DEV_NAME, "Y" );

  var body = '<html>'+
'<head>'+
'        <title>Results: Graphs</title>'+
'        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">'+
'        <link href="http://192.168.50.1/lib/examples.css" rel="stylesheet" type="text/css">'+
'        <script language="javascript" type="text/javascript" src="http://192.168.50.1/lib/jquery.js"></script>'+
'        <script language="javascript" type="text/javascript" src="http://192.168.50.1/lib/jquery.flot.js"></script>'+
'        <script type="text/javascript">'+

'        $(function() {'+

'                var options = {'+
'                        lines: {'+
'                                show: true'+
'                        },'+
'                        points: {'+
'                                show: true'+
'                        },'+
'                        xaxis: {'+
'                                tickDecimals: 0,'+
'                                tickSize: 1'+
'                        }'+
'                };'+

'                var data = [];'+
'                $.plot("#placeholder", data, options);'+

                // Fetch one series, adding to what we already have
'                var alreadyFetched = {};'+

'                $("button.fetchSeries").click(function () {'+

'                        var button = $(this);'+

                       // Find the URL in the link right next to us, then fetch the data
'                        var dataurl = button.siblings("a").attr("href");'+

'                        function onDataReceived(series) {'+

                                // Extract the first coordinate pair; jQuery has parsed it, so
                                // the data is now just an ordinary JavaScript object
'                                var firstcoordinate = "(" + series.data[0][0] + ", " + series.data[0][1] + ")";'+
'                                button.siblings("span").text("Fetched " + series.label + ", first point: " + firstcoordinate);'+

                                // Push the new data onto our existing data array
'                                if (!alreadyFetched[series.label]) {'+
'                                        alreadyFetched[series.label] = true;'+
'                                        data.push(series);'+
'                                }'+

'                                $.plot("#placeholder", data, options);'+
'                        }'+

'                        $.ajax({'+
'                                url: dataurl,'+
'                                type: "GET",'+
'                                dataType: "json",'+
'                                success: onDataReceived'+
'                        });'+
'                });'+

		// Load the first series by default, so we don't have an empty plot
'               $("button.fetchSeries:first").click();'+
'        });'+
'        </script>'+
'</head>'+

'<body>'+

'        <div id="header">'+
'                <h2>Resultados - Gr&aacuteficas</h2>'+
'        </div>'+

'        <div id="content">'+

'                <div class="demo-container">'+
'                        <div id="placeholder" class="demo-placeholder"></div>'+
'                </div>'+

'                <p>'+

'                        <button class="fetchSeries">Graficar</button>'+
'                        [ <a href="http://192.168.50.1/data.json" target="_blank">		see data</a> ]'+
'                        <span></span>'+
'                </p>'+

'                <p>'+
'                        <button class="back">Actualizar Datos</button>'+
'                        [ <a href="/salir">reload</a> ]'+
'                </p>'+
'        </div>'+

'</body>'+
'</html>';
response.writeHead(200, {"Content-Type": "text/html"});
response.write(body); 
response.end();
}


function salir(response) {
  console.log("Manipulador de Peticion 'iniciar' fue llamado.");
  fs.writeFile(ADC_DEV_NAME, "Q" );
  subir(response);
}

var handle = {}
handle["/"] = iniciar;
handle["/iniciar"] = iniciar;
handle["/subir"] = subir;
handle["/salir"]=salir;
server.iniciar(router.route, handle);
