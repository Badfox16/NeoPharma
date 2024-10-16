<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProdutoDAO" %>
<%@ page import="model.Produto" %>
<%@ page import="java.io.IOException" %>

<%
    // Obtém o ID do produto da URL
    String idProduto = request.getParameter("idProduto");
    Produto produto = null;

    if (idProduto != null) {
        try {
            int id = Integer.parseInt(idProduto);
            ProdutoDAO produtoDAO = new ProdutoDAO();
            produto = produtoDAO.read(id);  // Carrega os dados do produto
        } catch (NumberFormatException e) {
            out.println("<p>Erro: ID do Produto inválido.</p>");
        }
    }

    // Atualiza os dados do produto
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (produto != null) {
            produto.setNome(request.getParameter("Nome"));
            produto.setDescricao(request.getParameter("Descricao"));
            produto.setPreco(Double.parseDouble(request.getParameter("Preco")));
            produto.setEstoque(Integer.parseInt(request.getParameter("Estoque")));

            ProdutoDAO produtoDAO = new ProdutoDAO();
            produtoDAO.update(produto);

            response.sendRedirect("index.jsp");
            return;
        }
    }
%>

<!DOCTYPE html>
<html>
    <%@ include file="../includes/head.jsp" %>
    <body>
        <section class="d-flex">
            <%@ include file="../includes/sidebar.jsp" %>
            <div class="card-body" style="width: calc(100% - 290px); margin-left: 290px; overflow-y: scroll;">
                <h2 class="pd-2 m-5" style="color: #344e41;"><b>Editar Produto</b></h2>

                <!-- Formulário de edição -->
                <div class="m-5">
                    <form method="post" action="edit.jsp?idProduto=<%= idProduto%>">
                        <div class="form-group">
                            <label for="Nome">Nome:</label>
                            <input type="text" class="form-control" id="Nome" name="Nome" value="<%= produto != null ? produto.getNome() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label for="Descricao">Descrição:</label>
                            <input type="text" class="form-control" id="Descricao" name="Descricao" value="<%= produto != null ? produto.getDescricao() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label for="Preco">Preço:</label>
                            <input type="number" step="0.01" class="form-control" id="Preco" name="Preco" value="<%= produto != null ? produto.getPreco() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label for="Estoque">Estoque:</label>
                            <input type="number" class="form-control" id="Estoque" name="Estoque" value="<%= produto != null ? produto.getEstoque() : ""%>" required>
                        </div>
                        <br>
                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-primary" style="background-color:#344e41; border:none;">
                                <i class="fa fa-save"></i> Editar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
