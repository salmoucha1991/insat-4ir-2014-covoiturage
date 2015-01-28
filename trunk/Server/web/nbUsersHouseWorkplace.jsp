
<%@page import="covoit.Workplaces"%>
<%@page import="covoit.City"%>
<%@page import="java.util.ArrayList" %>
<%@page import="covoit.Admin" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SOPRA Covoiturage</title>
    </head>
    <body>
        <h1 style="text-align:center;">SOPRA CoVoiturage</h1>
        <h3 style="text-align:center;">Rapports - Nombre d'utilisateurs par couples Domicile/Travail</h3>
        <br />
        <br />
        <h4 style="text-align:center;">Veuillez sélectionner un lieu de travail et une ville</h4>
        <div style="text-align:center;">

            <%
            ArrayList<Workplaces> liste = (ArrayList<Workplaces>) Admin.loadPlaces();
            ArrayList<City> liste2 = (ArrayList<City>) Admin.loadCity();
            %>
            <form action="SearchServlet" method="post">
                <select name="placeSelected">
                    <option value="0" selected>-- choisissez un lieu de travail</option>
                    <%
                    for (int i=0; i<liste.size(); i++)
                    {
                        int item0 = liste.get(i).getId();
                        String item1 = liste.get(i).getName();
                        String item2 = liste.get(i).getAddress();
                    %>
                    <option value="<%=item0%>"><%=item1+" - "+item2%></option>
                    <% } %>
                </select>
                <br>
                <select name="citySelected">
                    <option value="0" selected>-- choisissez un domicile</option>
                    <%
                    for (int i=0; i<liste2.size(); i++)
                    {
                        int item1 = liste2.get(i).getId();
                        String item2 = liste2.get(i).getName();
                        String item3 = liste2.get(i).getZip();
                    %>
                    <option value="<%=item1%>"><%=item2+"("+item3+")"%></option>
                    <% } %>
                </select>
                <br>
                        <input type="submit" value="Recherche" />
            </form>
            <%
                String erreur = (String) request.getAttribute("erreur");
                if (erreur != null) {
                    out.print(String.format("Erreur: %s", erreur));
                }
            %>
        </div>
        <div>
            <%
                int city = Integer.parseInt(request.getParameter("citySelected"));
                int place = Integer.parseInt(request.getParameter("placeSelected"));
                int nbRoutes = Admin.nbrUserstoWorkplace(city, place);
                out.print("<p>Il y a " + nbRoutes + " routes qui correspondent.</p>");
            %>
        </div> 
        <br/>
        <br/>
        <br/>
        <p><a href="content.jsp">Retour</a></p>
    </body>
</html>