<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    String id = request.getParameter("id");
    if(!users("admin")){
        session.setAttribute("alertMessage", "You are not registered as an Admin !");
        response.sendRedirect(root);
        return;
    }else if(id == null || id.isEmpty()){
        session.setAttribute("alertMessage", "Invalid User ID!");
        response.sendRedirect("manageCustomer.jsp");
        return;
    }
    String query = "SELECT * FROM users WHERE user_id = ?";

    ResultSet rs = Connect.query(query, id);
    if(!rs.first()){
        session.setAttribute("alertMessage", "Invalid User ID!");
        response.sendRedirect("manageCustomer.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile Admin - Slime</title>
    <link rel="shortcut icon" type="image/png" href="<%= root %>/asset/slime_logo.png">
    <!-- CSS -->
    <link rel="stylesheet" href="<%= root %>/css/style.css">
    <!-- JS -->
    <script src="https://kit.fontawesome.com/ee59162344.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function removeAccount(){
            var id = document.getElementById("id").value;
            if (confirm('Are you sure to delete this account ?')) {
                location.replace("doDelete.jsp?id=" + id);
            }else{
            }
        }
    </script>
    
</head>
<body>
    <div class="header" id="header">
        <%@ include file="/headerfooter/header.jsp" %>
    </div>
    
    <div class="container">
        <div class="center">
            <h1>EDIT CUSTOMER PROFILE</h1>
        </div>
        <div class="row">
            <div class="col form-container register-form">
                <br><br>
                <form action="doEdit.jsp?id=<%= rs.getInt("user_id") %>" method="POST" class="form">
                    <div class="form-item">
                        <input type="text" name="email" placeholder="Email" value="<%= rs.getString("user_email") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorEmail = (String) session.getAttribute("errorEmail");
            
                            if(errorEmail != null){
                                out.println(errorEmail);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="text" name="name" placeholder="Name" value="<%= rs.getString("user_name") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorName = (String) session.getAttribute("errorName");
            
                            if(errorName != null){
                                out.println(errorName);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="text" name="phoneNumber" placeholder="Phone Number" value="<%= rs.getString("user_phone") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorPhoneNumber = (String) session.getAttribute("errorPhoneNumber");
            
                            if(errorPhoneNumber != null){
                                out.println(errorPhoneNumber);
                            }
                        %>
                    </div>
                    <div class="form-radio-item left">
                        <br>
                        Gender :
                        <br>
                        <input type="radio" name="gender" id ="female" value="female" <%= "female".equals(rs.getString("user_gender")) ? "checked" : ""%>>
                        <label for="female">Female</label>
                        <br>
                        <input type="radio" name="gender" id ="male" value="male" <%= "male".equals(rs.getString("user_gender")) ? "checked" : ""%>>
                        <label for="male">Male</label>
                        <br>
                        <input type="radio" name="gender" id ="none" value="none" <%= "none".equals(rs.getString("user_gender")) ? "checked" : ""%>>
                        <label for="none">Rather Not Say</label>
                    </div>
                    <div class="form-error left">
                        <%
                            String errorGender = (String) session.getAttribute("errorGender");
            
                            if(errorGender != null){
                                out.println(errorGender);
                            }
                        %>
                    </div>
                    <div class="form-radio-item left">
                        <br>
                        Role :
                        <br>
                        <input type="radio" name="role" id ="admin" value="admin" <%= rs.getBoolean("is_admin") ? "checked" : ""%>>
                        <label for="admin">Admin</label>
                        <br>
                        <input type="radio" name="role" id ="customer" value="customer" <%= !rs.getBoolean("is_admin") ? "checked" : ""%>>
                        <label for="customer">Customer</label>
                        <br>
                    </div>
                    <div class="form-item form-button">
                        <button type="submit">EDIT PROFILE</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="delete-button">
                <input type="hidden" name="id" id="id" value="<%= rs.getInt("user_id") %>">
                <button onclick="removeAccount()">REMOVE CUSTOMER ACCOUNT</button>
            </div>
        </div>
    </div>

    <%
        session.setAttribute("errorEmail", null);
        session.setAttribute("errorName", null);
        session.setAttribute("errorPhoneNumber", null);
        session.setAttribute("errorGender", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>