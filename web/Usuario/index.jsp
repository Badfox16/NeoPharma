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
            <div class="card-body"
                 style="width: calc(100% - 300px); margin-left: 300px; overflow-y: scroll;">
                <h2 class="pd-2 m-5" style="color: #1a0985;"><b>Gestão de Usuarios</b></h2>
                <div class="d-flex">
                    <div class="m-5">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                data-bs-target="#myModal"
                                style="background-color:#1a0985; border:none;">
                            <i class="fa fa-plus-square" aria-hidden="true"></i> Cadastrar
                        </button>
                    </div>
                </div>

                <!-- TABELA -->
                <div class="">
                    <table class="table table-responsive-lg table-hover table-borderless mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Apelido</th>
                                <th>Username</th>
                                <th>Telefone</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% // Instancia o DAO 
                                UsuarioDAO UsuarioDAO = new UsuarioDAO();
                                List<Usuario> Usuarios = null;

                                // Verifica se há uma pesquisa
                                String pesquisa = request.getParameter("Usuario");
                                if (pesquisa != null && !pesquisa.isEmpty()) {
                                    //Usuarios = UsuarioDAO.pesquisarUsuarios(pesquisa);
                                } else {
                                    Usuarios = UsuarioDAO.getAll();
                                }

                                if ("GET".equalsIgnoreCase(request.getMethod())
                                        && "delete".equals(request.getParameter("action"))) {
                                    String idUsuario = request.getParameter("idUser");
                                    if (idUsuario != null && !idUsuario.isEmpty()) {
                                        try {
                                            int id = Integer.parseInt(idUsuario);
                                            UsuarioDAO.delete(id);
                                            // Após a exclusão, atualize a lista de Usuarios
                                            Usuarios = UsuarioDAO.getAll();
                                        } catch (NumberFormatException e) {
                                            out.println("<p style='color: blue;'>Erro: ID do Usuario inválido.</p>");
                                        }
                                    } else {
                                        out.println("<p style='color: blue;'>Erro: ID do Usuario não fornecido.</p>");
                                    }
                                }

                                // Cadastro de novo Usuario via POST
                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    Usuario Usuario = new Usuario();
                                    Usuario.setNome(request.getParameter("Nome"));
                                    Usuario.setApelido(request.getParameter("Apelido"));
                                    Usuario.setUsername(request.getParameter("Username"));
                                    Usuario.setSenha(request.getParameter("Senha"));
                                    Usuario.setTelefone(request.getParameter("Telefone"));

                                    UsuarioDAO.create(Usuario);

                                    // Atualizar a lista de Usuarios após cadastro
                                    Usuarios = UsuarioDAO.getAll();
                                }

                                // Listagem de Usuarios
                                for (Usuario Usuario : Usuarios) {
                            %>
                            <tr>

                                <td>
                                    <%= Usuario.getIdUser()%>
                                </td>
                                <td>
                                    <%= Usuario.getNome()%>
                                </td>
                                <td>
                                    <%= Usuario.getApelido()%>
                                </td>
                                <td>
                                    <%= Usuario.getUsername()%>
                                </td>
                                <td>
                                    <%= Usuario.getTelefone()%>
                                </td>
                                <td>
                                    <a href="edit.jsp?idUsuario=<%= Usuario.getIdUser()%>">
                                        <span style="font-size: 1.5rem; color:#1a0985;" aria-hidden="true">
                                            <i class="fa fa-user-pen"></i>
                                        </span>
                                    </a>  

                                    <!-- Formulário GET para exclusão -->
                                    <form id="deleteForm_<%= Usuario.getIdUser()%>"
                                          method="GET" action="index.jsp"
                                          style="display: none;">
                                        <input type="hidden" name="idUser"
                                               value="<%= Usuario.getIdUser()%>" />
                                        <input type="hidden" name="action" value="delete" />
                                    </form>

                                    <!-- Link de exclusão -->
                                    <a href="#"
                                       onclick="document.getElementById('deleteForm_<%= Usuario.getIdUser()%>').submit(); return false;"
                                       class="deleteButton">
                                        <span
                                            style="font-size: 1.5rem; color:#1a0985; padding-left: 16px;"
                                            aria-hidden="true">
                                            <i class="fa fa-trash"></i>
                                        </span>
                                    </a>
                                </td>

                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <!-- Modal de Cadastro de Usuario -->
                <div class="modal fade" id="myModal" tabindex="-1"
                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Cadastro de Usuario</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form method="post">
                                    <div class="form-group">
                                        <label for="Nome">Nome:</label>
                                        <input type="text" class="form-control" id="Nome" name="Nome" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="Apelido">Apelido:</label>
                                        <input type="text" class="form-control" id="Apelido" name="Apelido" required>
                                    </div>
                                    <div class="form-group"></div>
                                    <label for="Telefone">Telefone:</label>
                                    <input type="number" class="form-control" id="Telefone" name="Telefone" required>
                                    <div class="form-group">
                                        <label for="Username">Username:</label>
                                        <input type="text" class="form-control" id="Username" name="Username" required>
                                    </div>
                                    <div class="form-group"></div>
                                    <label for="Senha">Senha:</label>
                                    <input type="password" class="form-control" id="Senha" name="Senha" required>
                                    <br>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary"
                                                style="background-color:#1a0985; border:none;">
                                            <i class="fa fa-plus-square" aria-hidden="true"></i>
                                            Cadastrar
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- Fim do Modal -->
    </div>
</section>

<!-- Scripts -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>