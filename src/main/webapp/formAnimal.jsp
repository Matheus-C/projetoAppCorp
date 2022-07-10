<%@page import="javax.ws.rs.core.Response"%>
<%@page import="javax.ws.rs.client.Invocation"%>
<%@page import="javax.ws.rs.core.MediaType"%>
<%@page import="java.net.URI"%>
<%@page import="javax.ws.rs.client.ClientBuilder"%>
<%@page import="javax.ws.rs.client.Client"%>
<%@page import="javax.ws.rs.client.WebTarget"%>
<%@page import="javax.json.JsonReader"%>
<%@page import="javax.json.JsonArray"%>
<%@page import="javax.json.JsonObject"%>
<%@page import="java.io.StringReader"%>
<%@page import="javax.json.JsonReaderFactory"%>
<%@page import="javax.json.Json"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>
            Cadastre um pet
        </title>
    <jsp:include page="cabecalho.html"/>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <div class="row col">
            <div class="container col-sm-5">
                <img class="fixed-bottom" id="imgForm" src="midia/pets.jpg" alt="Pets">
            </div>
            <div class="container col-sm-7">
                <form method="post" action="/pets">
                    <label for="nome" class="form-label">Digite o nome do pet:</label>
                    <input type="text" name="nome" id="nome" class="form-control" required>

                    <label for="dataNascimento" class="form-label">Data de nascimento:</label>
                    <input type="date" name="dataNascimento" id="dataNascimento" class="form-control" required>

                    <label for="peso" class="form-label">Peso:</label>
                    <input type="text" name="peso" id="peso" class="form-control" required>

                    <label for="altura" class="form-label">Altura:</label>
                    <input type="text" name="altura" id="altura" class="form-control" required>

                    <label for="gastoMensal" class="form-label">Gasto mensal (aproximado):</label>
                    <input type="text" name="gastoMensal" id="gastoMensal" class="form-control" required>

                    <label for="obs" class="form-label">Observação:</label>
                    <textarea type="text" name="obs" id="obs" class="form-control" rows="3"></textarea>
                    
                    <%
                        //Iterar as variações e passar id como value
                        /*WebTarget wt;
                        Client client = ClientBuilder.newClient();
                        URI uri = new URI("http://localhost:8080/Adopet/sample/");
                        wt = client.target(uri);
                        wt.path("pets/variacoes");
                        Invocation.Builder builder = wt.request(MediaType.APPLICATION_JSON);
                        Response resposta = builder.get();
                        int status = resposta.getStatus();
                        String res = resposta.readEntity(String.class);*/
                        String res = "{\"variacoes\":[{\"id\":1,\"raca\":\"labrador\",\"porte\":\"grande\",\"especie\":\"cachorro\"},{\"id\":2,\"raca\":\"labrador\",\"porte\":\"médio\",\"especie\":\"cachorro\"}]}";
                        JsonReaderFactory factory = Json.createReaderFactory(null);
                        JsonReader jsonReader = factory.createReader(new StringReader(res));
                        JsonObject jsonObject = jsonReader.readObject();
                        JsonArray jsonArray = jsonObject.getJsonArray("variacoes");
                    %>
                    
                    <label for="idVariacao" class="form-label">Variação:</label>
                    <select name="idVariacao" id="idVariacao" class="form-select" required>
                        <option disabled selected value> -- Selecione uma opção -- </option>
                        <%
                            for (int i = 0; i < jsonArray.size(); i++) {
                                JsonObject obj = jsonArray.getJsonObject(i);
                                out.println("<option value=\""+ obj.getInt("id") + "\">"+obj.getString("especie")+" | "+obj.getString("raca")+" | "+obj.getString("porte")+"</option>");
                            }
                        %>
                    </select>

                    <label for="fotos" class="form-label">Fotos:</label>
                    <input type="text" name="fotos" id="fotos" class="form-control" required>
                    <small id="fotos-helptext" class="form-text text-muted">
                        Adicione os links para as fotos. Se houver mais de uma, separe os links por vírgula.
                    </small><br>

                    <input type="submit" name="sub" id="sub" class="btn btn-success mt-3">
                </form>
            </div>
        </div>
        <jsp:include page="scripts.html"/>
    </body>
</html>