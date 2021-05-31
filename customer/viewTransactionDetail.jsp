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

    String id = request.getParameter("id");
    if(id == null || id.isEmpty()){
        session.setAttribute("alertMessage", "Invalid Product ID!");
        response.sendRedirect("myProfile.jsp");
        return;
    }

    String query = "SELECT * FROM transaction_header WHERE user_id = ? AND transaction_id = ?";

    ResultSet rs = Connect.query(query, user.sId(), id);
    if(!rs.first()){
        session.setAttribute("alertMessage", "Invalid Product ID!");
        response.sendRedirect("myProfile.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Detail - Slime</title>
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
        <h1 class="center">TRANSACTION DETAIL</h1>
        
        <div class="cart-container">
            <div class="row shipping-address">
                <div>
                    <b>Shipping Address</b>
                </div>
                <div class="choose-shipping">
                    <%
                        query = "SELECT * FROM transaction_header JOIN `address` ON transaction_header.address_id = address.address_id WHERE transaction_id = ?";

                        rs = Connect.query(query, id);
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
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                            </div>
                            
                    <%
                        }
                    %>
                    
                </div>
            </div>
            <%
                Integer subTotal = 0; 
                query = "SELECT COUNT(*) AS cnt FROM transaction_detail WHERE transaction_id = ?";
                rs = Connect.query(query, id);
                rs.first();
                out.println(rs.getInt("cnt") + " PRODUCT(S) CHOOSEN <br><br>");

                query = "SELECT * FROM transaction_detail JOIN snacks ON transaction_detail.snack_id = snacks.snack_id WHERE transaction_id = ? ORDER BY snacks.snack_id ASC";

                rs = Connect.query(query, id);
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
                    <b>Grand Total</b>
                </div>
                <div class="col total-price">
                    <b><%= formatRupiah(subTotal + shippingFee)%></b>
                </div>
            </div>
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