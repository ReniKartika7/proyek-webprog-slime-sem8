<%@ include file="/WEB-INF/services.jsp" %>

<%
    if(session.getAttribute("user_id") == null){
        response.sendRedirect("login.jsp");
    }else{
        Cookie cookie = new Cookie("user_id", null);
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        session.removeAttribute("user_id");
        session.setAttribute("fromLogOut", "yes");

        response.sendRedirect(root + "/login.jsp");
    }
%>