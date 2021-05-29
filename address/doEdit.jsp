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

    String loc = (String) session.getAttribute("loc");
    if(loc == null || loc.isEmpty()){
        loc = "myAddress";
    }

    String id = request.getParameter("id");
    if(id == null || id.isEmpty()){
        session.setAttribute("alertMessage", "Invalid Address!");
        response.sendRedirect(loc + ".jsp");
        return;
    }

    String query = "SELECT * FROM address JOIN users ON address.user_id = users.user_id WHERE users.user_id = ? AND address_id = ?";

    ResultSet rs = Connect.query(query, user.sId(), id);
    if(!rs.first()){
        session.setAttribute("alertMessage", "Invalid Address!");
        response.sendRedirect(loc + ".jsp");
        return;
    }

    String address = request.getParameter("address");
    String name = request.getParameter("name");
    String phoneNumber = request.getParameter("phoneNumber");
    String province = request.getParameter("province");
    String district = request.getParameter("district");
    String subDistrict = request.getParameter("subDistrict");
    String postalCode = request.getParameter("postalCode");

    int flag = 0;

    if (address.isEmpty()){
        session.setAttribute("errorAddress", "Address is required!");
    }else if(address.length() <= 10){
        session.setAttribute("errorAddress", "Address must be more than 10 letters!");
    }else{
        session.setAttribute("errorAddress", "");
        flag++;
    }

    if (name.isEmpty()){
        session.setAttribute("errorName", "Name is required!");
    }else if(name.length() <= 4){
        session.setAttribute("errorName", "Name must be more than 4 letters!");
    }else{
        session.setAttribute("errorName", "");
        flag++;
    }

    if (phoneNumber.isEmpty()){
        session.setAttribute("errorPhoneNumber", "Phone Number is required!");
    }else if (!phoneNumber.matches("[0-9]+")){
        session.setAttribute("errorPhoneNumber", "Phone Number must be numeric!");
    }else if(phoneNumber.length() > 13){
        session.setAttribute("errorPhoneNumber", "Phone Number must be less than 14 letters!");
    }else{
        session.setAttribute("errorPhoneNumber", "");
        flag++;
    }

    if (province.isEmpty()){
        session.setAttribute("errorProvince", "Province is required!");
    }else if(province.length() <= 3){
        session.setAttribute("errorProvince", "Province must be more than 3 letters!");
    }else{
        session.setAttribute("errorProvince", "");
        flag++;
    }

    if (district.isEmpty()){
        session.setAttribute("errorDistrict", "District is required!");
    }else if(district.length() <= 3){
        session.setAttribute("errorDistrict", "District must be more than 3 letters!");
    }else{
        session.setAttribute("errorDistrict", "");
        flag++;
    }

    if (subDistrict.isEmpty()){
        session.setAttribute("errorSubDistrict", "Sub district is required!");
    }else if(subDistrict.length() <= 3){
        session.setAttribute("errorSubDistrict", "Sub district must be more than 3 letters!");
    }else{
        session.setAttribute("errorSubDistrict", "");
        flag++;
    }

    if (postalCode.isEmpty()){
        session.setAttribute("errorPostalCode", "Postal Code is required!");
    }else if (!postalCode.matches("[0-9]+")){
        session.setAttribute("errorPostalCode", "Postal Code must be numeric!");
    }else if(postalCode.length() > 13){
        session.setAttribute("errorPostalCode", "Postal Code must be less than 14 letters!");
    }else{
        session.setAttribute("errorPostalCode", "");
        flag++;
    }

    
    if (flag == 7){
        query ="UPDATE `address` SET user_id = ?, address_detail = ?, address_full_name = ?, address_phone_number = ?, address_province = ?, address_district = ?, address_subdistrict = ?, address_postal_code = ?  WHERE address_id = ?";

        Connect.update(query,user.sId(), address, name, phoneNumber, province, district, subDistrict, postalCode, id);

        session.setAttribute("alertMessage", "Address has been updated!");
        response.sendRedirect(loc + ".jsp");
    }else{
        response.sendRedirect("editAddress.jsp?id=" + id);
    }
%>