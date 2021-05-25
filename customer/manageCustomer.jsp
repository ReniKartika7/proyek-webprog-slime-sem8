<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(!users("admin")){
        session.setAttribute("fromNotAdmin", "yes");
        response.sendRedirect(root);
        return;
    }
    
    String deleteDone = (String) session.getAttribute("deleteDone");
    String invalidUser = (String) session.getAttribute("invalidUser");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Customer - Slime</title>
    <link rel="shortcut icon" type="image/png" href="<%= root %>/asset/slime_logo.png">
    <!-- CSS -->
    <link rel="stylesheet" href="<%= root %>/css/style.css">
    <!-- JS -->
    <script src="https://kit.fontawesome.com/ee59162344.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
</head>
<body>
    <%
        if(deleteDone != null){
            if(deleteDone.equals("yes")){
    %>
        <script type="text/javascript">
            alert("Account has been deleted!");
        </script>   
    <%
            }
        }else if(invalidUser != null){
            if(invalidUser.equals("yes")){
    %>
        <script type="text/javascript">
            alert("Invalid User ID!");
        </script>   
    <%
            }
        }
    %>
    <div class="header" id="header">
        <%@ include file="/headerfooter/header.jsp" %>
    </div>
    
    <div class="container manage">
        <h1>Manage User</h1>
    </div>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>