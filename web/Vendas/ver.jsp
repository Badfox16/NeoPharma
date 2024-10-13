<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProdutoDAO" %>
<%@ page import="dao.VendaDAO" %>
<%@ page import="dao.ItemVendaDAO" %>
<%@ page import="model.Produto" %>
<%@ page import="model.Venda" %>
<%@ page import="model.ItemVenda" %>
<%@ page import="java.io.IOException" %>

<%

%>

<!DOCTYPE html>
<html>
    <%@ include file="../includes/head.jsp" %>
    <body>
        <section class="d-flex">
            <%@ include file="../includes/sidebar.jsp" %>
            <div class="card-body" style="width: calc(100% - 290px); margin-left: 290px; overflow-y: scroll;">
                 <h2 class="pd-2 m-5" style="color: #344e41;"><b>Gestão de Vendas</b></h2>
                <!-- TABELA DE VENDAS -->
                <div class="">
                    <h3 class="m-5" style="color: #344e41;"><b>Vendas Realizadas</b></h3>
                    <table class="table table-responsive-lg table-hover table-bordered mb-0" style="border: 1px solid #3a5a40;">
                        <thead style="background-color: #3a5a40; color: white;">
                            <tr>
                                <th>ID</th>
                                <th>Data</th>
                                <th>Total</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                VendaDAO vendaDAO = new VendaDAO();
                                ItemVendaDAO itemVendaDAO = new ItemVendaDAO();
                                List<Venda> vendas = vendaDAO.getAll();
                                for (Venda venda : vendas) {
                                    List<ItemVenda> itensVenda = itemVendaDAO.getByVendaId(venda.getId());
                            %>
                            <tr>
                                <td><%= venda.getId()%></td>
                                <td><%= venda.getDataVenda()%></td>
                                <td><%= venda.getTotal()%></td>
                                <td>
                                    <button type="button" style="background-color: #344e41; color: white;" class="btn btn-sucess" data-bs-toggle="modal" data-bs-target="#modal<%= venda.getId() %>">
                                        <i class="bi bi-eye"></i> Ver Itens
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="modal<%= venda.getId() %>" tabindex="-1" aria-labelledby="modalLabel<%= venda.getId() %>" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="modalLabel<%= venda.getId() %>">Itens da Venda <%= venda.getId() %></h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body" id="modalBody<%= venda.getId() %>">
                                                    <ul>
                                                        <% for (ItemVenda item : itensVenda) { %>
                                                            <li><%= item.getNomeProduto() %> - <%= item.getDescricaoProduto() %> - <%= item.getQuantidade() %> x <%= item.getPrecoUnitario() %> = <%= item.getPrecoUnitario().multiply(new java.math.BigDecimal(item.getQuantidade())) %></li>
                                                        <% } %>
                                                    </ul>
                                                    <p><strong>Total: <%= venda.getTotal()%></strong></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                                                    <button type="button" class="btn btn-primary" onclick="printModalContent('<%= venda.getId() %>')">Imprimir</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function printModalContent(vendaId) {
                var printContents = document.getElementById('modalBody' + vendaId).innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
                location.reload(); // Reload the page to restore the original content
            }
        </script>
    </body>
</html>
