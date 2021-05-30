<%@ page import="java.time.*, java.time.format.*, java.util.*, java.util.stream.*" %>

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

    String insertHeader, insertDetail, getLastTID, getCart, getSnack;
    ResultSet rs, rss, rsSnack, rsCart;
    String loc = (String) session.getAttribute("loc1");
    String addressId = (String) session.getAttribute("addressId");
    String id = request.getParameter("id");
    Integer lastTransId = 1;
    Integer newQty, cartQty;
    Integer qty = (Integer) session.getAttribute("qty");

    if(addressId == null){
        session.setAttribute("alertMessage", "You have to choose shipping address!");
        response.sendRedirect("checkOut.jsp?id=" + id);
        return;
    }

    if(loc == null){
        session.setAttribute("alertMessage", "Invalid!");
        response.sendRedirect(root);
        return;
    }else {
        insertHeader = "INSERT INTO transaction_header (user_id, address_id, transaction_date) VALUES (?, ?, ?)";
        if(loc.equals("myCart")){
            Connect.update(insertHeader, user.sId(), addressId, LocalDateTime.now()+"");

            getLastTID = "SELECT transaction_id FROM transaction_header ORDER BY transaction_id DESC LIMIT 1";

            rs = Connect.query(getLastTID);
            if(rs.first()){
                lastTransId = rs.getInt("transaction_id");
            }

            insertDetail = "INSERT INTO transaction_detail (transaction_id, snack_id, quantity) VALUES (?, ?, ?)";

            getCart = "SELECT * FROM cart WHERE user_id = ?";

            rss = Connect.query(getCart, user.sId());
            while(rss.next()){
                Connect.update(insertDetail, lastTransId +"", rss.getString("snack_id"), rss.getString("quantity"));

                getSnack = "SELECT * FROM snacks WHERE snack_id = ?";

                rsSnack = Connect.query(getSnack, rss.getString("snack_id"));

                if(rsSnack.first()){
                    newQty = rsSnack.getInt("snack_stock") - rss.getInt("quantity");

                    Connect.update("UPDATE snacks SET snack_stock = ?  WHERE snack_id = ?", newQty + "", rsSnack.getString("snack_id"));

                    rsCart = Connect.query("SELECT * FROM cart WHERE snack_id = ?", rsSnack.getString("snack_id"));

                    while(rsCart.next()){

                        if(rsCart.getInt("quantity") > newQty){
                            cartQty = newQty;

                            Connect.update("UPDATE cart SET quantity = ?  WHERE cart_id = ?", cartQty + "", rsCart.getString("cart_id"));
                        }
                    }
                }
            }

            String delete = "DELETE FROM cart WHERE user_id = ?";

            Connect.update(delete, user.sId());
            session.setAttribute("addressId", null);

            session.setAttribute("alertMessage", "Thankyou for your purchase");
            response.sendRedirect(root);
        }else if(loc.equals("buyProduct")){
            if(id == null || id.isEmpty()){
                session.setAttribute("alertMessage", "Invalid Product!");
                response.sendRedirect(root);
                return;
            }
            
            getSnack = "SELECT * FROM snacks WHERE snack_id = ?";
            rsSnack = Connect.query(getSnack, id);
            
            if(rsSnack.first()){
                if(qty <= 0){
                    session.setAttribute("alertMessage", "You have to choose at least one pieces!");
                    response.sendRedirect(root + "/products/product.jsp?id=" + id);
                    return;
                }else if(qty > rsSnack.getInt("snack_stock")){
                    session.setAttribute("alertMessage", "You can't choose more than " + rsSnack.getString("snack_stock") + " pieces!");
                    response.sendRedirect(root + "/products/product.jsp?id=" + id);
                    return;
                }

                Connect.update(insertHeader, user.sId(), addressId, LocalDateTime.now()+"");

                getLastTID = "SELECT transaction_id FROM transaction_header ORDER BY transaction_id DESC LIMIT 1";

                rs = Connect.query(getLastTID);
                if(rs.first()){
                    lastTransId = rs.getInt("transaction_id");
                }

                insertDetail = "INSERT INTO transaction_detail (transaction_id, snack_id, quantity) VALUES (?, ?, ?)";

                Connect.update(insertDetail, lastTransId +"", id, qty + "");

                newQty = rsSnack.getInt("snack_stock") - qty;
                Connect.update("UPDATE snacks SET snack_stock = ?  WHERE snack_id = ?", newQty + "", id);
                
                rsCart = Connect.query("SELECT * FROM cart WHERE snack_id = ?", id);
                while(rsCart.next()){
                    if(rsCart.getInt("quantity") > newQty){
                        cartQty = newQty;

                        Connect.update("UPDATE cart SET quantity = ?  WHERE cart_id = ?", cartQty + "", rsCart.getString("cart_id"));
                    }
                }
                
            }
            session.setAttribute("addressId", null);
            session.setAttribute("alertMessage", "Thankyou for your purchase");
            response.sendRedirect(root);
        }
        
    }

%>