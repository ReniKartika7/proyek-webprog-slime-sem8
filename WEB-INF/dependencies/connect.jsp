<%@ page import="java.sql.*" %>

<%!
   public static final class Connect{
        private static Connection con;
        private static Statement st;

        static final String DB_NAME = "slime";
        static String DB_HOST = "localhost"; 
        static final String USERNAME = "root"; 
        static final String PASSWORD = ""; 
        static final String DB_PORT = "3306"; 

        static final String DB_DRIVER = "com.mysql.jdbc.Driver";   
        static final String DB_CONNECTION_URL =
                String.format("jdbc:mysql://%s:%s/%s",  DB_HOST, DB_PORT, DB_NAME);

        static{
            try{
                Class.forName(DB_DRIVER);
                con = DriverManager.getConnection(DB_CONNECTION_URL, USERNAME, PASSWORD);
                st = con.createStatement();    
            }
            catch (ClassNotFoundException e) {
            }
            catch (SQLException e) {
            }
        }

        public static ResultSet query(String q){
            ResultSet rs = null;
            try{
                rs = st.executeQuery(q);
            } catch (SQLException e) {
            }
            return rs;
        }

        public static ResultSet query(String q, String... values){
            ResultSet rs = null;
            PreparedStatement ps = prepare(q, values);
            try{
                if(ps != null){
                    rs = ps.executeQuery();
                }
            } catch (SQLException e){
            }

            return rs;
        }

        public static int update(String q, String... values){
            int i = 0;
            PreparedStatement ps = prepare(q, values);
            try {
                if(ps != null){
                    i = ps.executeUpdate();
                }
            }catch (SQLException e){
            }
            return i;
        }

        private static PreparedStatement prepare(String q, String... values){
            try{
                PreparedStatement ps = con.prepareStatement(q);
                int i = 1;
                for (String val : values){
                    ps.setString(i++, val);
                }
                return ps;
            } catch (SQLException e){
            }

            return null;
        }
   } 
%>
