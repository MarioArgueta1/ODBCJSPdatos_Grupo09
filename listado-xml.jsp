<%@page pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.servlet.*,net.ucanaccess.jdbc.*"%> <%
    response.setStatus(200);
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition","attachment; filename=" + "listadoLibros.xml" );
    ServletContext context = request.getServletContext();
    String path = context.getRealPath("/data");
    Connection conexion = getConnection(path);
    if (!conexion.isClosed())
    {
        Statement st = conexion.createStatement();
	ResultSet rs = st.executeQuery("select * from libros inner join editorial on libros.id_editorial = editorial.id" );
	//ResultSet rs = st.executeQuery("select * from libros" );
	//PrintWriter out = response.getWriter();
        out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?><libros>");
        while (rs.next())
        {
            String isbn1 = rs.getString("isbn");
            String tit1 = rs.getString("titulo");
            String aut1 = rs.getString("autor");
            String editorial = rs.getString("nombre");
            String anioPublic = rs.getString("anioPublic");
            out.println("<libro id=\"" + isbn1 + "\">");
            out.println("<isbn>"+isbn1+"</isbn>");
            out.println("<titulo>"+tit1+"</titulo>");
            out.println("<autor>"+aut1+"</autor>");
            out.println("<editorial>"+editorial+"</editorial>");
            out.println("<anio_publicacion>"+anioPublic+"</anio_publicacion>");
            out.println("</libro>");
        }
        out.println("</libros>");
      // Cerrando la conexion
      conexion.close();
    }
%>
<%!
    public Connection getConnection(String path) throws SQLException 
    {
        String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
        String filePath= path + "\\datos.mdb";
        String userName="",password="";
        String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;
        Connection conn = null;
        try{
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            conn = DriverManager.getConnection(fullConnectionString,userName,password);
        }
        catch (Exception e) 
        {
            System.out.println("Error: " + e);
        }
        return conn;
    }
%>