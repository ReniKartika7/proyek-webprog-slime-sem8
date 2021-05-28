<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(users("guest")){
        session.setAttribute("alertMessage", "Please Login first!");
        response.sendRedirect(loginPath);
        return;
    }else if(users("admin")){
        session.setAttribute("alertMessage", "You are not login as a customer");
        response.sendRedirect(root);
        return;
    }

    String oldPassword = request.getParameter("oldPassword");
    String newPassword = request.getParameter("newPassword");
    String retypeNewPassword = request.getParameter("retypeNewPassword");

    String passwordPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$";

    int flag = 0;
    String id = user.sId();
    
    if(oldPassword.isEmpty()){
        session.setAttribute("errorOldPassword", "Old password is required!");
    }else if (!oldPassword.equals(user.user_password)){
        session.setAttribute("errorOldPassword", "Incorrect password!");
    }else{
        session.setAttribute("errorOldPassword", "");
        flag++;
    }

    if(newPassword.isEmpty()){
        session.setAttribute("errorNewPassword", "New password is required!");
    }else if(newPassword.length() < 9){
        session.setAttribute("errorNewPassword", "New password too short!");
    }else if(!newPassword.matches(passwordPattern)){
        session.setAttribute("errorNewPassword", "New password must consist of at least one character and one number!");
    }else{
        session.setAttribute("errorNewPassword", "");
        flag++;
    }

    if(!retypeNewPassword.equals(newPassword)){
        session.setAttribute("errorRetypeNewPassword", "Password and Confirm Password doesn't match!");
    }else{
        session.setAttribute("errorRetypeNewPassword", "");
        flag++;
    }

    if(flag == 3){
        String query ="UPDATE users SET user_password = ? WHERE user_id = ?";
        Connect.update(query, newPassword, id);
    
        session.setAttribute("alertMessage", "Your password has been changed!");

        response.sendRedirect("myProfile.jsp");
    }else{
        response.sendRedirect("changePassword.jsp");
    }

%>