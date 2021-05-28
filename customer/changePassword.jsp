<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Slime</title>
    <link rel="shortcut icon" type="image/png" href="<%= root %>/asset/slime_logo.png">
    <!-- CSS -->
    <link rel="stylesheet" href="<%= root %>/css/style.css">
    <!-- JS -->
    <script src="https://kit.fontawesome.com/ee59162344.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
</head>
<body>
    <div class="header" id="header">
        <%@ include file="/headerfooter/header.jsp" %>
    </div>
    
    <div class="container">
        <div class="login-container">
            <div class="row">
                <div class="col2 form-container">
                    <h2 class="center">CHANGE PASSWORD</h2>
                    <form action="doChangePassword.jsp" class="form" method="POST">
                        <div class="form-item">
                            <input type="password" name="oldPassword" placeholder="Old Password">
                        </div>
                        <div class="form-error left">
                            <%
                                String errorOldPassword = (String) session.getAttribute("errorOldPassword");
                
                                if(errorOldPassword != null){
                                    out.println(errorOldPassword);
                                }
                            %>
                        </div>
                        <div class="form-item">
                            <input type="password" name="newPassword" placeholder="New Password">
                        </div>
                        <div class="form-error left">
                            <%
                                String errorNewPassword = (String) session.getAttribute("errorNewPassword");
                
                                if(errorNewPassword != null){
                                    out.println(errorNewPassword);
                                }
                            %>
                        </div>
                        <div class="form-item">
                            <input type="password" name="retypeNewPassword" placeholder="Retype New Password">
                        </div>
                        <div class="form-error left">
                            <%
                                String errorRetypeNewPassword = (String) session.getAttribute("errorRetypeNewPassword");
                
                                if(errorRetypeNewPassword != null){
                                    out.println(errorRetypeNewPassword);
                                }
                            %>
                        </div>
                        <div class="form-item form-button">
                            <button type="submit">SAVE PASSWORD</button>
                        </div>
                    </form>
                </div>
                <div class="col">
                    <img src="<%= root %>/asset/password.png" alt="Password Image" class="login-image">
                </div>
            </div>
        </div>
    </div>

    <%
        session.setAttribute("errorOldPassword", null); 
        session.setAttribute("errorNewPassword", null);
        session.setAttribute("errorRetypeNewPassword", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>