<%@page import="com.fatec.farmacia.model.Carrinho"%>
<%@page import="com.fatec.farmacia.model.Cliente"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.fatec.farmacia.model.Produto"%>
<%@page import="com.fatec.farmacia.persistence.DaoProduto"%>
<%@page import="com.fatec.farmacia.persistence.IntDaoProduto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%  int intProd =Integer.parseInt(request.getParameter("id"));
    	long idProd = intProd;
    	IntDaoProduto dao = new DaoProduto();
    	Produto prod = new Produto();
    	prod = dao.getProduto(idProd);
    	DecimalFormat format = new DecimalFormat("0.00");
    	Cliente cli = new Cliente();
    	cli = (Cliente)session.getAttribute("CLIENTE");
    	Carrinho cartCli = new Carrinho();
    	if(cli != null)
    	{
    		cartCli = (Carrinho) session.getAttribute("CARRINHO");
    	}
    %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhe Produto - Coronga Farma</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
        integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link rel="stylesheet" href="Resources/CSS/Detalhes.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="nav_principal">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <!--Desktop-->
        <div class="collapse navbar-collapse justify-content-around" id="navbarSupportedContent">
            <a class="navbar-brand" href="./principal.jsp" id="navImg">
                <img src="img/Logo.png" alt="Logo Coronga Farma">
            </a>
            <form class="form-inline my-2 my-lg-0" id="search" action="./principal.jsp" method="get">
                <input class="form-control mr-sm-2" type="search" placeholder="O que está procurando..."
                    aria-label="Search">
                <button class="btn btn-primary my-2 my-sm-0" type="submit">
                    <img src="img/search.svg" alt="Pesquisar">
                </button>
            </form>
            <ul class="nav navbar-nav navbar-right" id="navbar_itens">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img data-feather="user" alt="Login" stroke="white">
                        <span style="color: white;"><%=session.getAttribute("CLIENTE").toString()%></span>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="./logout?logout=true">Logout</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="./carrinho.jsp" id="nav_carrinho">
                        <img data-feather="shopping-cart" alt="Carrinho" fill="white" stroke="white">
                        <div id="qtd_animated">
                        	<%=cartCli.getCart().size()%>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
    <main>
        <div class="container-fluid">
            <a href="./principal.jsp" id="voltar">
                <img src="img/Voltar.svg" alt="Voltar">
            </a>
            <div class="row row-cols-1 row-cols-md-3">
                <div class="col mb-4">
                    <div class="imagem">
                        <img src="img/<%=prod.getTipoRemedio()%>.png" alt="Repelente">
                    </div>
                </div>
                <div class="col mb-4">
                    <div class="conteudo">
                        <h2><%=prod.getNomeRemedio()%></h2>
                        <div class="descricao">
                            <p><%=prod.getDetalhes()%></p>
                        </div>
                    </div>
                </div>
                <div class="col mb-4">
                    <div class="compra">
                        <div class="preco">
                            <span id="valor"><%=NumberFormat.getCurrencyInstance(new Locale("pt", "BR")).format(prod.getValUnit())%></span>
                            <span id="text">em até 12x sem juros no cartão de crédito</span>
                        </div>
                        <div class="qtd">
                            <div class="quantidade-produtos">
                                <button type="button" class="buttons qty-minus" style="border-radius: 8px 0 0 8px;">-</button>
                                <input id="input_qtd" value="0" min="0" max="1000" step="1" type="number">
                                <button type="button" class="buttons qty-plus"
                                    style="border-radius: 0 8px 8px 0;">+</button>
                            </div>
                        </div>
                        <button id="comprar" class="btn btn-primary" onclick="carrinho(<%=prod.getIdRemedio()%>)" method="get">
                            <img data-feather="shopping-cart" alt="Carrinho" fill="white" stroke="white">
                            <span>Comprar</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <footer>
        <div class="d-flex justify-content-between" id="foot">
            <div class="text" style="color: white; text-align: center;">Copyright © Coronga Farma</div>
            <div>
                <a href="" style="color: white;">Privacy Policy</a>
                ·
                <a href="" style="color: white;">Terms &amp; Conditions</a>
            </div>
        </div>
    </footer>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
    <script src="https://unpkg.com/feather-icons"></script>
    <script src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>
    <script>
        feather.replace();
    </script>
    <script src="Resources/JS/detalhes.js"></script>
    <script src="Resources/JS/confdetalhe.js"></script>
</body>

</html>