<%@ include file="/WEB-INF/services.jsp" %>

<%  
    if(!users("admin")){
        session.setAttribute("alertMessage", "You are not registered as an Admin !");
        response.sendRedirect(root);
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

    session.setAttribute("name", name);
    session.setAttribute("price", price);
    session.setAttribute("stock", stock);
    session.setAttribute("coverUrl", coverUrl);
    session.setAttribute("snackCategory", snackCategory);
    session.setAttribute("detail", detail);

    if (flag == 6){
        String query ="INSERT INTO snacks (snack_name, snack_price, snack_stock, snack_cover_url, snack_category_id, snack_detail) VALUES (?, ?, ?, ?, ?, ?)";
        Connect.update(query, name, price, stock, coverUrl, snackCategory, detail);
        
        session.setAttribute("name", null);
        session.setAttribute("price", null);
        session.setAttribute("stock", null);
        session.setAttribute("coverUrl", null);
        session.setAttribute("snackCategory", null);
        session.setAttribute("detail", null);

        session.setAttribute("alertMessage", "Product has been inserted!");
        response.sendRedirect("manageProduct.jsp");
    }else{
        response.sendRedirect("insertProduct.jsp");
    }
%>