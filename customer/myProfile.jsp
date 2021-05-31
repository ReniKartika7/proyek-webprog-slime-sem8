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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Slime</title>
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
    
    <input type="hidden" name="alertMessage" id="alertMessage" value="<%= alertMessage %>">
    <%
        Integer total, count;
        ResultSet rstotal;
        if(alertMessage != null){
    %>
        <script type="text/javascript">
            var txt = document.getElementById("alertMessage").value;
            alert(txt);
        </script>   
    <%
        }
    %>

    <div class="container my-profile">
        <div class="center">
            <h1>MY PROFILE</h1>
        </div>
        <div class="row">
            <div class="col">
                <img src="<%= root %>/asset/<%= user.user_gender %>.png" alt="Profile Pict">
            </div>
            <div class="col user-short-desc">
                <div class="user-name">
                    <%=user.user_name%>
                </div>
                <div class="edit-profile-text">
                    <a href="<%= root %>/customer/editProfile.jsp">
                        Edit your profile here <i class="fas fa-angle-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="row transaction-container">
            <%
                String checkTransaction = "SELECT transaction_id FROM transaction_header WHERE user_id = ?";
                ResultSet rs = Connect.query(checkTransaction, Integer.toString(user.user_id));

                if(rs == null || !rs.next()){
            %>
                    <div class="transaction-empty">
                        You haven't bought any product yet !
                        <br>
                        Browse our products in <u><a href="<%= productPath %>">here</a></u> ! 
                    </div>
            <%
                }else if (rs != null){
            %>
                    <div class="transaction-detail">
                        <h2 class="center">Shopping List</h2>
                        <%
                            int limit = 6;
                            String pageParam = request.getParameter("page");

                            int pageNumber = 1;
                            try{
                                pageNumber = Integer.parseInt(pageParam);
                            } catch (NumberFormatException e){

                            }

                            int offset = (pageNumber - 1) * limit;

                            String query = String.format("SELECT * FROM transaction_header WHERE user_id = ? ORDER BY transaction_id ASC LIMIT %d, %d", offset, limit);

                            String query2 = "";

                            ResultSet rss = Connect.query(query, user.sId());
                            while(rss.next()){
                        %>
                        <div class="row product-row">
                            <div class="col product-item">
                                <div class="product-item-top">
                                    <img src="<%= root %>/asset/slime_logo.png" alt="Slime-logo" class="trans-slime-img">
                                    <div class="trans-date">
                                        <%= rss.getString("transaction_date") %>
                                    </div>
                                    <div class="trans-total-price">
                                        <%
                                            query2 = "SELECT * FROM transaction_detail JOIN snacks ON transaction_detail.snack_id = snacks.snack_id WHERE transaction_id = ?";

                                            rstotal = Connect.query(query2, rss.getString("transaction_id"));

                                            total = 0;
                                            count = 0;
                                            while(rstotal.next()){
                                                total = total + rstotal.getInt("snack_price") * rstotal.getInt("quantity");

                                                count++;
                                            }

                                            if(total < 120000){
                                                total = total + 10000;
                                            }

                                            out.println(formatRupiah(total));
                                        %>
                                    </div>
                                    <div class="trans-item-purc">
                                        <%=count%> item(s) purchased
                                    </div>
                                </div>
        
                                <div class="view-detail">
                                    <a href="viewTransactionDetail.jsp?id=<%= rss.getInt("transaction_id")%>">View Detail</a>
                                </div>
                            </div>
        
                            <%
                                if(rss.next()){
                            %>
                            <div class="col product-item">
                                <div class="product-item-top">
                                    <img src="<%= root %>/asset/slime_logo.png" alt="Slime-logo" class="trans-slime-img">
                                    <div class="trans-date">
                                        <%= rss.getString("transaction_date") %>
                                    </div>
                                    <div class="trans-total-price">
                                        <%
                                            query2 = "SELECT * FROM transaction_detail JOIN snacks ON transaction_detail.snack_id = snacks.snack_id WHERE transaction_id = ?";

                                            rstotal = Connect.query(query2, rss.getString("transaction_id"));

                                            total = 0;
                                            count = 0;
                                            while(rstotal.next()){
                                                total = total + rstotal.getInt("snack_price") * rstotal.getInt("quantity");

                                                count++;
                                            }

                                            if(total < 120000){
                                                total = total + 10000;
                                            }

                                            out.println(formatRupiah(total));
                                        %>
                                    </div>
                                    <div class="trans-item-purc">
                                        <%=count%> item(s) purchased
                                    </div>
                                </div>

                                <div class="view-detail">
                                    <a href="viewTransactionDetail.jsp?id=<%= rss.getInt("transaction_id")%>">View Detail</a>
                                </div>
                            </div>
        
                            <%
                                }else{
                            %>
                            <div class="col"></div>
                            <% 
                                }
                                
                                if(rss.next()){
                            %>
                            <div class="col product-item">
                                <div class="product-item-top">
                                    <img src="<%= root %>/asset/slime_logo.png" alt="Slime-logo" class="trans-slime-img">
                                    <div class="trans-date">
                                        <%= rss.getString("transaction_date") %>
                                    </div>
                                    <div class="trans-total-price">
                                        <%
                                            query2 = "SELECT * FROM transaction_detail JOIN snacks ON transaction_detail.snack_id = snacks.snack_id WHERE transaction_id = ?";

                                            rstotal = Connect.query(query2, rss.getString("transaction_id"));

                                            total = 0;
                                            count = 0;
                                            while(rstotal.next()){
                                                total = total + rstotal.getInt("snack_price") * rstotal.getInt("quantity");

                                                count++;
                                            }

                                            if(total < 120000){
                                                total = total + 10000;
                                            }

                                            out.println(formatRupiah(total));
                                        %>
                                    </div>
                                    <div class="trans-item-purc">
                                        <%=count%> item(s) purchased
                                    </div>
                                </div>
        
                                <div class="view-detail">
                                    <a href="viewTransactionDetail.jsp?id=<%= rss.getInt("transaction_id")%>">View Detail</a>
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
                    </div>

                    <div class="row ">
                        <div class="navbar">
                            <ul class="navbar-content">
                                <%
                                    String uri = request.getRequestURI() + "?";                      
                                %>
                                <input type="hidden" name="uri" value="<%= uri %>" id="uri">
                                <%   
                                    uri += "page=";
            
                                    rs = Connect.query("SELECT COUNT(*) FROM transaction_header WHERE user_id = ? ", user.sId());
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
            <%
                }
            %>

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