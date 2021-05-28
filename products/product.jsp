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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Slime</title>
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
                    <div class="product-quantity">
                        <span>Quantity :</span>
                        <div class="quantity-button">
                            <input type="button" value="-" class="button-minus"><input type="number" class="input-qty" size="4" step="1" min="1" max="<%= rsp.getInt("snack_stock") %>" name="product-qty" id="qty" value="1"><input type="button" value="+" class="button-plus">
                        </div>
                        <span class="product-stock" style="margin-left: 1rem; color: grey;"><%= rsp.getInt("snack_stock") %> pieces available</span>
                    </div>

                    <div class="product-button">
                        <button onclick="goToCart()" class="button-cart">
                            <i class="fas fa-shopping-cart"></i> ADD TO CART
                        </button>
                        <button onclick="goToBuy()" class="button-buy">
                            BUY NOW
                        </button>
                        <input type="hidden" name="doCartLocation" id="doCartLocation" value="<%= root %>/cart/doCart.jsp">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>

    
    <script>
        var doCartLocation = document.getElementById("doCartLocation").value;
        function goToCart(){
            location.replace(doCartLocation);
        }

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