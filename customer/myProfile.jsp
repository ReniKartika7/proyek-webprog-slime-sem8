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

    String alertMessage = (String) session.getAttribute("alertMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Slime</title>
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
    
    <input type="hidden" name="alertMessage" id="alertMessage" value="<%= alertMessage %>">
    <%
        if(alertMessage != null){
    %>
        <script type="text/javascript">
            var txt = document.getElementById("alertMessage").value;
            alert(txt);
        </script>   
    <%
        }
    %>

    <div class="container my-profile">
        <div class="center">
            <h1>MY PROFILE</h1>
        </div>
        <div class="row">
            <div class="col">
                <img src="<%= root %>/asset/<%= user.user_gender %>.png" alt="Profile Pict">
            </div>
            <div class="col user-short-desc">
                <div class="user-name">
                    <%=user.user_name%>
                </div>
                <div class="edit-profile-text">
                    <a href="<%= root %>/customer/editProfile.jsp">
                        Edit your profile here <i class="fas fa-angle-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="row transaction-container">
            <%
                String checkTransaction = "SELECT transaction_id FROM transaction_header WHERE user_id = ?";
                ResultSet rs = Connect.query(checkTransaction, Integer.toString(user.user_id));

                if(rs == null || !rs.next()){
            %>
                    <div class="transaction-empty">
                        You haven't bought any product yet !
                        <br>
                        Browse our products in <u><a href="<%= productPath %>">here</a></u> ! 
                    </div>
            <%
                }else if (rs != null){
            %>
                    <div class="transaction-detail">
                        OMO <%= user.user_id%>
                    </div>
            <%
                }
            %>

        </div>
    </div>

    <%
        session.setAttribute("alertMessage", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>