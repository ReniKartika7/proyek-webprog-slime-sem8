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

    session.setAttribute("loc1", "myCart");
    String alertMessage = (String) session.getAttribute("alertMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart - Slime</title>
    <link rel="shortcut icon" type="image/png" href="<%= root %>/asset/slime_logo.png">
    <!-- CSS -->
    <link rel="stylesheet" href="<%= root %>/css/style.css">
    <!-- JS -->
    <script src="https://kit.fontawesome.com/ee59162344.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="<%= root %>/js/quantity.js"></script>
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

    <% Integer subTotal = 0; %>
    
    <div class="container">
        <h1 class="center">MY CART</h1>
        <div class="cart-container">
            <%
                String query = "SELECT COUNT(*) AS cnt FROM cart JOIN snacks ON cart.snack_id = snacks.snack_id WHERE user_id = ?";

                ResultSet rs = Connect.query(query, user.sId());
                if(rs.first()){
                    Integer cnt = rs.getInt("cnt");
                    if(cnt == 0){
                        out.println("You don't have any product in your cart.");
                    }else{
            %>

                    <%= rs.getInt("cnt") %> PRODUCT(S) CHOOSEN <br><br>

            <%
                        query = "SELECT * FROM cart JOIN snacks ON cart.snack_id = snacks.snack_id WHERE user_id = ? ORDER BY cart_id ASC";

                        rs = Connect.query(query, user.sId());
            
                        while(rs.next()){
            %>
                        <div class="row">
                            <div class="row delete-icon">
                                <a href="doDelete.jsp?id=<%=rs.getString("snack_id")%>">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </div>
                            <div class="col image">
                                <img src="<%= rs.getString("snack_cover_url") %>" alt="<%= rs.getString("snack_name") %>">
                            </div>
                            <div class="col3">
                                
                                <div>
                                    <b><%= rs.getString("snack_name") %></b>
                                </div>
                                <div>
                                    <%= formatRupiah(rs.getInt("snack_price")) %>
                                </div>
                                <div class="product-quantity">
                                    <div class="quantity-button">
                                        <input type="hidden" name="snack-id" class="snack-id" value="<%= rs.getInt("snack_id") %>">
                                        <input type="hidden" name="snack-price" class="snack-price" value="<%= rs.getInt("snack_price") %>">
                                        <input type="button" value="-" class="button-minus"><input type="number" name="qty" class="input-qty" size="4" step="1" min="1" max="<%= rs.getInt("snack_stock") %>" id="qty" value="<%= rs.getInt("quantity") %>"><input type="button" value="+" class="button-plus">
                                    </div>
                                </div>
                            </div>
                            <div class="col totaldiv">
                                <span class="total"><%= formatRupiah(rs.getInt("snack_price") * rs.getInt("quantity")) %></span>
                            </div>
                        </div>
            <%
                            subTotal = subTotal + (rs.getInt("snack_price") * rs.getInt("quantity"));
                        }
            %>  
            <div class="row total-container">
                <div class="col temp">
                </div>
                <div class="col3 total-text">
                    <b>Sub Total</b>
                </div>
                <div class="col total-price">
                    <span class="total-price-value"><b><%= formatRupiah(subTotal)%></b></span>
                </div>
            </div>
                   
            <form action="checkOut.jsp">
                <div class="form-item form-button center">
                    <button type="submit">CHECKOUT</button>
                </div>
            </form>
            <%
                    }
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