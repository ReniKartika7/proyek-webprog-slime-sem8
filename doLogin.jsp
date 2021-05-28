<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(!users("guest")){
        session.setAttribute("alertMessage", "Please Logout first!");
        response.sendRedirect(root);
        return;
    }
    
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    String checkUser = "SELECT user_id FROM users WHERE user_email = ? AND user_password = ?";
    ResultSet rs = Connect.query(checkUser, email, password);

    int flag = 0;

    if (email.isEmpty()){
        session.setAttribute("errorEmail", "Email is required!");
    }else{
        session.setAttribute("errorEmail", "");
        flag++;
    }

    if (password.isEmpty()){
        session.setAttribute("errorPassword", "Password is required!");
    }else{
        session.setAttribute("errorPassword", "");
        flag++;
    }

    if (flag == 2){
        if(!rs.first()){
            session.setAttribute("errorPassword", "Incorect email and password !");
            response.sendRedirect("login.jsp");
        }else{
            int user_id = rs.getInt("user_id");

            Cookie cookie = new Cookie("user_id", user_id + "");
            cookie.setMaxAge(60 * 60 * 24);
            response.addCookie(cookie);
            response.sendRedirect(root);
        }
    }else{
        response.sendRedirect("login.jsp");
    }
%>