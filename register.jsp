<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(!users("guest")){
        session.setAttribute("alertMessage", "Please Logout first!");
        response.sendRedirect(root);
        return;
    }
    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");
    String phoneNumber = (String) session.getAttribute("phoneNumber");
    String gender = (String) session.getAttribute("gender");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Slime</title>
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
        <div class="row">
            <div class="col form-container register-form">
                <h2 class="center">HELLO</h2>
                <form action="doRegister.jsp" method="POST" class="form">
                    <div class="form-item">
                        <input type="text" name="email" placeholder="Email" value="<%= email == null ? "" : email%>">
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
                        <input type="text" name="name" placeholder="Name" value="<%= name == null ? "" : name%>">
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
                        <input type="text" name="phoneNumber" placeholder="Phone Number" value="<%= phoneNumber == null ? "" : phoneNumber%>">
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
                        <input type="radio" name="gender" id ="female" value="female" <%= "female".equals(gender) ? "checked" : ""%>>
                        <label for="female">Female</label>
                        <br>
                        <input type="radio" name="gender" id ="male" value="male" <%= "male".equals(gender) ? "checked" : ""%>>
                        <label for="male">Male</label>
                        <br>
                        <input type="radio" name="gender" id ="none" value="none" <%= "none".equals(gender) ? "checked" : ""%>>
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
                    <div class="form-item">
                        <input type="password" name="password" placeholder="Password">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorPassword = (String) session.getAttribute("errorPassword");
            
                            if(errorPassword != null){
                                out.println(errorPassword);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="password" name="retypePassword" placeholder="Re-type Password">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorRetypePassword = (String) session.getAttribute("errorRetypePassword");
            
                            if(errorRetypePassword != null){
                                out.println(errorRetypePassword);
                            }
                        %>
                    </div>
                    <div class="form-item form-button">
                        <button type="submit">REGISTER</button>
                    </div>
                </form>
                <p class="text-small center">Already have an account? <br>Login <a href="login.jsp">here</a></p>
            </div>
        </div>
    </div>

    <%
        session.setAttribute("email", null); 
        session.setAttribute("errorEmail", null);
        session.setAttribute("name", null); 
        session.setAttribute("errorName", null);
        session.setAttribute("phoneNumber", null); 
        session.setAttribute("errorPhoneNumber", null);
        session.setAttribute("gender", null); 
        session.setAttribute("errorGender", null);
        session.setAttribute("errorPassword", null);
        session.setAttribute("errorRetypePassword", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>