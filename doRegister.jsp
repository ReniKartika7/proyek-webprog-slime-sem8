<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(!users("guest")){
        session.setAttribute("alertMessage", "Please Logout first!");
        response.sendRedirect(root);
        return;
    }
    
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String phoneNumber = request.getParameter("phoneNumber");
    String gender = request.getParameter("gender");
    String password = request.getParameter("password");
    String retypePassword = request.getParameter("retypePassword");

    String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
    String passwordPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$";

    String checkEmail = "SELECT COUNT(*) FROM users WHERE user_email = ?";
    ResultSet rs = Connect.query(checkEmail, email);
    rs.first();

    int flag = 0;

    session.setAttribute("email", email);
    session.setAttribute("name", name);
    session.setAttribute("phoneNumber", phoneNumber);
    session.setAttribute("gender", gender);

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

    if(password.isEmpty()){
        session.setAttribute("errorPassword", "Password is required!");
    }else if(password.length() < 9){
        session.setAttribute("errorPassword", "Password too short!");
    }else if(!password.matches(passwordPattern)){
        session.setAttribute("errorPassword", "Password must consist of at least one character and one number!");
    }else{
        session.setAttribute("errorPassword", "");
        flag++;
    }

    if(!retypePassword.equals(password)){
        session.setAttribute("errorRetypePassword", "Password and Confirm Password doesn't match!");
    }else{
        session.setAttribute("errorRetypePassword", "");
        flag++;
    }

    if (flag == 6){

        String query ="INSERT INTO users (user_email, user_name, user_phone, user_password, user_gender, is_admin) VALUES (?, ?, ?, ?, ?, 0)";
        
        Connect.update(query, email, name, phoneNumber, password, gender);

        session.setAttribute("email", null); 
        session.setAttribute("name", null); 
        session.setAttribute("phoneNumber", null); 
        session.setAttribute("gender", null);
        session.setAttribute("alertMessage", "Thanks for your registration ! Please Login here!");

        response.sendRedirect("login.jsp");
    }else{
        response.sendRedirect("register.jsp");
    }
%>