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

    String address = (String) session.getAttribute("address");
    String name = (String) session.getAttribute("name");
    String phoneNumber = (String) session.getAttribute("phoneNumber");
    String province = (String) session.getAttribute("province");
    String district = (String) session.getAttribute("district");
    String subDistrict = (String) session.getAttribute("subDistrict");
    String postalCode = (String) session.getAttribute("postalCode");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Address - Slime</title>
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
            <div class="col form-container register-form">
                <h2 class="center">Insert Address</h2>
                <form action="doInsert.jsp" method="POST" class="form">
                    <div class="form-item">
                        <input type="text" name="address" placeholder="Address" value="<%= address == null ? "" : address%>">
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
                        <input type="text" name="name" placeholder="Name" value="<%= name == null ? "" : name%>">
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
                        <input type="text" name="phoneNumber" placeholder="Phone Number" value="<%= phoneNumber == null ? "" : phoneNumber%>">
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
                        <input type="text" name="province" placeholder="Province" value="<%= province == null ? "" : province%>">
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
                        <input type="text" name="district" placeholder="District" value="<%= district == null ? "" : district%>">
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
                        <input type="text" name="subDistrict" placeholder="Sub District" value="<%= subDistrict == null ? "" : subDistrict %>">
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
                        <input type="text" name="postalCode" placeholder="Postal Code" value="<%= postalCode == null ? "" : postalCode %>">
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
                        <button type="submit">Insert Address</button>
                    </div>
                </form>
                
            </div>
        </div>
    </div>

    <%
        session.setAttribute("address", null);
        session.setAttribute("name", null);
        session.setAttribute("phoneNumber", null);
        session.setAttribute("province", null);
        session.setAttribute("district", null);
        session.setAttribute("subDistrict", null);
        session.setAttribute("postalCode", null);
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