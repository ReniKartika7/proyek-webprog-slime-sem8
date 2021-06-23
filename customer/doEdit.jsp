<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(users("guest")){
        session.setAttribute("alertMessage", "Please Login first!");
        response.sendRedirect(loginPath);
        return;
    }

    String id = request.getParameter("id");
    boolean asAdmin = !(id == null || id.isEmpty());
    String oldEmail = "";

    if (asAdmin) {
        if(!users("admin")){
            session.setAttribute("alertMessage", "You are not registered as an Admin !");
            response.sendRedirect(root);
            return;
        }

        String query = "SELECT * FROM users WHERE user_id = ?";
        ResultSet rs = Connect.query(query, id);
        if(!rs.first()){
            session.setAttribute("alertMessage", "Invalid User ID!");
            response.sendRedirect("manageCustomer.jsp");
            return;
        }
        oldEmail = rs.getString("user_email");
    }else{
        if(users("admin")){
            session.setAttribute("alertMessage", "You are not login as a customer");
            response.sendRedirect(root);
            return;
        }
        id = user.sId();
        oldEmail = user.user_email;
    }

    int flag = 0;
    

    if (asAdmin){
        String role = request.getParameter("role");
        if(role == null){
            session.setAttribute("errorRole", "Role must be selected!");
        }else{
            session.setAttribute("errorRole", "");
            flag++;
        }

        if (flag == 1){
            String query ="UPDATE users SET is_admin = ? WHERE user_id = ?";
            Connect.update(query, role.equals("admin") ? "1" : "0", id);
    
            session.setAttribute("alertMessage", "Account has been updated!");
            response.sendRedirect("manageCustomer.jsp");
        }else{
            response.sendRedirect("editProfile.jsp?id=" + id);
        }
    }else{
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");

        String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";

        String checkEmail = "SELECT COUNT(*) FROM users WHERE user_email = ? AND user_email != ?";
        ResultSet rs = Connect.query(checkEmail, email, oldEmail);
        rs.first();

        if (email.isEmpty()){
            session.setAttribute("errorEmail", "Email is required!");
        } else if (!email.matches(emailPattern)){
            session.setAttribute("errorEmail", "Invalid email address!");
        } else if (rs.getInt(1) > 0){
            session.setAttribute("errorEmail", "Email has already been used!");
        } else{
            session.setAttribute("errorEmail", null);
            flag++;
        }

        if (name.isEmpty()){
            session.setAttribute("errorName", "Name is required!");
        }else if(name.length() <= 4){
            session.setAttribute("errorName", "Name must be more than 4 letters!");
        }else{
            session.setAttribute("errorName", "");
            flag++;
        }

        if (phoneNumber.isEmpty()){
            session.setAttribute("errorPhoneNumber", "Phone Number is required!");
        }else if (!phoneNumber.matches("[0-9]+")){
            session.setAttribute("errorPhoneNumber", "Phone Number must be numeric!");
        }else if(phoneNumber.length() > 13){
            session.setAttribute("errorPhoneNumber", "Phone Number must be less than 14 letters!");
        }else{
            session.setAttribute("errorPhoneNumber", "");
            flag++;
        }

        if(gender == null){
            session.setAttribute("errorGender", "Gender must be selected!");
        }else{
            session.setAttribute("errorGender", "");
            flag++;
        }

        if (flag == 4){
            String query ="UPDATE users SET user_email = ?, user_name = ?, user_phone = ?, user_gender = ? WHERE user_id = ?";
            Connect.update(query, email, name, phoneNumber, gender, id);
    
            session.setAttribute("alertMessage", "Your profile has been updated!");

            response.sendRedirect("myProfile.jsp");
        }else{
            response.sendRedirect("editProfile.jsp");
        }
    }
%>