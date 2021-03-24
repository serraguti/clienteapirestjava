<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Funciones Plantilla Xml</h1>
                    <ul class="list-group list-group-horizontal" id="funciones"></ul>
                    <ul class="list-group" id="plantillas"></ul>
                    <div id="detallesplantilla"></div>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
        <script>
            var url = "https://apihospitalesxml.azurewebsites.net/";
            $(document).ready(function(){
                $.ajax( {
                   url: url + "api/funciones",
                   type: "GET",
                   dataType: "xml",
                   success: function(data){
                       var funciones = $(data).find("string");
                       funciones.each(function(){
                          var funcion = $(this).text();
                          var li = $("<li>");
                          li.addClass("list-group-item");
                          $("#funciones").append(li);
                          var boton = $("<button>");
                          boton.text(funcion);
                          boton.addClass("btn btn-info");
                          boton.click(function() {
                              var fun = $(this).text();
                              cargarPlantillaFuncion(fun);
                          });
                          li.append(boton);
                       });
                   }
                });
            });
            
            function cargarPlantillaFuncion(funcion){
                $("#plantillas").html("");
                var request = "api/plantillafuncion/" + funcion;
                $.ajax({
                   url: url + request,
                   type: "GET",
                   dataType: "xml",
                   success: function(data){
                       var plantillas = $(data).find("Plantilla");
                       plantillas.each(function(){
                           var ape = $(this).find("Apellido").text();
                           var idplantilla = $(this).find("IdPlantilla").text();
                           var li = $("<li>");
                           li.addClass("list-group-item list-group-item-warning");
                           $("#plantillas").append(li);
                           var boton = $("<button>");
                           boton.text("Detalles " + ape);
                           boton.val(idplantilla);
                           boton.addClass("btn btn-danger");
                           boton.click(function(){
                              var id = $(this).val();
                              cargarDetallesPlantilla(id);
                           });
                           li.append(boton);
                       });
                   }
                });
            }
            
            function cargarDetallesPlantilla(idplantilla){
                var request = "api/plantilla/" + idplantilla;
                $.ajax({
                   url: url + request,
                   type: "GET",
                   dataType: "xml",
                   success: function(data){
                       var ape = $(data).find("Apellido").text();
                       var funcion = $(data).find("Funcion").text();
                       var salario = $(data).find("Salario").text();
                       var turno = $(data).find("Turno").text();
                       var html = "<h1>" + ape + ", Función: " + funcion + "</h1>";
                       html += "<h2>Salario: " + salario + "</h2>";
                       html += "<h2>Turno: " + turno + "</h2>";
                       $("#detallesplantilla").html(html);
                   }
                });
            }
            
        </script>
    </body>
</html>
