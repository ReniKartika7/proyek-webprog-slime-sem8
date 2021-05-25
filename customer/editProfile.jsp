<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(users("guest")){
        session.setAttribute("fromCartGuest", "yes");
        response.sendRedirect(loginPath);
        return;
    }else if(users("admin")){
        session.setAttribute("fromCartAdmin", "yes");
        response.sendRedirect(root);
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Slime</title>
    <link rel="shortcut icon" type="image/png" href="<%= root %>/asset/slime_logo.png">
    <!-- CSS -->
    <link rel="stylesheet" href="<%= root %>/css/style.css">
    <!-- JS -->
    <script src="https://kit.fontawesome.com/ee59162344.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function removeAccount(){
            if (confirm('Are you sure to delete your account ?')) {
                location.replace("doDelete.jsp");
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
            <h1>EDIT PROFILE</h1>
        </div>
        <div class="row">
            <div class="col form-container register-form">
                <br><br>
                <form action="doEdit.jsp" method="POST" class="form">
                    <div class="form-item">
                        <input type="text" name="email" placeholder="Email" value="<%= user.user_email%>">
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
                        <input type="text" name="name" placeholder="Name" value="<%= user.user_name %>">
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
                        <input type="text" name="phoneNumber" placeholder="Phone Number" value="<%= user.user_phone%>">
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
                        <input type="radio" name="gender" id ="female" value="female" <%= "female".equals(user.user_gender) ? "checked" : ""%>>
                        <label for="female">Female</label>
                        <br>
                        <input type="radio" name="gender" id ="male" value="male" <%= "male".equals(user.user_gender) ? "checked" : ""%>>
                        <label for="male">Male</label>
                        <br>
                        <input type="radio" name="gender" id ="none" value="none" <%= "none".equals(user.user_gender) ? "checked" : ""%>>
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
                    <div class="form-item form-button">
                        <button type="submit">SAVE PROFILE</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="delete-button">
                <button onclick="removeAccount()">REMOVE MY ACCOUNT</button>
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