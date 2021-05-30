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

    String id = request.getParameter("id");
    if(id == null || id.isEmpty()){
        session.setAttribute("alertMessage", "Invalid Product!");
        response.sendRedirect(root);
        return;
    }

    Integer qty = Integer.parseInt(request.getParameter("qty"));
    if(qty <= 0){
        session.setAttribute("alertMessage", "You have to choose at least one pieces!");
        response.sendRedirect(root + "/products/product.jsp?id=" + id);
        return;
    }
    
    session.setAttribute("qty", qty);
    session.setAttribute("loc1", "buyProduct");

    response.sendRedirect("checkOut.jsp?id=" + id);
%>