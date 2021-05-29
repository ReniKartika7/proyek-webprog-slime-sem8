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

    if(addressId == null){
        session.setAttribute("alertMessage", "You have to choose shipping address!");
        response.sendRedirect("checkOut.jsp");
        return;
    }

    if(loc == null){
        session.setAttribute("alertMessage", "Invalid!");
        response.sendRedirect(root);
        return;
    }else {
        if(loc.equals("myCart")){
            insertHeader = "INSERT INTO transaction_header (user_id, address_id, transaction_date) VALUES (?, ?, ?)";

            Connect.update(insertHeader, user.sId(), addressId, LocalDateTime.now()+"");

            getLastTID = "SELECT transaction_id FROM transaction_header ORDER BY transaction_id DESC LIMIT 1";

            rs = Connect.query(getLastTID);
            Integer lastTransId = 1;
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
                    Integer newQty = rsSnack.getInt("snack_stock") - rss.getInt("quantity");

                    Connect.update("UPDATE snacks SET snack_stock = ?  WHERE snack_id = ?", newQty + "", rsSnack.getString("snack_id"));

                    rsCart = Connect.query("SELECT * FROM cart WHERE snack_id = ?", rsSnack.getString("snack_id"));

                    while(rsCart.next()){
                        Connect.update("UPDATE cart SET quantity = ?  WHERE cart_id = ?", newQty + "", rsCart.getString("cart_id"));
                    }
                }
            }

            String delete = "DELETE FROM cart WHERE user_id = ?";

            Connect.update(delete, user.sId());

            session.setAttribute("alertMessage", "Thankyou for your purchase");
            response.sendRedirect(root);
        }
        
    }

    out.println(loc);

%>