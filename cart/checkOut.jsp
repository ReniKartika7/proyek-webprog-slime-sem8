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
    String addressId = (String) session.getAttribute("addressId");
    session.setAttribute("addressId", addressId);
    String loc1 = (String) session.getAttribute("loc1");
    session.setAttribute("loc1", loc1);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CHECK OUT</title>
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

    <% 
        Integer subTotal = 0; 
        String query;
        ResultSet rs;
    %>
    
    <div class="container">
        <h1 class="center">MY CART</h1>
        <div class="cart-container">

            <a href="<%= root + "/address/chooseAddress.jsp" %>">
                <div class="row shipping-address">
                    <div>
                        <b>Shipping Address</b>
                    </div>
                    <div class="choose-shipping">
                        <%
                            if(addressId == null || addressId.isEmpty()){
                        %>
                            Choose Your Address in here <i class="fas fa-arrow-right"></i>
                        <%
                            }else{
                                query = "SELECT * FROM `address` WHERE address_id = ?";

                                rs = Connect.query(query, addressId);
                                if(rs.first()){
                        %>
                                <div class="row">
                                    <div>
                                        <b><%= rs.getString("address_full_name") %></b>
                                    </div>
                                    <div>
                                        <%= rs.getString("address_phone_number") %>
                                    </div>
                                    <div>
                                        <%= rs.getString("address_detail") %>
                                    </div>
                                    <%
                                        String txt = rs.getString("address_province") + ", " + rs.getString("address_district") + ", " + rs.getString("address_subdistrict") + ", " + rs.getString("address_postal_code");
                                        txt = txt.toUpperCase();
                                    %>
                                    <div>
                                        <%= txt %>
                                    </div>
                                    <div class="icon-right">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                                
                        <%
                                }
                            }
                        %>
                        
                    </div>
                </div>
            </a>

            <%
                query = "SELECT COUNT(*) AS cnt FROM cart JOIN snacks ON cart.snack_id = snacks.snack_id WHERE user_id = ?";

                rs = Connect.query(query, user.sId());
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
                                <div>
                                    <b><%= rs.getInt("quantity") %> Pcs</b>
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

            <div class="row total-container">
                <div class="col temp">
                </div>
                <div class="col3 total-text">
                    <b>Shipping Fee</b>
                </div>
                <%
                    Integer shippingFee = 0;
                    if(subTotal < 120000){
                        shippingFee = 10000;
                    }
                %>
                <div class="col total-price">
                    <b><%= shippingFee == 0 ? "Free" : formatRupiah(shippingFee) %></b>
                </div>
            </div>

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
                   
            <form action="doBuy.jsp">
                <div class="form-item form-button center">
                    <button type="submit">BUY NOW</button>
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
    
    <%
        session.setAttribute("alertMessage", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>