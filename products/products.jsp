<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(users("guest")){
        session.setAttribute("fromCartGuest", "yes");
        response.sendRedirect(loginPath);
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - Slime</title>
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
        <div class="row">
            <div class="col product-category-container" id="product-category-container">
                <h4>Product Category</h4>
                <div class="product-category">
                    <input type="radio" id="All" name="snack-category" value="All" checked>
                <label for="All"> All </label>
                </div>
                <%
                    String selectedCategory = request.getParameter("snack-category");
                    if(selectedCategory != null && selectedCategory.equals("All")){
                        selectedCategory = "";
                    }
                    String query = "SELECT * FROM snack_category";
                    ResultSet rs = Connect.query(query);
                    while(rs.next()){
                        Integer snackCategoryId = rs.getInt("snack_category_id");
                        String snackCategoryName = rs.getString("snack_category_name");
                %>
                        <div class="product-category">
                            <input type="radio" id="<%= snackCategoryId %>" name="snack-category" value="<%= snackCategoryName %>" <%= selectedCategory == null ? "" : selectedCategory.equals(snackCategoryName) ? "checked" : "" %>>
                        <label for="<%= snackCategoryId %>"> <%= snackCategoryName %> </label>
                        </div>
                <%
                    }
                %> 
            </div>
            <div class="col4">
                <h2 class="center">Snack Lives in My Everyday</h2>
                <%
                    int limit = 6;
                    String searchKeyword = request.getParameter("search");
                    String pageParam = request.getParameter("page");

                    int pageNumber = 1;
                    try{
                        pageNumber = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e){

                    }

                    int offset = (pageNumber - 1) * limit;
                    String where = "";
                    String like = "%" + (searchKeyword == null ? "" : searchKeyword) + "%";
                    String like2 = "%" + (selectedCategory == null ? "" : selectedCategory) + "%";
                    where = "WHERE snack_name LIKE ? AND snack_category_name LIKE ?";

                    query = String.format("SELECT * FROM snacks JOIN snack_category ON snacks.snack_category_id = snack_category.snack_category_id %s ORDER BY snack_name ASC LIMIT %d, %d", where, offset, limit);

                    ResultSet rss = Connect.query(query, like, like2);
                    while(rss.next()){
                %>
                        <div class="row product-row">
                            <div class="col product-item">
                                <div class="product-item-top">
                                    <img src="<%= rss.getString("snack_cover_url") %>" alt="<%= rss.getString("snack_name") %>">
                                    <div class="product-name truncate">
                                        <%= rss.getString("snack_name") %>
                                    </div>
                                    <div class="product-category-name">
                                        <%= rss.getString("snack_category_name") %>
                                    </div>
                                    <div class="product-price">
                                        <%= formatRupiah(rss.getInt("snack_price")) %>
                                    </div>
                                    <div class="product-stock">
                                        <%= rss.getInt("snack_stock") %> pieces available
                                    </div>
                                </div>
        
                                <div class="view-detail">
                                    <a href="<%= root %>/products/product.jsp?id=<%= rss.getInt("snack_id")%>">View Detail</a>
                                </div>
                            </div>
        
                    <%
                            if(rss.next()){
                    %>
                            <div class="col product-item">
                                <div class="product-item-top">
                                    <img src="<%= rss.getString("snack_cover_url") %>" alt="<%= rss.getString("snack_name") %>">
                                    <div class="product-name truncate">
                                        <%= rss.getString("snack_name") %>
                                    </div>
                                    <div class="product-category-name">
                                        <%= rss.getString("snack_category_name") %>
                                    </div>
                                    <div class="product-price">
                                        <%= formatRupiah(rss.getInt("snack_price")) %>
                                    </div>
                                    <div class="product-stock">
                                        <%= rss.getInt("snack_stock") %> pieces available
                                    </div>
                                </div>

                                <div class="view-detail">
                                    <a href="<%= root %>/products/product.jsp?id=<%= rss.getInt("snack_id")%>">View Detail</a>
                                </div>
                            </div>
        
                    <%
                            }else{
                    %>
                            <div class="col"></div>
                    <% 
                            }
                    %>
                        </div>
                    <%
                        }
                    %>

                    <div class="row ">
                        <div class="navbar">
                            <ul class="navbar-content">
                                <%
                                    String uri = request.getRequestURI() + "?";
                                    if (searchKeyword != null){
                                        uri += "search=" + searchKeyword + "&";
                                    }                       
                                %>
                                <input type="hidden" name="uri" value="<%= uri %>" id="uri">
                                <%
                                    if (selectedCategory != null){
                                        uri += "snack-category=" + selectedCategory + "&";
                                    }      
                                    uri += "page=";

                                    rs = Connect.query("SELECT COUNT(*) FROM snacks JOIN snack_category ON snacks.snack_category_id = snack_category.snack_category_id " + where, like, like2);
                                    rs.first();

                                    int lastPage = (rs.getInt(1) - 1) / limit + 1;
                                    int middlePage = pageNumber;
                                    if(middlePage == 1){
                                        middlePage++;
                                    }
                                    if(middlePage == lastPage){
                                        middlePage--;
                                    }

                                    if (pageNumber != 1) {
                                %>
                                        <li class="navbar-item">
                                            <a href="<%= uri + (pageNumber - 1) %>">Prev</a>
                                        </li>
                                <%
                                    }

                                    int start = (middlePage - 1 < 1) ? 1 : (middlePage - 1);
                                    int end = (middlePage + 1 > lastPage) ? lastPage : (middlePage + 1);

                                    for(int i = start; i <= end; i++){
                                %>
                                    <li class="navbar-item">
                                        <a class="<%= i == pageNumber ? "active-navbar" : "" %>" href="<%= uri + i %>"><%= i %></a>
                                    </li>    
                                <%
                                    }

                                    if(pageNumber != lastPage){
                                %>
                                    <li class="navbar-item">
                                        <a href="<%= uri + (pageNumber + 1) %>">Next</a>
                                    </li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
            </div>
        </div>
    </div>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>

    <script>
        $('#product-category-container input[type="radio"]').click(function() {
            var uri = document.getElementById("uri").value;
            var ele = document.getElementsByTagName('input');
            var selected;
            
            for(i = 0; i < ele.length; i++) {
                if(ele[i].type="radio") {
                
                    if(ele[i].checked){
                        selected = ele[i].value;
                    }
                }
            }
            uri = uri + "snack-category=" + selected ;
            location.replace(uri);
        });
    </script>
</body>
</html>