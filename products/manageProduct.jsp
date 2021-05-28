<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(!users("admin")){
        session.setAttribute("alertMessage", "You are not registered as an Admin !");
        response.sendRedirect(root);
        return;
    }

    String alertMessage = (String) session.getAttribute("alertMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Product - Slime</title>
    <link rel="shortcut icon" type="image/png" href="<%= root %>/asset/slime_logo.png">
    <!-- CSS -->
    <link rel="stylesheet" href="<%= root %>/css/style.css">
    <!-- JS -->
    <script src="https://kit.fontawesome.com/ee59162344.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
</head>
<body>

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
    
    <div class="header" id="header">
        <%@ include file="/headerfooter/header.jsp" %>
    </div>
    
    <div class="container manage">
        <h1>Manage Product</h1>
        <div class="row">
            <table>
                <thead>
                    <tr>
                        <th class="center" scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Price</th>
                        <th scope="col">Stock</th>
                        <th scope="col">Cover Url</th>
                        <th scope="col">Category</th>
                        <th scope="col">Description</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int limit = 7;
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

                        where = "WHERE snack_name LIKE ?";
     
                        String query = String.format("SELECT * FROM snacks JOIN snack_category ON snacks.snack_category_id = snack_category.snack_category_id %s ORDER BY snack_id ASC LIMIT %d, %d", where, offset, limit);

                        ResultSet rs = Connect.query(query, like);
                        while(rs.next()){
                    %>
                            <tr>
                                <th scope="row"><%= rs.getInt("snack_id") %></th>
                                <td><%= rs.getString("snack_name") %></td>
                                <td><%= rs.getInt("snack_price") %></td>
                                <td><%= rs.getInt("snack_stock") %></td>
                                <td><%= rs.getString("snack_category_name") %></td>
                                <td><%= rs.getString("snack_cover_url") %></td>
                                <td><%= rs.getString("snack_detail") %></td>
                                <td>
                                    <div>
                                        <a href="editProduct.jsp?id=<%= rs.getInt("snack_id") %>">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="row">
            <div class="navbar">
                <ul class="navbar-content">
                    <%
                        String uri = request.getRequestURI() + "?";
                        if (searchKeyword != null){
                            uri += "search=" + searchKeyword + "&";
                        }
                        uri += "page=";

                        rs = Connect.query("SELECT COUNT(*) FROM snacks JOIN snack_category ON snacks.snack_category_id = snack_category.snack_category_id " + where, like);
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
        <div class="row">
            <form action="insertProduct.jsp">
                <div class="form-item form-button">
                    <button type="submit">Insert New Product</button>
                </div>
            </form>
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