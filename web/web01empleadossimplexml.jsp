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
                    <h1>Empleados XML</h1>
                    <button type="button" class="btn btn-info"
                            id="botoncargar">
                        Cargar empleados XML
                    </button>
                    <ul class="list-group" id="listaempleados">
                        
                    </ul>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
        <script>
            $(document).ready(function(){
                $("#botoncargar").click(function(){
                      //COMENZAMOS LA LECTURA DEL DOCUMENTO
                      $.get("documents/empleados.xml", function(data){
                          //data ES EL DOCUMENTO XML
                          var apellidos = $(data).find("APELLIDO");
                          //PARA RECORRER TODOS LOS APELLIDOS, SE UTILIZAN BUCLES
                          //EACH
                          var html = "";
                          apellidos.each(function(){
                              //this HACE REFERENCIA A CADA ETIQUETA XML
                              //DEL DOCUMENTO.  DEBEMOS RECUPERAR SU CONTENIDO CON text()
                              var apellido = $(this).text();
                              html += "<li class='list-group-item'>" + apellido + "</li>";
                          });
                          $("#listaempleados").html(html);
                      });
                });
            });
        </script>
    </body>
</html>
