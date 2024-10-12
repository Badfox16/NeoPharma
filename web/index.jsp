<%@ page import="dao.UsuarioDAO" %>
<%@ page import="model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login - AutoStand</title>
        <link rel="shortcut icon" href="<%= request.getContextPath()%>/assets/logo.png"  type="image/x-icon">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa; /* Cor de fundo clara para a página */
            }
            .login-container {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
                padding: 30px;
                margin-top: 100px;
            }
            .login-title {
                color: #1a0985; /* Cor vermelha do título */
                font-weight: bold;
                text-align: center;
            }
            .form-label {
                color: #1a0985; /* Cor vermelha para os labels */
            }
            .btn-primary {
                background-color: #1a0985; /* Botão vermelho */
                border: none;
            }
            .btn-primary:hover {
                background-color: #12065e; /* Botão vermelho escuro no hover */
            }
            .alert-danger {
                background-color: #ffcccc;
                color: #1a0985;
                border-color: #1a0985;
            }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="col-md-6 login-container">
                <h2 class="login-title">Login - AutoStand</h2>

                <%
                    // Verifica se o método é POST
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        // Obter dados do formulário
                        String username = request.getParameter("username");
                        String senha = request.getParameter("senha");

                        // Chama o método de login do DAO
                        UsuarioDAO usuarioDAO = new UsuarioDAO();
                        Usuario usuario = usuarioDAO.login(username, senha);

                        if (usuario != null) {
                            // Login bem-sucedido, criar sessão e redirecionar
                            session.setAttribute("usuario", usuario);
                            response.sendRedirect("Carro/index.jsp"); // Redireciona para a página de carros
                        } else {
                            // Login falhou, exibe mensagem de erro
                            out.println("<div class='alert alert-danger'>Login falhou. Usuário ou senha inválidos.</div>");
                        }
                    }
                %>

                <form method="post" action="index.jsp">
                    <div class="mb-3">
                        <label for="username" class="form-label">Nome de Usuário</label>
                        <input type="text" class="form-control" id="username" name="username" placeholder="Insira seu usuário" required>
                    </div>
                    <div class="mb-3">
                        <label for="senha" class="form-label">Senha</label>
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
