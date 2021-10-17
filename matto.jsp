<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
 
<%
/* Paso 1) Obtener los datos del formulario */
String ls_isbn = request.getParameter("isbn");
String ls_titulo = request.getParameter("titulo");
String ls_autor = request.getParameter("autor");
String ls_action = request.getParameter("Action");
String ls_editorial = request.getParameter("editorial");
String ls_anioPublic = request.getParameter("anioPublic");
 
/* Paso 2) Inicializar variables */
String ls_result = "Base de datos actualizada...";
String ls_query = "";
ServletContext context = request.getServletContext();
String ls_dburl = "jdbc:odbc:registro";
String ls_usuario = "libros";
String ls_password = "books";
String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
 
/* Paso 3) Crear query&nbsp; */
try{//programar aqui las funciones de los formularios, ls_action
	if (ls_action.equals("Crear")) {
	ls_query = " insert into libros (isbn, titulo, autor, id_editorial, anioPublic)";
	ls_query += " values (";
	ls_query += "'" + ls_isbn + "',";
	ls_query += "'" + ls_titulo + "',";
	ls_query += "'" + ls_autor + "',";
	ls_query += "'" + ls_editorial + "',";
	ls_query += "'" + ls_anioPublic + "')";
	}
	 
	if (ls_action.equals("Eliminar")) {
	ls_query = " delete from libros where isbn = ";
	ls_query += "'" + ls_isbn + "'";
	}
	 
	if (ls_action.equals("Actualizar")) {
	ls_query = " update libros";
	ls_query += " set titulo= " + "'" + ls_titulo + "'";
	ls_query += ", autor = " + "'" + ls_autor + "'";
	ls_query += ", id_editorial = " + "'" + ls_editorial + "'";
	ls_query += ", anioPublic = " + "'" + ls_anioPublic+ "'";
	ls_query += " where isbn = " + "'" + ls_isbn + "'";
	}
}catch(Exception e){//programar aqui las funciones de la columna accion, osea eliminar y actualizar
	ls_query = " delete from libros where isbn = ";
	ls_query += "'" + request.getParameter("isbn2") + "'";	
}

/* Paso4) Conexi�n a la base de datos */
Connection l_dbconn = null;
 
try {
Class.forName(ls_dbdriver);
/*&nbsp; getConnection(URL,User,Pw) */
l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);
 
/*Creaci�n de SQL Statement */
Statement l_statement = l_dbconn.createStatement();
/* Ejecuci�n de SQL Statement */
l_statement.execute(ls_query);
} catch (ClassNotFoundException e) {
ls_result = " Error creando el driver!";
ls_result += " <br/>" + e.toString();
} catch (SQLException e) {
ls_result = " Error procesando el SQL!";
ls_result += " <br/>" + e.toString();
} finally {
/* Cerramos */
try {
if (l_dbconn != null) {
l_dbconn.close();
}
} catch (SQLException e) {
ls_result = "Error al cerrar la conexi�n.";
ls_result += " <br/>" + e.toString();
}
}
%>
html>
<html>
<head><title>Updating a Database</title></head>
<body>
 
La siguiente instrucci�n fue ejecutada:
<br/><br/>
<%=ls_query%>
<br/><br/>
 
El resultado fue:
<br/><br/>
<%=ls_result%>
<br/><br/>
 
<a href="libros.jsp">Entre otro valor</a>
</body>
</html>