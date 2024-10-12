<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .nav-link.btn:hover {
        background-color: #2c3e50;
        color: #fff;
        font-weight: bold;
    }
</style>
<div class="d-flex flex-column p-3 text-white position-fixed border border-left" style="width: 290px; background-color:#344e41; height:100vh;">
    <a href="<%= request.getContextPath() %>" class="d-flex flex-column align-items-center mb-3 text-white text-decoration-none">
        <span class="fs-4" style="font-weight: bolder;">NeoPharm</span>
        <span class="fs-4"><img src="<%= request.getContextPath() %>/assets/logo.png" alt="icone NeoPharm" srcset="" width="100"></span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li>
            <a href="<%= request.getContextPath() %>/Vendas/index.jsp" class="nav-link my-4 text-white btn d-flex align-items-center" style="background-color: #3a5a40; border: none;">
                <strong>
                <i class="fa-solid fa-shopping-cart mx-2"></i>
                <span>Vendas</span>
                </strong>
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/Usuario/index.jsp" class="nav-link text-white mb-4 btn d-flex align-items-center" style="background-color: #3a5a40; border: none;">
                <strong>
                    <i class="fa-solid fa-user mx-2"></i>
                    <span>Usuários</span>
                </strong>
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/Produtos/index.jsp" class="nav-link text-white mb-4 btn d-flex align-items-center" style="background-color: #3a5a40; border: none;">
                <strong>
                    <i class="fa-solid fa-pills mx-2"></i>
                    <span>Produtos</span>
                </strong>
            </a>
        </li>
    </ul>
    <hr>
    <div class="d-flex flex-column">
        <a href="<%= request.getContextPath() %>/logout" class="d-flex align-items-center text-white text-decoration-none m-2 btn" style="background-color: #3a5a40; border: none;">
            <i class="fa fa-sign-out mx-2"></i>
            <strong>Sair</strong>
        </a>        
    </div>
</div>
