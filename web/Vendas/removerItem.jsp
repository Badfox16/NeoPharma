<%@ page import="model.Carrinho" %>
<%
    int idProduto = Integer.parseInt(request.getParameter("idProduto"));

    Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
    if (carrinho != null) {
        carrinho.removerItem(idProduto);
    }

    response.sendRedirect("index.jsp");
%>