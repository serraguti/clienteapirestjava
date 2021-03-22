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
                    <h1>Hospital XML Atributos</h1>
                    <button type="button" id="botonhospitales"
                        class="btn btn-success">
                            Cargar hospitales
                    </button>
                    <table id="tablahospitales" class="table table-bordered">
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
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
        <script>
            $(document).ready(function(){
                $("#botonhospitales").click(function(){
                    $.get("documents/hospital_atributos.xml", function(data){
                        var hospitales = $(data).find("HOSPITAL");
                        var html = "";
                        hospitales.each(function(){
                            html += "<tr>";
                            html += "<td>" + $(this).attr("NOMBRE") + "</td>";
                            html += "<td>" + $(this).attr("DIRECCION") + "</td>";
                            html += "<td>" + $(this).attr("TELEFONO") + "</td>";
                            html += "<td>" + $(this).attr("NUM_CAMA") + "</td>";
                            html += "</tr>";
                        });
                        $("#tablahospitales tbody").html(html);
                    });                  
                });
            });
        </script>
    </body>
</html>
