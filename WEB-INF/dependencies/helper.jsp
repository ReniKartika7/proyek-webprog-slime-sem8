<%@ page import="java.util.*, java.text.NumberFormat" %>

<%!
    String formatRupiah(int rupiah){
        return "Rp" + NumberFormat.getInstance(new Locale("id", "ID")).format(rupiah);
    }
%>