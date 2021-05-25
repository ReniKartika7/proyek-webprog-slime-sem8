<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(!users("guest")){
        session.setAttribute("fromLoginNotGuest", "yes");
        response.sendRedirect(root);
        return;
    }
    String fromRegister = (String) session.getAttribute("fromRegister");
    String fromCartGuest = (String) session.getAttribute("fromCartGuest");
    String fromLogOut = (String) session.getAttribute("fromLogOut");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Slime</title>
    <link rel="shortcut icon" type="image/png" href="<%= root %>/asset/slime_logo.png">
    <!-- CSS -->
    <link rel="stylesheet" href="<%= root %>/css/style.css">
    <!-- JS -->
    <script src="https://kit.fontawesome.com/ee59162344.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
</head>
<body>
    
    <%
        if(fromRegister != null){
            if(fromRegister.equals("yes")){
    %>
        <script type="text/javascript">
            alert("Thanks for your registration ! Please Login here!");
        </script>
    <%
            }
        }else if(fromCartGuest != null){
            if(fromCartGuest.equals("yes")){
    %>
        <script type="text/javascript">
            alert("Please Login first!");
        </script>   
    <%
            }
        }else if(fromLogOut != null){
            if(fromLogOut.equals("yes")){
    %>
        <script type="text/javascript">
            alert("You've successfully logged out!");
        </script>   
    <%
            }
        }
    %>

    <div class="header" id="header">
        <%@ include file="/headerfooter/header.jsp" %>
    </div>
    
    <div class="container">
        <div class="login-container">
            <div class="row">
                <div class="col">
                    <img src="<%= root %>/asset/cookies.png" alt="Cookie Image" class="login-image">
                </div>
                <div class="col2 form-container">
                    <h2 class="center">WELCOME</h2>
                    <form action="doLogin.jsp" class="form" method="POST">
                        <div class="form-item">
                            <input type="text" name="email" placeholder="Email">
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
                        <div class="form-item form-button">
                            <button type="submit">LOGIN</button>
                        </div>
                    </form>
                    <p class="text-small center">Dont have an account? <br>Register <a href="register.jsp">here</a></p>
                </div>
            </div>
        </div>
    </div>

    <%
        session.setAttribute("fromRegister", null); 
        session.setAttribute("fromCartGuest", null);
        session.setAttribute("fromLogOut", null);
        session.setAttribute("errorEmail", null);
        session.setAttribute("errorPassword", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>