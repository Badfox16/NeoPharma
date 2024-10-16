<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.FarmacoDAO" %>
<%@ page import="model.Farmaco" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <%@ include file="../includes/head.jsp" %>

    <body>
        <section class="d-flex">
            <%@ include file="../includes/sidebar.jsp" %>
            <div class="card-body" style="width: calc(100% - 290px); margin-left: 290px; overflow-y: scroll;">
                <h2 class="pd-2 m-5" style="color: #344e41;"><b>Gestão de Farmacos</b></h2>
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
                            <%                                
                                FarmacoDAO FarmacoDAO = new FarmacoDAO();
                                List<Farmaco> Farmacos = null;

                                String pesquisa = request.getParameter("Farmaco");
                                if (pesquisa != null && !pesquisa.isEmpty()) {
                                    //Farmacos = FarmacoDAO.pesquisarFarmacos(pesquisa);
                                } else {
                                    Farmacos = FarmacoDAO.getAll();
                                }

                                if ("GET".equalsIgnoreCase(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
                                    String idFarmaco = request.getParameter("idFarmaco");
                                    if (idFarmaco != null && !idFarmaco.isEmpty()) {
                                        try {
                                            int id = Integer.parseInt(idFarmaco);
                                            FarmacoDAO.delete(id);
                                            Farmacos = FarmacoDAO.getAll();
                                        } catch (NumberFormatException e) {
                                            out.println("<p style='color: #3a5a40;'>Erro: ID do Farmaco inválido.</p>");
                                        }
                                    } else {
                                        out.println("<p style='color: #3a5a40;'>Erro: ID do Farmaco não fornecido.</p>");
                                    }
                                }

                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    Farmaco Farmaco = new Farmaco();
                                    Farmaco.setNome(request.getParameter("Nome"));
                                    Farmaco.setDescricao(request.getParameter("Descricao"));
                                    Farmaco.setPreco(Double.parseDouble(request.getParameter("Preco")));
                                    Farmaco.setEstoque(Integer.parseInt(request.getParameter("Estoque")));

                                    FarmacoDAO.create(Farmaco);
                                    response.sendRedirect("index.jsp");
                                    return;
                                }

                                for (Farmaco Farmaco : Farmacos) {
                            %>
                            <tr>
                                <td><%= Farmaco.getId()%></td>
                                <td><%= Farmaco.getNome()%></td>
                                <td><%= Farmaco.getDescricao()%></td>
                                <td><%= Farmaco.getPreco()%></td>
                                <td><%= Farmaco.getEstoque()%></td>
                                <td>
                                    <a href="edit.jsp?idFarmaco=<%= Farmaco.getId()%>">
                                        <span style="font-size: 1.5rem; color:#3a5a40;" aria-hidden="true">
                                            <i class="fa fa-edit"></i>
                                        </span>
                                    </a>  

                                    <!-- Modal Trigger -->
                                    <a href="#" data-bs-toggle="modal" data-bs-target="#viewModal_<%= Farmaco.getId()%>">
                                        <span style="font-size: 1.5rem; color:#3a5a40; padding-left: 16px;" aria-hidden="true">
                                            <i class="fa fa-eye"></i>
                                        </span>
                                    </a>

                                    <!-- Modal -->
                                    <div class="modal fade" id="viewModal_<%= Farmaco.getId()%>" tabindex="-1" aria-labelledby="viewModalLabel_<%= Farmaco.getId()%>" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="viewModalLabel_<%= Farmaco.getId()%>">Detalhes do Farmaco</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p><b>ID:</b> <%= Farmaco.getId()%></p>
                                                    <p><b>Marca:</b> <%= Farmaco.getNome()%></p>
                                                    <p><b>Descrição:</b> <%= Farmaco.getDescricao()%></p>
                                                    <p><b>Preço:</b> <%= Farmaco.getPreco()%></p>
                                                    <p><b>Estoque:</b> <%= Farmaco.getEstoque()%></p>
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
