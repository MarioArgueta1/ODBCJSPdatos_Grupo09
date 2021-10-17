<%@page pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.servlet.*,net.ucanaccess.jdbc.*"%> <%
    response.setStatus(200);
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition","attachment; filename=" + "listadoLibros.txt" );
    ServletContext context = request.getServletContext();
    String path = context.getRealPath("/data");
    Connection conexion = getConnection(path);
    if (!conexion.isClosed())
    {
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery("select * from libros inner join editorial on libros.id_editorial = editorial.id" );
	//ResultSet rs = st.executeQuery("select * from libros" ); 
	//PrintWriter out = response.getWriter();
        out.println("ISBN\tTitulo\tAutor\tEditorial\tAño Publicacion");
        while (rs.next())
        {
            String isbn1 = rs.getString("isbn");
            String tit1 = rs.getString("titulo");
            String aut1 = rs.getString("autor");
            String editorial = rs.getString("nombre");
            String anioPublic = rs.getString("anioPublic");
            out.println(isbn1+"\t"+tit1+"\t"+aut1+"\t"+editorial+"\t"+anioPublic);	  
        }
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