<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    String fromCartAdmin = (String) session.getAttribute("fromCartAdmin");
    String fromLoginNotGuest = (String) session.getAttribute("fromLoginNotGuest");
    String fromNotAdmin = (String) session.getAttribute("fromNotAdmin");
    String InvalidProduct = (String) session.getAttribute("InvalidProduct");
    session.setAttribute("location", root);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SLIME</title>
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
    <%
        if(fromCartAdmin != null){
            if(fromCartAdmin.equals("yes")){
    %>
        <script type="text/javascript">
            alert("Please Login as a Customer!");
        </script>   
    <%
            }
        }else if(fromLoginNotGuest != null){
            if(fromLoginNotGuest.equals("yes")){
    %>
        <script type="text/javascript">
            alert("Please Logout first!");
        </script>   
    <%
            }
        }else if(fromNotAdmin != null){
            if(fromNotAdmin.equals("yes")){
    %>
        <script type="text/javascript">
            alert("You are not registered as an administrator!");
        </script>   
    <%
            }
        }else if(InvalidProduct != null){
            if(InvalidProduct.equals("yes")){
    %>
        <script type="text/javascript">
            alert("Invalid Product!");
        </script>   
    <%
            }
        }
    %>

    <div class="slider">
        <div class="image-container" id="image-container">
            <div class="slide">
                <img src="<%= root %>/asset/banner3.jpg">
            </div>
            <div class="slide">
                <img src="<%= root %>/asset/banner2.jpg">
            </div>
            <div class="slide">
                <img src="<%= root %>/asset/banner1.jpg">
            </div>
       
            <!-- Next and Previous icon to change images -->
            <a class="previous" onclick="moveSlides(-1)">
                <i class="fa fa-chevron-circle-left"></i>
            </a>
            <a class="next" onclick="moveSlides(1)">
                <i class="fa fa-chevron-circle-right"></i>
            </a>
        </div>
    
        <br>
    
        <div class="center slider-dot">
            <span class="footerdot" 
                onclick="activeSlide(1)">
            </span>
            <span class="footerdot"
                onclick="activeSlide(2)">
            </span>
            <span class="footerdot" 
                onclick="activeSlide(3)">
            </span>
        </div>
    </div>

    <div class="container product">
        <h2 class="center">Snack Lives In My EveryDays</h2>
            <%
                String query = "SELECT * FROM snacks JOIN snack_category ON snacks.snack_category_id = snack_category.snack_category_id ORDER BY snack_name ASC LIMIT 6";
                
                ResultSet rs = Connect.query(query);
                while(rs.next()){
            %>
                <div class="row product-row">
                    <div class="col product-item">
                        <div class="product-item-top">
                            <img src="<%= rs.getString("snack_cover_url") %>" alt="<%= rs.getString("snack_name") %>">
                            <div class="product-name truncate">
                                <%= rs.getString("snack_name") %>
                            </div>
                            <div class="product-category-name">
                                <%= rs.getString("snack_category_name") %>
                            </div>
                            <div class="product-price">
                                <%= formatRupiah(rs.getInt("snack_price")) %>
                            </div>
                            <div class="product-stock">
                                <%= rs.getInt("snack_stock") %> pieces available
                            </div>
                        </div>

                        <div class="view-detail">
                            <a href="<%= root %>/products/product.jsp?id=<%= rs.getInt("snack_id")%>">View Detail</a>
                        </div>
                    </div>

            <%
                    if(rs.next()){
            %>
                    <div class="col product-item">
                        <div class="product-item-top">
                            <img src="<%= rs.getString("snack_cover_url") %>" alt="<%= rs.getString("snack_name") %>">
                            <div class="product-name truncate">
                                <%= rs.getString("snack_name") %>
                            </div>
                            <div class="product-category-name">
                                <%= rs.getString("snack_category_name") %>
                            </div>
                            <div class="product-price">
                                <%= formatRupiah(rs.getInt("snack_price")) %>
                            </div>
                            <div class="product-stock">
                                <%= rs.getInt("snack_stock") %> pieces available
                            </div>
                        </div>

                        <div class="view-detail">
                            <a href="<%= root %>/products/product.jsp?id=<%= rs.getInt("snack_id")%>">View Detail</a>
                        </div>
                        
                    </div>

            <%
                    }else{
            %>
                    <div class="col"></div>
            <% 
                    }
                    if(rs.next()){
            %>
                    <div class="col product-item">
                        <div class="product-item-top">
                            <img src="<%= rs.getString("snack_cover_url") %>" alt="<%= rs.getString("snack_name") %>">
                            <div class="product-name truncate">
                                <%= rs.getString("snack_name") %>
                            </div>
                            <div class="product-category-name">
                                <%= rs.getString("snack_category_name") %>
                            </div>
                            <div class="product-price">
                                <%= formatRupiah(rs.getInt("snack_price")) %>
                            </div>
                            <div class="product-stock">
                                <%= rs.getInt("snack_stock") %> pieces available
                            </div>
                        </div>

                        <div class="view-detail">
                            <a href="<%= root %>/products/product.jsp?id=<%= rs.getInt("snack_id")%>">View Detail</a>
                        </div>
                    </div>
            <%
                    }else{
            %>
                    <div class="col"></div>
            <%      }
            %>
                </div>
            <%
                }
            
        
            if(users("guest")){
        %>
            <h3 class="center">Login to see more products</h3>
        <%
            }
        %>
        <br><br>
    </div>

    <%
        session.setAttribute("fromCartAdmin", null);
        session.setAttribute("fromLoginNotGuest", null);
        session.setAttribute("fromNotAdmin", null);
        session.setAttribute("InvalidProduct", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>

    
    <script src="<%= root %>/js/slider.js"></script>
</body>
</html>