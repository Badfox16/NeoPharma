<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UsuarioDAO" %>
<%@ page import="model.Usuario" %>
<%@ page import="java.io.IOException" %>

<%
    // Obtém o ID do usuário da URL
    String idUsuario = request.getParameter("idUsuario");
    Usuario usuario = null;

    if (idUsuario != null) {
        try {
            int id = Integer.parseInt(idUsuario);
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuario = usuarioDAO.read(id);  // Carrega os dados do usuário
        } catch (NumberFormatException e) {
            out.println("<p>Erro: ID do Usuário inválido.</p>");
        }
    }

    // Atualiza os dados do usuário
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (usuario != null) {
            usuario.setNome(request.getParameter("Nome"));
            usuario.setEmail(request.getParameter("Email"));
            String novaSenha = request.getParameter("Senha");
            if (novaSenha != null && !novaSenha.isEmpty()) {
                usuario.setSenha(novaSenha);
            }
            usuario.setTipo(request.getParameter("Tipo"));

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.update(usuario);

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
                <h2 class="pd-2 m-5" style="color: #344e41;"><b>Editar Usuário</b></h2>

                <!-- Formulário de edição -->
                <div class="m-5">
                    <form method="post" action="edit.jsp?idUsuario=<%= idUsuario%>">
                        <div class="form-group">
                            <label for="Nome">Nome:</label>
                            <input type="text" class="form-control" id="Nome" name="Nome" value="<%= usuario != null ? usuario.getNome() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label for="Email">Email:</label>
                            <input type="email" class="form-control" id="Email" name="Email" value="<%= usuario != null ? usuario.getEmail() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label for="Senha">Senha:</label>
                            <input type="password" class="form-control" id="Senha" name="Senha" placeholder="Deixe em branco para manter a senha atual">
                        </div>
                        <div class="form-group">
                            <label for="Tipo">Tipo:</label>
                            <input type="text" class="form-control" id="Tipo" name="Tipo" value="<%= usuario != null ? usuario.getTipo() : ""%>" required>
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
