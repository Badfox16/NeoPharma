<%@page import="model.Carrinho"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.ProdutoDAO" %>
<%@ page import="dao.VendaDAO" %>
<%@ page import="dao.ItemVendaDAO" %>
<%@ page import="model.Produto" %>
<%@ page import="model.Venda" %>
<%@ page import="model.ItemVenda" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>

<%
    // Inicializar o carrinho na sessão, se não existir
    Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
    if (carrinho == null) {
        carrinho = new Carrinho();
        session.setAttribute("carrinho", carrinho);
    }

    // Adicionar item ao carrinho
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("action") != null && request.getParameter("action").equals("add")) {
        int idProduto = Integer.parseInt(request.getParameter("Produto"));
        int quantidade = Integer.parseInt(request.getParameter("Quantidade"));

        ProdutoDAO produtoDAO = new ProdutoDAO();
        Produto produto = produtoDAO.read(idProduto);

        ItemVenda item = new ItemVenda();
        item.setIdProduto(idProduto);
        item.setQuantidade(quantidade);
        item.setPrecoUnitario(BigDecimal.valueOf(produto.getPreco()));

        carrinho.adicionarItem(item);
    }

    // Finalizar venda
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("action") != null && request.getParameter("action").equals("finalize")) {
        VendaDAO vendaDAO = new VendaDAO();
        ItemVendaDAO itemVendaDAO = new ItemVendaDAO();
        ProdutoDAO produtoDAO = new ProdutoDAO();

        Venda venda = new Venda();
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
        int idUsuario = usuarioLogado.getId();
        venda.setIdUsuario(idUsuario);
        venda.setDataVenda(java.time.LocalDateTime.now());
        venda.setTotal(carrinho.getTotal());
        vendaDAO.create(venda);

        for (ItemVenda item : carrinho.getItens()) {
            item.setIdVenda(venda.getId());
            itemVendaDAO.create(item);

            // Atualizar o estoque do produto
            Produto produto = produtoDAO.read(item.getIdProduto());
            produto.setEstoque(produto.getEstoque() - item.getQuantidade());
            produtoDAO.update(produto);
        }

        // Limpar o carrinho após finalizar a venda
        carrinho = new Carrinho();
        session.setAttribute("carrinho", carrinho);

        response.sendRedirect("ver.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <%@ include file="../includes/head.jsp" %>

    <body>
        <section class="d-flex">
            <%@ include file="../includes/sidebar.jsp" %>
            <div class="card-body" style="width: calc(100% - 290px); margin-left: 290px; overflow-y: scroll;">
                <h2 class="pd-2 m-5" style="color: #344e41;"><b>Gestão de Vendas</b></h2>
                <div class="d-flex justify-content-between m-5">
                    <form method="post" class="d-flex flex-wrap">
                        <input type="hidden" name="action" value="add">
                        <div class="form-group me-3">
                            <label for="Produto">Produto:</label>
                            <select class="form-control" id="Produto" name="Produto" required>
                                <option value="" disabled selected>Selecione um produto</option>
                                <%
                                    ProdutoDAO produtoDAO = new ProdutoDAO();
                                    List<Produto> produtos = produtoDAO.getAllEmStock();
                                    for (Produto produto : produtos) {
                                %>
                                <option value="<%= produto.getId()%>"><%= produto.getNome()%> - <%=produto.getDescricao()%></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group me-3">
                            <label for="Quantidade">Quantidade:</label>
                            <input type="number" class="form-control" id="Quantidade" name="Quantidade" required>
                        </div>
                        <div class="form-group align-self-end">
                            <button type="submit" class="btn btn-primary" style="background-color:#3a5a40; border:none;">
                                <i class="fa fa-plus-square" aria-hidden="true"></i> Adicionar ao Carrinho
                            </button>
                        </div>
                    </form>
                </div>
                <!-- CARRINHO -->
                <div class="m-5">
                    <h3 class="m-5" style="color: #344e41;"><b>Carrinho</b></h3>
                    <table class="table table-responsive-lg table-hover table-bordered mb-0" style="border: 1px solid #3a5a40;">
                        <thead style="background-color: #3a5a40; color: white;">
                            <tr>
                                <th>Produto</th>
                                <th>Quantidade</th>
                                <th>Preço Unitário</th>
                                <th>Total</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (ItemVenda item : carrinho.getItens()) {
                                    Produto produto = produtoDAO.read(item.getIdProduto());
                            %>
                            <tr>
                                <td><%= produto.getNome() %></td>
                                <td><%= item.getQuantidade() %></td>
                                <td><%= item.getPrecoUnitario() %></td>
                                <td><%= item.getPrecoUnitario().multiply(new BigDecimal(item.getQuantidade())) %></td>
                                <td>
                                    <form method="post" action="removerItem.jsp">
                                        <input type="hidden" name="idProduto" value="<%= item.getIdProduto() %>">
                                        <button type="submit" class="btn btn-danger">Remover</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <div class="mt-3">
                        <h4>Total: <%= carrinho.getTotal() %></h4>
                    </div>
                    <div class="d-flex flex-wrap">
                        <form method="post">
                            <input type="hidden" name="action" value="finalize">
                            <button type="submit" class="btn btn-success">Finalizar Venda</button>
                        </form>
                        <!-- Botão para redirecionar para ver.jsp -->
                        <form action="ver.jsp" method="get" style="margin-left: 10px;">
                            <button type="submit" class="btn btn-sucess" style=" background-color:#344e41; color: white;">Ver Vendas</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
