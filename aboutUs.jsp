<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/services.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Slime</title>
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
        <h1 class="center">ABOUT US</h1>
        <div class="row about-us">
            <div class="col">
                <div class="about-us-desc">
                    SLIME is an online platform where you can find all your favorite imported snacks, also beverages and others. The greatest solution to munchies & the go-to for all your snack cravings. Since 2020, from an offline store we’ve grown into an online shop that can ship worldwide. Our team keep on expanding, all of us have different roles to fill from sourcing and creative to marketing and customer service, but we all have one thing in common: a love of snacks – especially cute ones.
                    Our mission at SLIME is to empower traditional snackmakers by sharing their authentic food and stories with the world, and to bring snack from different part of the Asia together.
                    We oversee every email, social post, and asset that reaches you, not only that but we also check every package before they are sent out.      
                </div>          
            </div>
            <div class="col about-us-img">
                <img src="<%=root%>/asset/slime_logo.png" alt="">
            </div>
        </div>
    </div>

    <div class="footer" id="footer">
        <%@ include file="/headerfooter/footer.jsp" %>
    </div>
</body>
</html>