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
                    <h1>Api Hospitales Azure</h1>
                    <label>Id Hospital</label>
                    <input type="text" id="cajahospital"
                           class="form-control"/>
                    <button type="button" class="btn btn-info" id="botonbuscarhospital">
                        Buscar Hospital
                    </button>
                    <hr/>
                    <table class="table table-info" id="tablahospitales">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Camas</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div id="hospital"></div>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
        <script>
            var url = "https://apihospitalesxml.azurewebsites.net/";
            $(document).ready(function(){
                //LAS PETICIONES SEGUIRAN SIENDO MEDIANTE URL
                //PERO LA URL SUELE SER LA MISMA PARA TODAS LAS PETICIONES
                //LO QUE CAMBIA ES EL REQUEST, ES DECIR, LOS DATOS QUE
                //DESEAMOS RECUPERAR.
                //NORMALMENTE, SE DECLARA LA URL A NIVEL DE SCRIPT
                //PARA TODOS LOS METODOS
                $.ajax({
                    url: url + "api/hospitales",
                    type: "GET",
                    dataType: "xml", 
                    success: function(data){
                        var hospitales = $(data).find("Hospital");
                        var html = "";
                        hospitales.each(function(){
                            var nombre = $(this).find("Nombre").text();
                            var direccion = $(this).find("Direccion").text();
                            var tlf = $(this).find("Telefono").text();
                            var camas = $(this).find("Camas").text();
                            html += "<tr>";
                            html += "<td>" + nombre + "</td>";
                            html += "<td>" + direccion + "</td>";
                            html += "<td>" + tlf + "</td>";
                            html += "<td>" + camas + "</td>";
                            html += "</tr>";
                        });
                        $("#tablahospitales tbody").html(html);
                    }
                });
                
                $("#botonbuscarhospital").click(function(){
                    var id = $("#cajahospital").val();
                    //ANTES, HEMOS ESTADO LEYENDO TODOS LOS DATOS DE LOS
                    //ELEMENTOS, BUSCANDO COINCIDENCIAS.
                    //ESO NO ESTA MAL, PERO EN LOS SERVICIOS (SI LO TIENEN)
                    //SUELEN EXISTIR METODOS DE BUSQUEDA
                    //SI LO TIENEN, LO MEJOR ES LLAMARLOS Y SINO, COMO LO 
                    //HEMOS REALIZADO ANTES, BUSCANDO EN LOS DOCUMENTOS.
                    var request = "api/hospitales/" + id;
                    $.ajax({
                       url: url + request,
                       type: "GET",
                       dataType: "xml",
                       success: function(data){
                           var hospital = $(data).find("Hospital").first();
                           var html = "<h1 style='color:red'>"
                           + $(hospital).find("Nombre").text() 
                           + ", " 
                           + $(hospital).find("Direccion").text()
                           + "</h1>";
                           $("#hospital").html(html);
                       }
                    });
                });
            });
        </script>
    </body>
</html>
