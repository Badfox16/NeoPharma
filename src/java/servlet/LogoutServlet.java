package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalida a sessão do usuário
        HttpSession session = request.getSession(false); // Obtém a sessão, mas não cria uma nova se não existir
        if (session != null) {
            session.invalidate(); // Invalida a sessão atual
        }

        // Redireciona para a página de login
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
