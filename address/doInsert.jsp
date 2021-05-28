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

    String address = request.getParameter("address");
    String name = request.getParameter("name");
    String phoneNumber = request.getParameter("phoneNumber");
    String province = request.getParameter("province");
    String district = request.getParameter("district");
    String subDistrict = request.getParameter("subDistrict");
    String postalCode = request.getParameter("postalCode");

    int flag = 0;

    session.setAttribute("address", address);
    session.setAttribute("name", name);
    session.setAttribute("phoneNumber", phoneNumber);
    session.setAttribute("province", province);
    session.setAttribute("district", district);
    session.setAttribute("subDistrict", subDistrict);
    session.setAttribute("postalCode", postalCode);

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

    if(flag == 7){
        String query ="INSERT INTO `address` (user_id, address_detail, address_full_name, address_phone_number, address_province, address_district, address_subdistrict, address_postal_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        Connect.update(query, user.sId(), address, name, phoneNumber, province, district, subDistrict, postalCode);

        session.setAttribute("address", null);
        session.setAttribute("name", null);
        session.setAttribute("phoneNumber", null);
        session.setAttribute("province", null);
        session.setAttribute("district", null);
        session.setAttribute("subDistrict", null);
        session.setAttribute("postalCode", null);

        session.setAttribute("alertMessage", "New address has been inserted!");
        response.sendRedirect("myAddress.jsp");
    }else{
        response.sendRedirect("insertAddress.jsp");
    }
%>