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
                    <div id="divbotones">
                        
                    </div>
                    <button type="button" class="btn btn-outline-info"
                            id="botondoctores" value="22">
                        Doctores La Paz
                    </button>
                    <table class="table table-info" id="tablahospitales">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Camas</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div id="hospital"></div>
                    <ul class="list-group" id="doctores"></ul>
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
                            html += "<td>";
                            //SI DESEAMOS QUE CONTROLES DIBUJADOS DINAMICAMENTE TENGAN
                            //EVENTOS, DEBEMOS GENERAR CONTROLES CON JQUERY
                            //NO HACIENDO UN STRING, QUE ES LO QUE HEMOS HECHO ANTES.
                            //PARA CREAR CONTROLES, SE UTILIZA LA SIGUIENTE SINTAXIS:
                            //var control = $("<TAG>")
                            var boton = $("<button>");
                            //AL CONTROL, PODEMOS AGREGAR TODO LO QUE DESEEMOS
                            //UNA CLASE DE ESTILO
                            boton.addClass("btn btn-success");
                            //PODEMOS AGREGAR UN TEXTO
                            boton.text("Doctores de " + nombre);
                            //UN VALUE
                            boton.val($(this).find("IdHospital").text());
                            //PERO, LO QUE LE FALTA AL BOTON ES UNA ACCION (click)
                            boton.click(function()  {
                               //ACCIONES
                               //QUE QUEREMOS HACER CUANDO PULSEMOS UN BOTON??
                               //MOSTRAR LOS DOCTORES...DE UN HOSPITAL
                               var idhospital = $(this).val();
                               //PARA NO TENER TANTO CODIGO EN UN MISMO SITIO
                               //PODEMOS CREAR UNA FUNCION QUE DIBUJARA LOS DOCTORES
                               mostrarDoctoresHospital(idhospital);
                            });
                            //DIBUJAR EL BOTON EN ALGUN LUGAR, SE REALIZA MEDIANTE
                            // Parent.append(control);
                            $("#divbotones").append(boton);
                            //LA RAZON PORQUE NO DIBUJA EL BOTON EN LA TABLA
                            //1) AÑADE EL BOTON A LA TABLA
                            //$("#tablahospitales tbody").append(boton);
                            html += "</td>";
                            html += "</tr>";
                        });
                        //2) QUE HACEMOS EN LA SIGUIENTE LINEA????
                        //ESTA LINEA PONE EL CONTENIDO HTML DENTRO DE LA TABLA
                        //CON LO CUAL, QUITA LOS BOTONES...
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
                
                $("#botondoctores").click(function() {
                   //NECESITAMOS EL CODIGO DE HOSPITAL
                   //RECUPERAMOS EL CODIGO DEL BOTON PULSADO
                   var idhospital = $(this).val();
                   //NECESITAMOS SABER LA PETICION DONDE ESTARAN LOS DOCTORES
                   var request = "api/doctoreshospital/" + idhospital;
                   $.ajax({
                      url: url + request,
                      type: "GET",
                      dataType: "xml",
                      success: function(data){
                          var doctores = $(data).find("Doctor");
                          var html = "";
                          doctores.each(function() {
                             html += "<li class='list-group-item'>" 
                             + $(this).find("Apellido").text() + "</li>";
                          });
                          $("#doctores").html(html);
                      }
                   });
                });
            });
            
            function mostrarDoctoresHospital(idhospital){
                //NECESITAMOS SABER LA PETICION DONDE ESTARAN LOS DOCTORES
                   var request = "api/doctoreshospital/" + idhospital;
                   $.ajax({
                      url: url + request,
                      type: "GET",
                      dataType: "xml",
                      success: function(data){
                          var doctores = $(data).find("Doctor");
                          var html = "";
                          doctores.each(function() {
                             html += "<li class='list-group-item'>" 
                             + $(this).find("Apellido").text() + "</li>";
                          });
                          $("#doctores").html(html);
                      }
                   });
            }
        </script>
    </body>
</html>
