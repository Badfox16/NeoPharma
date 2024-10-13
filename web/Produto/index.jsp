<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.ProdutoDAO" %>
<%@ page import="model.Produto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <%@ include file="../includes/head.jsp" %>

    <body>
        <section class="d-flex">
            <%@ include file="../includes/sidebar.jsp" %>
            <div class="card-body" style="width: calc(100% - 290px); margin-left: 290px; overflow-y: scroll;">
                <h2 class="pd-2 m-5" style="color: #344e41;"><b>Gestão de Produtos</b></h2>
                <div class="d-flex justify-content-between m-5">
                    <form method="post" class="d-flex flex-wrap">
                        <div class="form-group me-3">
                            <label for="Marca">Marca:</label>
                            <input type="text" class="form-control" id="Marca" name="Nome" required>
                        </div>
                        <div class="form-group me-3">
                            <label for="Descricao">Descrição:</label>
                            <input type="text" class="form-control" id="Descricao" name="Descricao" required>
                        </div>
                        <div class="form-group me-3">
                            <label for="Preco">Preço:</label>
                            <input type="number" step="0.01" class="form-control" id="Preco" name="Preco" required>
                        </div>
                        <div class="form-group me-3">
                            <label for="Estoque">Estoque:</label>
                            <input type="number" class="form-control" id="Estoque" name="Estoque" required>
                        </div>
                        <div class="form-group align-self-end">
                            <button type="submit" class="btn btn-primary" style="background-color:#3a5a40; border:none;">
                                <i class="fa fa-plus-square" aria-hidden="true"></i> Cadastrar
                            </button>
                        </div>
                    </form>
                </div>

                <!-- TABELA -->
                <div class="">
                    <table class="table table-responsive-lg table-hover table-bordered mb-0" style="border: 1px solid #3a5a40;">
                        <thead style="background-color: #3a5a40; color: white;">
                            <tr>
                            <th>ID</th>
                            <th>Marca</th>
                            <th>Descrição</th>
                            <th>Preço</th>
                            <th>Estoque</th>
                            <th>Ações</th>
                        </tr>
                        </thead>
                        <tbody>
                            <%                                ProdutoDAO produtoDAO = new ProdutoDAO();
                                List<Produto> produtos = null;

                                String pesquisa = request.getParameter("Produto");
                                if (pesquisa != null && !pesquisa.isEmpty()) {
                                    //produtos = produtoDAO.pesquisarProdutos(pesquisa);
                                } else {
                                    produtos = produtoDAO.getAll();
                                }

                                if ("GET".equalsIgnoreCase(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
                                    String idProduto = request.getParameter("idProduto");
                                    if (idProduto != null && !idProduto.isEmpty()) {
                                        try {
                                            int id = Integer.parseInt(idProduto);
                                            produtoDAO.delete(id);
                                            produtos = produtoDAO.getAll();
                                        } catch (NumberFormatException e) {
                                            out.println("<p style='color: #3a5a40;'>Erro: ID do Produto inválido.</p>");
                                        }
                                    } else {
                                        out.println("<p style='color: #3a5a40;'>Erro: ID do Produto não fornecido.</p>");
                                    }
                                }

                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    Produto produto = new Produto();
                                    produto.setNome(request.getParameter("Nome"));
                                    produto.setDescricao(request.getParameter("Descricao"));
                                    produto.setPreco(Double.parseDouble(request.getParameter("Preco")));
                                    produto.setEstoque(Integer.parseInt(request.getParameter("Estoque")));

                                    produtoDAO.create(produto);
                                    response.sendRedirect("index.jsp");
                                    return;
                                }

                                for (Produto produto : produtos) {
                            %>
                            <tr>
                                <td><%= produto.getId()%></td>
                                <td><%= produto.getNome()%></td>
                                <td><%= produto.getDescricao()%></td>
                                <td><%= produto.getPreco()%></td>
                                <td><%= produto.getEstoque()%></td>
                                <td>
                                    <a href="edit.jsp?idProduto=<%= produto.getId()%>">
                                        <span style="font-size: 1.5rem; color:#3a5a40;" aria-hidden="true">
                                            <i class="fa fa-edit"></i>
                                        </span>
                                    </a>  

                                    <!-- Modal Trigger -->
                                    <a href="#" data-bs-toggle="modal" data-bs-target="#viewModal_<%= produto.getId()%>">
                                        <span style="font-size: 1.5rem; color:#3a5a40; padding-left: 16px;" aria-hidden="true">
                                            <i class="fa fa-eye"></i>
                                        </span>
                                    </a>

                                    <!-- Modal -->
                                    <div class="modal fade" id="viewModal_<%= produto.getId()%>" tabindex="-1" aria-labelledby="viewModalLabel_<%= produto.getId()%>" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="viewModalLabel_<%= produto.getId()%>">Detalhes do Produto</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p><b>ID:</b> <%= produto.getId()%></p>
                                                    <p><b>Marca:</b> <%= produto.getNome()%></p>
                                                    <p><b>Descrição:</b> <%= produto.getDescricao()%></p>
                                                    <p><b>Preço:</b> <%= produto.getPreco()%></p>
                                                    <p><b>Estoque:</b> <%= produto.getEstoque()%></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
