<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.UsuarioDAO" %>
<%@ page import="model.Usuario" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <%@ include file="../includes/head.jsp" %>

    <body>
        <section class="d-flex">
            <%@ include file="../includes/sidebar.jsp" %>
            <div class="card-body" style="width: calc(100% - 290px); margin-left: 290px; overflow-y: scroll;">
                <h2 class="pd-2 m-5" style="color: #344e41;"><b>Gestão de Usuarios</b></h2>
                <div class="d-flex justify-content-between m-5">
                    <form method="post" class="d-flex flex-wrap">
                        <div class="form-group me-3">
                            <label for="Nome">Nome:</label>
                            <input type="text" class="form-control" id="Nome" name="Nome" required>
                        </div>
                        <div class="form-group me-3">
                            <label for="Email">Email:</label>
                            <input type="email" class="form-control" id="Email" name="Email" required>
                        </div>
                        <div class="form-group me-3">
                            <label for="Senha">Senha:</label>
                            <input type="password" class="form-control" id="Senha" name="Senha" required>
                        </div>
                        <div class="form-group me-3">
                            <label for="Tipo">Tipo:</label>
                            <select class="form-control" id="Tipo" name="Tipo" required>
                                <option value="usuario">Usuário</option>
                                <option value="admin">Admin</option>
                            </select>
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
                        <thead style="background-color: #3a5a40; color: white;"></thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Email</th>
                                <th>Tipo</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                UsuarioDAO usuarioDAO = new UsuarioDAO();
                                List<Usuario> usuarios = null;

                                String pesquisa = request.getParameter("Usuario");
                                if (pesquisa != null && !pesquisa.isEmpty()) {
                                    //usuarios = usuarioDAO.pesquisarUsuarios(pesquisa);
                                } else {
                                    usuarios = usuarioDAO.getAll();
                                }

                                if ("GET".equalsIgnoreCase(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
                                    String idUsuario = request.getParameter("idUser");
                                    if (idUsuario != null && !idUsuario.isEmpty()) {
                                        try {
                                            int id = Integer.parseInt(idUsuario);
                                            usuarioDAO.delete(id);
                                            usuarios = usuarioDAO.getAll();
                                        } catch (NumberFormatException e) {
                                            out.println("<p style='color: #3a5a40;'>Erro: ID do Usuario inválido.</p>");
                                        }
                                    } else {
                                        out.println("<p style='color: #3a5a40;'>Erro: ID do Usuario não fornecido.</p>");
                                    }
                                }

                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    Usuario usuario = new Usuario();
                                    usuario.setNome(request.getParameter("Nome"));
                                    usuario.setEmail(request.getParameter("Email"));
                                    usuario.setSenha(request.getParameter("Senha"));
                                    usuario.setTipo(request.getParameter("Tipo"));

                                    usuarioDAO.create(usuario);
                                    usuarios = usuarioDAO.getAll();
                                }

                                for (Usuario usuario : usuarios) {
                            %>
                            <tr style="border-bottom: 1px solid #3a5a40;"></tr>
                                <td><%= usuario.getId() %></td>
                                <td><%= usuario.getNome() %></td>
                                <td><%= usuario.getEmail() %></td>
                                <td><%= usuario.getTipo() %></td>
                                <td>
                                    <a href="edit.jsp?idUsuario=<%= usuario.getId() %>">
                                        <span style="font-size: 1.5rem; color:#3a5a40;" aria-hidden="true">
                                            <i class="fa fa-user-pen"></i>
                                        </span>
                                    </a>  

                                    <form id="deleteForm_<%= usuario.getId() %>" method="GET" action="index.jsp" style="display: none;">
                                        <input type="hidden" name="idUser" value="<%= usuario.getId() %>" />
                                        <input type="hidden" name="action" value="delete" />
                                    </form>

                                    <a href="#" onclick="document.getElementById('deleteForm_<%= usuario.getId() %>').submit(); return false;" class="deleteButton">
                                        <span style="font-size: 1.5rem; color:#3a5a40; padding-left: 16px;" aria-hidden="true">
                                            <i class="fa fa-trash"></i>
                                        </span>
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                            </div>
        </section>
    </body>
</html>
