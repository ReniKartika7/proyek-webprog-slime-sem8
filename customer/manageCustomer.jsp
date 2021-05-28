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
    <title>Manage Customer - Slime</title>
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
        <h1>Manage User</h1>
        <div class="row">
            <table>
                <thead>
                    <tr>
                        <th class="center" scope="col">ID</th>
                        <th scope="col">Email</th>
                        <th scope="col">Name</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Gender</th>
                        <th scope="col">Role</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int limit = 10;
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

                        where = "WHERE user_name LIKE ?";
     
                        String query = String.format("SELECT * FROM users %s ORDER BY user_id ASC LIMIT %d, %d", where, offset, limit);

                        ResultSet rs = Connect.query(query, like);
                        while(rs.next()){
                    %>
                            <tr>
                                <th scope="row"><%= rs.getInt("user_id") %></th>
                                <td><%= rs.getString("user_email") %></td>
                                <td><%= rs.getString("user_name") %></td>
                                <td><%= rs.getString("user_phone") %></td>
                                <td><%= rs.getString("user_gender") %></td>
                                <td><%= rs.getBoolean("is_admin") ? "admin" : "customer" %></td>
                                <td>
                                    <div>
                                        <a href="editProfileAdmin.jsp?id=<%= rs.getInt("user_id") %>">
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

                        rs = Connect.query("SELECT COUNT(*) FROM users " + where, like);
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
    
    <%
        session.setAttribute("alertMessage", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>