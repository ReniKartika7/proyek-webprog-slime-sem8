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
    <title>MY CART</title>
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
        <h1 class="center">MY CART</h1>
        <div class="cart-container">
            <%
                String query = "SELECT COUNT(*) AS cnt FROM cart JOIN snacks ON cart.snack_id = snacks.snack_id WHERE user_id = ?";

                ResultSet rs = Connect.query(query, user.sId());
                if(rs.first()){
            %>

                    <%= rs.getInt("cnt") %> PRODUCT(S) CHOOSEN

            <%
                    query = "SELECT * FROM cart JOIN snacks ON cart.snack_id = snacks.snack_id WHERE user_id = ? ORDER BY cart_id ASC";

                    rs = Connect.query(query, user.sId());
                    while(rs.next()){
            %>
                        <div class="row">
                            <div class="col">
                                <img src="<%= rs.getString("snack_cover_url") %>" alt="<%= rs.getString("snack_name") %>">
                            </div>
                            <div class="col5">
                                kak
                            </div>
                        </div>
            <%
                    }
                }else{
            %>
                    You don't have any product in your cart.
            <%
                }
            %>
        </div>
    </div>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>