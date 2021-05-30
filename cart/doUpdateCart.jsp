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

    String snackId = request.getParameter("snackId");
    String qty = request.getParameter("qty");
    if(snackId == null || snackId.isEmpty() || qty == null || qty.isEmpty() || qty.equals("0")){
        session.setAttribute("alertMessage", "Invalid Product!");
        response.sendRedirect("myCart.jsp");
        return;
    }

    String query = "SELECT * FROM cart WHERE user_id = ? AND snack_id = ?";

    ResultSet rs = Connect.query(query, user.sId(), snackId);
    
    if(rs.first()){
        query = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
        Connect.update(query, qty, Integer.toString(rs.getInt("cart_id")));
    }
%>