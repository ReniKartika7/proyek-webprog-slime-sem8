<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(users("guest")){
        session.setAttribute("alertMessage", "Please Login first!");
        response.sendRedirect(loginPath);
        return;
    }

    String id = request.getParameter("id");
    
    if(id == null){
        if(users("admin")){
            session.setAttribute("alertMessage", "You are not login as a customer");
            response.sendRedirect(root);
            return;
        }else{
            String delete = "DELETE FROM users WHERE user_id = ?";
            Connect.update(delete, user.sId());

            request.getServletContext().getRequestDispatcher("/doLogout.jsp").forward(request, response);
        }
    }else{
        if(!users("admin")){
            session.setAttribute("alertMessage", "You are not registered as an Admin !");
            response.sendRedirect(root);
            return;
        }else{
            String delete = "DELETE FROM users WHERE user_id = ?";
            Connect.update(delete, id);

            if(id.equals(user.sId())){
                request.getServletContext().getRequestDispatcher("/doLogout.jsp").forward(request, response);
            }else{
                session.setAttribute("alertMessage", "Account has been deleted!");
                response.sendRedirect("manageCustomer.jsp");
            }
        }
    }

%>