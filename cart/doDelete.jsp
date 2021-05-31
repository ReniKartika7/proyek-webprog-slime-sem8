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
    
    if(id == null){
        session.setAttribute("alertMessage", "Invalid Product !");
        response.sendRedirect(root);
        return;
    }else{
        String delete = "DELETE FROM cart WHERE user_id = ? AND snack_id = ?";
        Connect.update(delete, user.sId(), id);

        session.setAttribute("alertMessage", "Product has been deleted from cart!");
        response.sendRedirect("myCart.jsp");
    }

%>