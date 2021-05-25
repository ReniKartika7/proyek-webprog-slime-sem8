<%!
    final class User {
        int user_id;
        String user_email;
        String user_name;
        String user_phone;
        String user_password;
        String user_gender;
        int is_admin;

        String sId(){
            return Integer.toString(user_id);
        }
    }

    User user = null;
%>


<%
{
    user = null;

    Cookie[] cookies = request.getCookies();
    String query = "";
    ResultSet rs = null;
    Integer userId = (Integer) session.getAttribute("user_id");

    if (userId != null){
        rs = Connect.query("SELECT * FROM users WHERE user_id = ?", Integer.toString(userId));
    }else if(cookies != null){
        Cookie id = null;
        for (Cookie cookie : cookies){
            if(cookie.getName().equals("user_id")){
                id = cookie;
            }
            if(id != null){
                break;
            }
        }
        if(id != null){
            rs = Connect.query("SELECT * FROM users WHERE user_id = ?", id.getValue());
        }
    }
    
    if (rs != null){
        if(rs.first()){
            user = new User();

            user.user_id = rs.getInt("user_id");
            user.user_email = rs.getString("user_email");
            user.user_name = rs.getString("user_name");
            user.user_phone = rs.getString("user_phone");
            user.user_password = rs.getString("user_password");
            user.user_gender = rs.getString("user_gender");
            user.is_admin = rs.getInt("is_admin");

            session.setAttribute("user_id", user.user_id);
        }
    }
}
%>

<%!
    boolean users(String ...roles){
        String role = "";
        if(user == null){
            role = "guest";
        }else if(user.is_admin == 1){
            role = "admin";
        }else{
            role = "customer";
        }

        for(String r : roles){
            if (!role.equals(r)){
                return false;
            }
        }
        return true;
    }
%>