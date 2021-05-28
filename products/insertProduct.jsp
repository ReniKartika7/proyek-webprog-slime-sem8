<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(!users("admin")){
        session.setAttribute("alertMessage", "You are not registered as an Admin !");
        response.sendRedirect(root);
        return;
    }

    String name = (String) session.getAttribute("name");
    String price = (String) session.getAttribute("price");
    String stock = (String) session.getAttribute("stock");
    String coverUrl = (String) session.getAttribute("coverUrl");
    String snackCategory = (String) session.getAttribute("snackCategory");
    String detail = (String) session.getAttribute("detail");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Product Admin - Slime</title>
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
        <div class="center">
            <h1>INSERT PRODUCT</h1>
        </div>
        <div class="row">
            <div class="col form-container register-form">
                <br><br>
                <form action="doInsert.jsp" method="POST" class="form">
                    <div class="form-item">
                        <input type="text" name="name" placeholder="Name" value="<%= name == null ? "" : name %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorName = (String) session.getAttribute("errorName");
            
                            if(errorName != null){
                                out.println(errorName);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="number" name="price" placeholder="Price" value="<%= price == null ? "" : price %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorPrice = (String) session.getAttribute("errorPrice");
            
                            if(errorPrice != null){
                                out.println(errorPrice);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="number" name="stock" placeholder="Stock" value="<%= stock == null ? "" : stock %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorStock = (String) session.getAttribute("errorStock");
            
                            if(errorStock != null){
                                out.println(errorStock);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="text" name="coverUrl" placeholder="Cover Url" value="<%= coverUrl == null ? "" : coverUrl %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorCoverUrl = (String) session.getAttribute("errorCoverUrl");
            
                            if(errorCoverUrl != null){
                                out.println(errorCoverUrl);
                            }
                        %>
                    </div>
                    <div class="form-item left">
                        <br>
                        Product Category :
                        <br>
                        <select name="snackCategory" id="snackCategory">
                            <option value="" selected>Select Category</option>
                            <%
                                String query = "SELECT * FROM snack_category";

                                ResultSet rsc = Connect.query(query);
                                while(rsc.next()){
                            %>
                                <option value="<%= rsc.getInt("snack_category_id") %>"  <%= rsc.getString("snack_category_id") == snackCategory ? "selected" : "" %> ><%= rsc.getString("snack_category_name") %></option>  
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-error left">
                        <%
                            String errorProductCategory = (String) session.getAttribute("errorProductCategory");
            
                            if(errorProductCategory != null){
                                out.println(errorProductCategory);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <textarea name="detail" id="detail"
                        rows="5" placeholder="Snack Detail" maxlength="450"><%= detail == null ? "" : detail %></textarea>
                    </div>
                    <div class="form-error left">
                        <%
                            String errorSnackDetail = (String) session.getAttribute("errorSnackDetail");
            
                            if(errorSnackDetail != null){
                                out.println(errorSnackDetail);
                            }
                        %>
                    </div>
                    <div class="form-item form-button">
                        <button type="submit">INSERT PRODUCT</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%
        session.setAttribute("name", null);
        session.setAttribute("price", null);
        session.setAttribute("stock", null);
        session.setAttribute("coverUrl", null);
        session.setAttribute("snackCategory", null);
        session.setAttribute("detail", null);
        session.setAttribute("errorName", null);
        session.setAttribute("errorPrice", null);
        session.setAttribute("errorStock", null);
        session.setAttribute("errorCoverUrl", null);
        session.setAttribute("errorProductCategory", null);
        session.setAttribute("errorSnackDetail", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>