function mostrarPares() {
    var html = "<table border='1'>";
    for (var i = 2; i <= 20; i += 2) {
        html += "<tr>";
        html += "<td>Par</td>";
        html += "<td>" + i + "</td>";
        html += "</tr>";
    }
    html += "</table>";
    var resultado = document.getElementById("resultado");
    resultado.innerHTML = html;
}

