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

    String choosenAddress = (String) request.getParameter("choosenAddress");
    String id = request.getParameter("id");
    
    if(choosenAddress == null || choosenAddress.isEmpty()){
        session.setAttribute("alertMessage", "You have to choose shipping address!");
        response.sendRedirect("chooseAddress.jsp?id=" + id);
        return;
    }

    String query = "SELECT * FROM  `address` JOIN users ON address.user_id = users.user_id WHERE users.user_id = ? AND address_id = ?";

    ResultSet rs = Connect.query(query, user.sId(), choosenAddress);
    if(!rs.first()){
        session.setAttribute("alertMessage", "Invalid Address!");
        response.sendRedirect("chooseAddress.jsp?id=" + id);
        return;
    }

    session.setAttribute("addressId", choosenAddress);
    response.sendRedirect(root + "/cart/checkOut.jsp?id=" + id);
    
%>