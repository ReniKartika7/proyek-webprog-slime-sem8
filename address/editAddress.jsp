<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<%
    String id = request.getParameter("id");
    String loc = (String) session.getAttribute("loc");
    if(loc == null || loc.isEmpty()){
        loc = "myAddress";
    }
    session.setAttribute("loc", loc);

    if(users("admin")){
        session.setAttribute("alertMessage", "You are not login as a customer");
        response.sendRedirect(root);
        return;
    }else if(users("guest")){
        session.setAttribute("alertMessage", "Please Login first!");
        response.sendRedirect(loginPath);
        return;
    }else if(id == null || id.isEmpty()){
        session.setAttribute("alertMessage", "Invalid Address!");
        response.sendRedirect(loc + ".jsp");
        return;
    }
    String query = "SELECT * FROM address JOIN users ON address.user_id = users.user_id WHERE users.user_id = ? AND address_id = ?";

    ResultSet rs = Connect.query(query, user.sId(), id);
    if(!rs.first()){
        session.setAttribute("alertMessage", "Invalid Address!");
        response.sendRedirect(loc + ".jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Address - Slime</title>
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
            <h1>EDIT ADDRESS</h1>
        </div>
        <div class="row">
            <div class="col form-container register-form">
                <br><br>
                <form action="doEdit.jsp?id=<%= rs.getInt("address_id") %>" method="POST" class="form">
                    <div class="form-item">
                        <input type="text" name="address" placeholder="Address" value="<%= rs.getString("address_detail") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorAddress = (String) session.getAttribute("errorAddress");
            
                            if(errorAddress != null){
                                out.println(errorAddress);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="text" name="name" placeholder="Name" value="<%= rs.getString("address_full_name") %>">
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
                        <input type="text" name="phoneNumber" placeholder="Phone Number" value="<%= rs.getString("address_phone_number") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorPhoneNumber = (String) session.getAttribute("errorPhoneNumber");
            
                            if(errorPhoneNumber != null){
                                out.println(errorPhoneNumber);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="text" name="province" placeholder="Province" value="<%= rs.getString("address_province") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorProvince = (String) session.getAttribute("errorProvince");
            
                            if(errorProvince != null){
                                out.println(errorProvince);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="text" name="district" placeholder="District" value="<%= rs.getString("address_district") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorDistrict = (String) session.getAttribute("errorDistrict");
            
                            if(errorDistrict != null){
                                out.println(errorDistrict);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="text" name="subDistrict" placeholder="Sub District" value="<%= rs.getString("address_subdistrict") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorSubDistrict = (String) session.getAttribute("errorSubDistrict");
            
                            if(errorSubDistrict != null){
                                out.println(errorSubDistrict);
                            }
                        %>
                    </div>
                    <div class="form-item">
                        <input type="text" name="postalCode" placeholder="Postal Code" value="<%= rs.getString("address_postal_code") %>">
                    </div>
                    <div class="form-error left">
                        <%
                            String errorPostalCode = (String) session.getAttribute("errorPostalCode");
            
                            if(errorPostalCode != null){
                                out.println(errorPostalCode);
                            }
                        %>
                    </div>
                    <div class="form-item form-button">
                        <button type="submit">EDIT ADDRESS</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%
        session.setAttribute("errorAddress", null);
        session.setAttribute("errorName", null);
        session.setAttribute("errorPhoneNumber", null);
        session.setAttribute("errorProvince", null);
        session.setAttribute("errorDistrict", null);
        session.setAttribute("errorSubDistrict", null);
        session.setAttribute("errorPostalCode", null);
    %>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>