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
            usuario.setUsername(request.getParameter("Username"));
            usuario.setApelido(request.getParameter("Apelido"));
            usuario.setTelefone(request.getParameter("Telefone"));

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
            <div class="card-body" style="width: calc(100% - 300px); margin-left: 300px; overflow-y: scroll;">
                <h2 class="pd-2 m-5" style="color: #1a0985;"><b>Editar Usuário</b></h2>

                <!-- Formulário de edição -->
                <div class="m-5">
                    <form method="post" action="edit.jsp?idUsuario=<%= idUsuario%>">
                        <div class="form-group">
                            <label for="Nome">Nome:</label>
                            <input type="text" class="form-control" id="Nome" name="Nome" value="<%= usuario != null ? usuario.getNome() : ""%>" required>
                        </div>
                        <div class="form-group">
                        <label for="Apelido">Apelido:</label>
                        <input type="text" class="form-control" id="Apelido" name="Apelido" value="<%= usuario != null ? usuario.getApelido() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label for="Username">Username:</label>
                            <input type="text" class="form-control" id="Username" name="Username" value="<%= usuario != null ? usuario.getUsername() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label for="Telefone">Telefone:</label>
                            <input type="number" class="form-control" id="Telefone" name="Telefone" value="<%= usuario != null ? usuario.getTelefone() : ""%>" required>
                        </div>
                        <br>
                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-primary" style="background-color:#1a0985; border:none;">
                                <i class="fa fa-save"></i> Salvar
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
