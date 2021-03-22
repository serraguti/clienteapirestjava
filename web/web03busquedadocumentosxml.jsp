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
                    <h1>Búsqueda documentos XML</h1>
                    <label>Introduzca código Hospital: </label>
                    <input type="text" id="cajacodigo"
                           class="form-control"/>
                    <button type="button" class="btn btn-info" id="botonhospitales">
                        Buscar hospital atributo
                    </button>
                    <hr/>
                    <label>Introduzca apellido</label>
                    <input type="text" id="cajaapellido"
                           class="form-control"/>
                    <button type="button" class="btn btn-danger" id="botonempleados">
                        Buscar empleados tag
                    </button>
                    <hr/>
                    <div id="hospital"></div>
                    <div id="empleados"></div>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
        <script>
            $(document).ready(function(){
                $("#botonhospitales").click(function() {
                    $.get("documents/hospital_atributos.xml", function(data){
                       //DENTRO DE ESTOS DATOS, QUEREMOS EXTRAER LO QUE
                       //SEAN DE UN DETERMINADO HOSPITAL
                       var codigo = $("#cajacodigo").val();
                       //TAG[ATRIBUTO=VALOR]
                       var filtro = "HOSPITAL[HOSPITAL_COD=" + codigo + "]";
                       //DEBEMOS BUSCAR DENTRO DE DATA CON find()
                       //RECORDEMOS QUE SIEMPRE QUE BUSCAMOS, AUNQUE SEA
                       //SOLO 1, DEVUELVE UN CONJUNTO
                       var hospitales = $(data).find(filtro);
                       if (hospitales.length == 0){
                           $("#hospital").html("<h1 style='color:red'>No existen hospitales</h1>");
                       }else{
                           var hospital = hospitales.first();
                           $("#hospital").html("<h1 style='color:blue'>Nombre: "
                                   + hospital.attr("NOMBRE") 
                                   + ", Dirección: "
                                   + hospital.attr("DIRECCION")
                                   + "</h1>");
                       }
                    });
                });
                
                $("#botonempleados").click(function(){
                    console.log("boton pulsado");
                    //NUEVA TEORIA: AJAX
                    $.ajax({
                        url: "documents/empleados.xml",
                        method: "GET", 
                        dataType: "xml", 
                        success: function(data){
                            console.log("Dentro");
                            var ape = $("#cajaapellido").val();
                            var filtro = "APELLIDO:contains(" + ape + ")";
                            var empleados = $(data).find(filtro);
                            var html = "";
                            empleados.each(function(){
                               html += "<h1>" + $(this).text() + "</h1>";
                            });
                            $("#empleados").html(html);
                        }
                    });
                });
            });
        </script>
    </body>
</html>
