<%@ include file="/WEB-INF/services.jsp" %>

<%  
    if(!users("admin")){
        session.setAttribute("alertMessage", "You are not registered as an Admin !");
        response.sendRedirect(root);
        return;
    }

    String id = request.getParameter("id");
    if(id == null || id.isEmpty()){
        session.setAttribute("alertMessage", "Invalid Product!");
        response.sendRedirect("manageProduct.jsp");
        return;
    }

    String query = "SELECT * FROM snacks WHERE snack_id = ?";
    ResultSet rs = Connect.query(query, id);
    if(!rs.first()){
        session.setAttribute("alertMessage", "Invalid Product ID!");
        response.sendRedirect("manageProduct.jsp");
        return;
    }
    
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String stock = request.getParameter("stock");
    String coverUrl = request.getParameter("coverUrl");
    String snackCategory = request.getParameter("snackCategory");
    String detail = request.getParameter("detail");

    int flag = 0;

    if (name.isEmpty()){
        session.setAttribute("errorName", "Product name is required!");
    }else if(name.length() <= 4){
        session.setAttribute("errorName", "Product name must be more than 4 letters!");
    }else{
        session.setAttribute("errorName", "");
        flag++;
    }

    if (price.isEmpty()){
        session.setAttribute("errorPrice", "Price is required!");
    }else if(Integer.parseInt(price) <= 0){
        session.setAttribute("errorPrice", "Price must be more than Rp 0 !");
    }else{
        session.setAttribute("errorPrice", "");
        flag++;
    }

    if(stock.isEmpty()){
        session.setAttribute("errorStock", "Stock is required!");
    }else if(Integer.parseInt(stock) < 0){
        session.setAttribute("errorStock", "Stock must be more than or equal 0 !");
    }else{
        session.setAttribute("errorStock", "");
        flag++;
    }

    if (coverUrl.isEmpty()){
        session.setAttribute("errorCoverUrl", "Cover URL is required!");
    }else{
        session.setAttribute("errorCoverUrl", "");
        flag++;
    }

    if (snackCategory.isEmpty()){
        session.setAttribute("errorProductCategory", "SnackCategory is required!");
    }else{
        session.setAttribute("errorProductCategory", "");
        flag++;
    }

    if (detail.isEmpty()){
        session.setAttribute("errorSnackDetail", "Product detail is required!");
    }else if(detail.length() <= 10){
        session.setAttribute("errorSnackDetail", "Product detail must be more than 10 letters!");
    }else{
        session.setAttribute("errorSnackDetail", "");
        flag++;
    }
    
    if (flag == 6){
        query ="UPDATE snacks SET snack_name = ?,snack_price = ?, snack_stock = ?, snack_category_id = ?,snack_cover_url = ?, snack_detail = ? WHERE snack_id = ?";
        Connect.update(query, name, price, stock, snackCategory, coverUrl, detail, id);

        session.setAttribute("alertMessage", "Product has been updated!");
        response.sendRedirect("manageProduct.jsp");
    }else{
        response.sendRedirect("editProduct.jsp?id=" + id);
    }
%>