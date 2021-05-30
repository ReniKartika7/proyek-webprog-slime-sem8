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
    String id = request.getParameter("id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choose Address - Slime</title>
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
        <h1>My Address</h1>
        <br>

        <form method="POST">

        <%
            session.setAttribute("loc", "chooseAddress");
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
            <div class="choose-address">
                <input type="radio" name="choosenAddress" id="<%= rs.getInt("address_id") %>" value="<%= rs.getInt("address_id") %>">
                <label for="choosenAddress"> Choose this address </label>
            </div>
            
            <a class="card-view choose-address" href="editAddress.jsp?id=<%= rs.getInt("address_id") %></a>">
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
            </a>
        <%
            }
        %>

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
        <div class="row choose-btn">
            <div class="product-button">
                    <button class="button-cart" type="submit" formaction="<%= root + "/address/doChoose.jsp?id=" + id %>">Choose Address</button>
            </div>
        </div>
        <div class="row choose-btn">
            <div class="product-button">
                <button class="button-buy" type="submit" formaction="insertAddress.jsp">Insert New Address</button>
            </div>
        </div>
        
        </forms>
    </div>

    <%
        session.setAttribute("alertMessage", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>