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
                    <h1>Coches básicos</h1>
                    <button type="button" class="btn btn-dark" id="botoncochesget">
                        Coches Get
                    </button>
                    <button type="button" class="btn btn-info" id="botoncochesajax">
                        Coches Ajax
                    </button
                    <br/>
                    <label>Introduzca búsqueda: </label>
                    <input type="text" id="cajamarca" class="form-control"/>
                    <button type="button" class="btn btn-success" id="botonbuscarcoches">
                        Buscar coches
                    </button>
                    <ul class="list-group" id="coches"></ul>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
        <script>
            $(document).ready(function() {
                $("#botoncochesget").click(function() {
                   $.get("documents/coches_basicos.xml", function(data){
                     console.log(("Dentro Get"));
                     var coches = $(data).find("MARCA");
                     var html = "";
                     coches.each(function() {
                         html += "<li class='list-group-item'>"
                         + $(this).text() + "</li>";
                     });
                     $("#coches").html(html);
                   });
                });
                
                $("#botoncochesajax").click(function() {
                   $.ajax({
                    url: "documents/coches_basicos.xml",
                    type: "GET",
                    dataType: "xml", 
                    success: function(data) {
                        console.log("Dentro Ajax");
                        var coches = $(data).find("MARCA");
                        var html = "";
                        coches.each(function(){
                            html += "<li class='list-group-item list-group-item-warning'>"
                            + $(this).text() + "</li>";
                        });
                        $("#coches").html(html);
                    }
                   });
                });
                
                $("#botonbuscarcoches").click(function() {
                    var marca = $("#cajamarca").val();
                    var filtro = "MARCA:contains(" + marca + ")";
                    $.ajax({
                       url: "documents/coches_basicos.xml",
                       method: "GET", 
                       dataType: "xml", 
                       success: function(data){
                           var coches = $(data).find(filtro);
                           var html = "";
                           coches.each(function() {
                              html += "<li class='list-group-item list-group-item-primary'>" 
                              + $(this).text() + "</li>";
                           });
                           $("#coches").html(html);
                       }
                    });
                });
            });
        </script>
    </body>
</html>
