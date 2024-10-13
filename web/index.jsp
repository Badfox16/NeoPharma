<%@ page import="dao.UsuarioDAO" %>
<%@ page import="model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title> NeoPharma </title>
        <link rel="shortcut icon" href="<%= request.getContextPath()%>/assets/logo.png"  type="image/x-icon">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa; /* Cor de fundo clara para a página */
            }
            .login-container {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 40px;
                margin-top: 80px;
                max-width: 400px;
                width: 100%;
            }
            .login-title {
                color: #28a745; /* Cor verde do título */
                font-weight: bold;
                text-align: center;
                margin-bottom: 20px;
            }
            .form-label {
                color: #495057; /* Cor cinza para os labels */
            }
            .btn-primary {
                background-color: #28a745; /* Botão verde */
                border: none;
            }
            .btn-primary:hover {
                background-color: #218838; /* Botão verde escuro no hover */
            }
            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
            }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
            <div class="login-container">
                <h2 class="login-title"> NeoPharma 🩺💊</h2>

                <%
                    // Verifica se o método é POST
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        // Obter dados do formulário
                        String email = request.getParameter("email");
                        String senha = request.getParameter("senha");

                        // Chama o método de login do DAO
                        UsuarioDAO usuarioDAO = new UsuarioDAO();
                        Usuario usuario = usuarioDAO.login(email, senha);

                        if (usuario != null) {
                            // Login bem-sucedido, criar sessão e redirecionar
                            session.setAttribute("usuario", usuario);
                            if ("admin".equalsIgnoreCase(usuario.getTipo())) {
                                // Redireciona para a página de admin
                                response.sendRedirect("Usuario/index.jsp");
                            } else {
                                // Redireciona para a página de usuário
                                response.sendRedirect("Produto/index.jsp");
                            }
                        } else {
                            // Login falhou, exibe mensagem de erro
                            out.println("<div class='alert alert-danger'>Login falhou. Usuário ou senha inválidos.</div>");
                            return;
                        }
                    }
                %>

                <form method="post" action="index.jsp">
                    <div class="mb-3">
                        <label for="email" class="form-label">E-mail:</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Insira seu email" required>
                    </div>
                    <div class="mb-3">
                        <label for="senha" class="form-label">Senha:</label>
                        <input type="password" class="form-control" id="senha" name="senha" placeholder="Insira sua senha" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Entrar</button>
                </form>
            </div>
        </div>

        <!-- Bootstrap Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
