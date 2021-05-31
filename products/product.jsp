<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(users("guest")){
        session.setAttribute("alertMessage", "Please Login first!");
        response.sendRedirect(loginPath);
        return;
    }

    String location = (String) session.getAttribute("location");
    ResultSet rsp = null, rspt = null;
    String id = request.getParameter("id");
    if(id == null || id.isEmpty()){
        session.setAttribute("alertMessage", "Invalid Product ID!");
        response.sendRedirect(location);
        return;
    }

    String query = "SELECT * FROM snacks JOIN snack_category ON snacks.snack_category_id = snack_category.snack_category_id WHERE snack_id = ?";
    rsp = Connect.query(query, id);

    if(!rsp.first()){
        session.setAttribute("alertMessage", "Invalid Product ID!");
        response.sendRedirect(location);
        return;
    }

    String alertMessage = (String) session.getAttribute("alertMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product - Slime</title>
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

    <div class="container single-product">
        <div class="product-detail">
            <div class="row">
                <div class="col product-image">
                    <img src="<%= rsp.getString("snack_cover_url") %>" alt="<%= rsp.getString("snack_name") %>">
                </div>
                <div class="col">
                    <div class="product-detail-name">
                        <%= rsp.getString("snack_name") %>
                    </div>
                    <div class="product-detail-category">
                        <%= rsp.getString("snack_category_name") %>
                    </div>
                    <div class="product-detail-price">
                        <%= formatRupiah(rsp.getInt("snack_price")) %>
                    </div>
                    <div class="product-description">
                        <b>Product Description :</b><br>
                        <%= rsp.getString("snack_detail") %>
                    </div>
                    <div class="free-shipping">
                        <i class="fas fa-shipping-fast"></i> Free shipping on orders over Rp120.000
                    </div>
                    <input type="hidden" name="stock" id="stock" value="<%= rsp.getInt("snack_stock") %>">
                    <form method="POST">
                        <div class="product-quantity">
                            <span>Quantity :</span>
                            <div class="quantity-button">
                                <input type="button" value="-" class="button-minus"><input type="number" name="qty" class="input-qty" size="4" step="1" min="0" max="<%= rsp.getInt("snack_stock") %>" id="qty" value="0"><input type="button" value="+" class="button-plus">
                            </div>
                            <span class="product-stock" style="margin-left: 1rem; color: grey;"><%= rsp.getInt("snack_stock") %> pieces available</span>
                        </div>

                        <%
                            if(users("customer")){
                                if(rsp.getInt("snack_stock") > 0 ){
                        %>
                                <div class="product-button">
                                    <button type="submit" class="button-cart" formaction="<%= root + "/cart/doCart.jsp?id=" + id %>">
                                        <i class="fas fa-shopping-cart"></i> ADD TO CART
                                    </button>
                                    <button type="submit" class="button-buy" formaction="<%= root + "/cart/doBuyCheck.jsp?id=" + id %>">
                                        BUY NOW
                                    </button>
                                </div>
                        <%
                                }else{
                        %>
                                <div class="product-button">
                                    <button class="button-cart disabled">
                                        <i class="fas fa-shopping-cart"></i> EMPTY STOCK
                                    </button>
                                    <button class="button-buy disabled">
                                        EMPTY STOCK
                                    </button>
                                </div>  
                        <%
                                }
                            }else if(users("admin")){
                        %>
                        <div class="product-button">
                            <button class="button-cart disabled">
                                <i class="fas fa-shopping-cart"></i> LOGIN AS CUTOMER
                            </button>
                            <button class="button-buy disabled">
                                LOGIN AS CUSTOMER TO BUY
                            </button>
                        </div>
                        <%
                            }
                        %>
                    </form>
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

    
    <script>
        var qty = document.getElementById("qty");
        var stock = parseInt(document.getElementById("stock").value);
        qty.addEventListener("input", checkValue);

        function checkValue(){
            if(parseInt(qty.value) > stock){
                qty.value = stock;
            }
        }
    </script>
</body>
</html>