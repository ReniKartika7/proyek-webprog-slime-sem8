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

    String query = "SELECT * FROM cart JOIN snacks ON cart.snack_id = snacks.snack_id WHERE user_id = ? AND cart.snack_id = ?";

    ResultSet rs = Connect.query(query, user.sId(), id);
    if(rs.first()){
        qty = qty + rs.getInt("quantity");

        if(qty > rs.getInt("snack_stock")){
            qty = rs.getInt("snack_stock");
        }

        query = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
        Connect.update(query, Integer.toString(qty), Integer.toString(rs.getInt("cart_id")));
    }else{
        query ="INSERT INTO cart (user_id, snack_id, quantity) VALUES (?, ?, ?)";
        Connect.update(query, user.sId(), id, Integer.toString(qty));
    }
    
    session.setAttribute("alertMessage", "Successfully added to cart!");
    response.sendRedirect(root + "/products/product.jsp?id=" + id);
%>