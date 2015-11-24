<!-- boutique.jsp -->
<html>
  <head>
    <title>Compteurs et Objets</title>
    <%@ page import="java.util.*" %>
    <%@ page session="true" %>
    <%@ page errorPage="erreur.jsp" %>
    <%@ page contentType="text/html; charset=UTF-8" %>
  </head>
  <body>
    <% 
       // initialisation du panier
       HashMap<String,Integer> panier=(HashMap<String,Integer>)session.getAttribute("panier");
       if (panier==null)
       { panier=new HashMap<String,Integer>();
       session.setAttribute("panier",panier);
       }

       panier.put("chaise",400);
       panier.put("velo",250);
       %>
    <h1>
    <Table>
	<% for (Map.Entry<String,Integer> entry : panier.entrySet() ) {%>
	<tr>
		<td> <%=entry.getKey() %> </td>
		<td> <%=entry.getValue() %> </td>
    	</tr>
	<% } %>
    </Table>	
    </h1>
  </body>
</html>