<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(users("guest")){
        session.setAttribute("fromCartGuest", "yes");
        response.sendRedirect(loginPath);
        return;
    }else if(users("admin")){
        session.setAttribute("fromCartAdmin", "yes");
        response.sendRedirect(root);
        return;
    }
    
    String insertDone = (String) session.getAttribute("insertDone");
    String updateDone = (String) session.getAttribute("updateDone");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Address - Slime</title>
    <link rel="shortcut icon" type="image/png" href="<%= root %>/asset/slime_logo.png">
    <!-- CSS -->
    <link rel="stylesheet" href="<%= root %>/css/style.css">
    <!-- JS -->
    <script src="https://kit.fontawesome.com/ee59162344.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
</head>
<body>
    <%
        if(insertDone != null){
            if(insertDone.equals("yes")){
    %>
        <script type="text/javascript">
            alert("New address has been inserted!");
        </script>   
    <%
            }
        }else if(updateDone != null){
            if(updateDone.equals("yes")){
    %>
        <script type="text/javascript">
            alert("Address has been updated!");
        </script>   
    <%
            }
        }
    %>
    <div class="header" id="header">
        <%@ include file="/headerfooter/header.jsp" %>
    </div>
    
    <div class="container manage">
        <h1>My Address</h1>
        <div class="row">
            <table>
                <thead>
                    <tr>
                        <th class="center" scope="col">ID</th>
                        <th scope="col">Address</th>
                        <th scope="col">Full Name</th>
                        <th scope="col">Phone Number</th>
                        <th scope="col">Province</th>
                        <th scope="col">District</th>
                        <th scope="col">Sub District</th>
                        <th scope="col">Postal Code</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int limit = 5;
                        String pageParam = request.getParameter("page");
    
                        int pageNumber = 1;
                        try{
                            pageNumber = Integer.parseInt(pageParam);
                        } catch (NumberFormatException e){
    
                        }
    
                        int offset = (pageNumber - 1) * limit;
     
                        String query = String.format("SELECT * FROM address JOIN users ON address.user_id = users.user_id WHERE users.user_id = ? ORDER BY address_id ASC LIMIT %d, %d", offset, limit);

                        ResultSet rs = Connect.query(query, user.sId());
                        while(rs.next()){
                    %>
                            <tr>
                                <th scope="row"><%= rs.getInt("address_id") %></th>
                                <td><%= rs.getString("address_detail") %></td>
                                <td><%= rs.getString("address_full_name") %></td>
                                <td><%= rs.getString("address_phone_number") %></td>
                                <td><%= rs.getString("address_province") %></td>
                                <td><%= rs.getString("address_district") %></td>
                                <td><%= rs.getString("address_subdistrict") %></td>
                                <td><%= rs.getString("address_postal_code") %></td>
                                <td>
                                    <div>
                                        <a href="editAddress.jsp?id=<%= rs.getInt("address_id") %>">
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
                        uri += "page=";

                        rs = Connect.query("SELECT COUNT(*) FROM address JOIN users ON address.user_id = users.user_id WHERE users.user_id = ? ", user.sId());
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
            <form action="insertAddress.jsp">
                <div class="form-item form-button">
                    <button type="submit">Insert New Address</button>
                </div>
            </form>
        </div>
    </div>

    <%
        session.setAttribute("deleteDone", null);
        session.setAttribute("invalidUser", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>