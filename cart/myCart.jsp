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

    <% Integer subTotal = 0; %>
    
    <div class="container">
        <h1 class="center">MY CART</h1>
        <div class="cart-container">
            <%
                String query = "SELECT COUNT(*) AS cnt FROM cart JOIN snacks ON cart.snack_id = snacks.snack_id WHERE user_id = ?";

                ResultSet rs = Connect.query(query, user.sId());
                if(rs.first()){
            %>

                    <%= rs.getInt("cnt") %> PRODUCT(S) CHOOSEN <br>

            <%
                    query = "SELECT * FROM cart JOIN snacks ON cart.snack_id = snacks.snack_id WHERE user_id = ? ORDER BY cart_id ASC";

                    rs = Connect.query(query, user.sId());
            
                    while(rs.next()){
            %>
                        <div class="row">
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
                                        <input type="button" value="-" class="button-minus"><input type="number" name="qty" class="input-qty" size="4" step="1" min="0" max="<%= rs.getInt("snack_stock") %>" id="qty" value="<%= rs.getInt("quantity") %>"><input type="button" value="+" class="button-plus">
                                    </div>
                                </div>
                            </div>
                            <div class="col total">
                                <%= formatRupiah(rs.getInt("snack_price") * rs.getInt("quantity")) %>
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
                    <b><%= formatRupiah(subTotal)%></b>
                </div>
            </div>
                   
            <form action="checkOut.jsp">
                <div class="form-item form-button center">
                    <button type="submit">CHECKOUT</button>
                </div>
            </form>
            <%
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