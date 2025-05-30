<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .nav-link.btn:hover {
        background-color: #2c3e50;
        color: #fff;
        font-weight: bold;
    }
    .nav-link.btn.active {
        background-color: #1c1c1c;
        color: #fff;
        font-weight: bold;
    }
</style>
<div class="d-flex flex-column p-3 text-white position-fixed border border-left" style="width: 290px; background-color:#1c1c1c; height:100vh;">
    <a href="<%= request.getContextPath() %>" class="d-flex flex-column align-items-center mb-3 text-white text-decoration-none">
        <span class="fs-4" style="font-weight: bolder;">NeoPharma</span>
        <span class="fs-4"><img src="<%= request.getContextPath() %>/assets/logo.png" alt="icone NeoPharm" srcset="" width="100"></span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li>
            <button onclick="location.href='<%= request.getContextPath() %>/Vendas/index.jsp'" class="nav-link my-4 text-white btn d-flex align-items-center" style="background-color: #2c2c2c; border: none;">
                <strong>
                <i class="fa-solid fa-shopping-cart mx-2"></i>
                <span>Faturação</span>
                </strong>
            </button>
        </li>
        <li>
            <button onclick="location.href='<%= request.getContextPath() %>/Vendas/ver.jsp'" class="nav-link mb-4 text-white btn d-flex align-items-center" style="background-color: #2c2c2c; border: none;">
                <strong>
                <i class="fa-solid fa-print mx-2"></i>
                <span>Ver Vendas</span>
                </strong>
            </button>
        </li>
        <% 
            if (usuarioLogado != null && "admin".equals(usuarioLogado.getTipo())) { 
        %>
                <li>
                    <button onclick="location.href='<%= request.getContextPath() %>/Usuario/index.jsp'" class="nav-link text-white mb-4 btn d-flex align-items-center" style="background-color: #2c2c2c; border: none;">
                        <strong>
                            <i class="fa-solid fa-user mx-2"></i>
                            <span>Usuários</span>
                        </strong>
                    </button>
                </li>
        <% 
            } 
        %>
        <li>
            <button onclick="location.href='<%= request.getContextPath() %>/Produto/index.jsp'" class="nav-link text-white mb-4 btn d-flex align-items-center" style="background-color: #2c2c2c; border: none;">
                <strong>
                    <i class="fa-solid fa-pills mx-2"></i>
                    <span>Produtos</span>
                </strong>
            </button>
        </li>
    </ul>
    <hr>
    <div class="d-flex flex-column">
        <button onclick="location.href='<%= request.getContextPath() %>/logout'" class="d-flex align-items-center text-white text-decoration-none m-2 btn" style="background-color: #2c2c2c; border: none;">
            <i class="fa fa-sign-out mx-2"></i>
            <strong>Sair</strong>
        </button>        
    </div>
</div>
