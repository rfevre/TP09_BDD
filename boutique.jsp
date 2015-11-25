<!-- boutique.jsp -->
<html>
  <head>
    <title>Panier client</title>
    <%@ page import="java.util.*" %>
    <%@ page import="java.sql.*" %>
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

       // connection à la base
       Class.forName("org.postgresql.Driver");
       String url = "jdbc:postgresql:fevrer";
       Connection con = DriverManager.getConnection(url,"fevrer", "moi");
       Statement stmt= con.createStatement();
       ResultSet rs;

       String libelle = "";
       Integer num = 0;
       Integer prix = 0;

       // ajout panier
       String[] valeurs = request.getParameterValues("check");
       if (valeurs != null) {
       for (int i=0; i < valeurs.length ; i++) {
			 int numero = Integer.parseInt(valeurs[i]);
			 rs = stmt.executeQuery("SELECT prix,libelle FROM produit WHERE num = "+numero+";");
			 rs.next();
			 libelle = rs.getString("libelle");
			 prix = (Integer)rs.getInt("prix");
			 panier.put(libelle,prix);
			 }
       }
       %>

    <Table align="center">
      <CAPTION> <h1> Panier du client <h1> </CAPTION>
      <tr>
	<th>Libelle Produit</th>
	<th>Prix</th>
      </tr>
      <% for (Map.Entry<String,Integer> entry : panier.entrySet() ) {%>
      <tr>
	<td> <%=entry.getKey() %> </td>
	<td> <%=entry.getValue() %> </td>
      </tr>
      <% } %>
    </Table>

    <form action="boutique.jsp">
    <Table align="center">
      <CAPTION> <h1> Produit en magasin <h1> </CAPTION>
      <tr>
	<th>Numero</th>
	<th>Libelle Produit</th>
	<th>Prix</th>
	<th>Ajout Panier</th>
      </tr>
      
      <% // commande pour récupérer les infos dans la BDD
	 rs = stmt.executeQuery("SELECT num,libelle,prix FROM produit;");
	 while(rs.next()){
	 num=(Integer)rs.getInt("num");
	 prix=(Integer)rs.getInt("prix");
	 libelle=rs.getString("libelle"); %>
      <tr>
	<td> <%=num %> </td>
	<td> <%=libelle %> </td>
	<td> <%=prix %> </td>
	<td align="center"> <input type="checkbox" name="check" value="<%= num %>"/></td>
      </tr>      
      <% } %>
    </Table>
    <center><input type="submit"/></center>
    </form>
  </body>
</html>
