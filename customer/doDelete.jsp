<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(users("guest")){
        session.setAttribute("fromCartGuest", "yes");
        response.sendRedirect(loginPath);
        return;
    }

    String id = request.getParameter("id");
    
    if(id == null){
        if(users("admin")){
            session.setAttribute("fromCartAdmin", "yes");
            response.sendRedirect(root);
            return;
        }else{
            String delete = "DELETE FROM users WHERE user_id = ?";
            Connect.update(delete, user.sId());

            request.getServletContext().getRequestDispatcher("/doLogout.jsp").forward(request, response);
        }
    }else{
        if(!users("admin")){
            session.setAttribute("fromNotAdmin", "yes");
            response.sendRedirect(root);
            return;
        }else{
            String delete = "DELETE FROM users WHERE user_id = ?";
            Connect.update(delete, id);

            if(id.equals(user.sId())){
                request.getServletContext().getRequestDispatcher("/doLogout.jsp").forward(request, response);
            }else{
                session.setAttribute("deleteDone", "yes");
                response.sendRedirect("manageCustomer.jsp");
            }
        }
    }

%>