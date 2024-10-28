<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="model.entity.User" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/cadastroUsuario.css">
    <link rel="stylesheet" href="css/toast.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
    <title>TicketFlow - Login</title>
</head>
<body>
    <div id="cir1" class="circle"></div>
    <div id="cir2" class="circle"></div>
    <main>
        <form action="auth/register" method="POST" enctype="multipart/form-data" accept="image/*">
            <fieldset>
                <legend>CADASTRO</legend>
                <div id="esquerda">
                    <label for="username"></label>
                    <input type="text" id="username" name="username" placeholder="Username" required>
                    <label for="email"></label>
                    <input type="email" id="email" name="email" placeholder="E-mail" required>
                    <div id="cargo">
                        <label for="cargo" style="user-select: none;">Selecione o cargo do novo usuário</label>
                        <select id="cargo" name="role">
                            <option value="ADMIN">Administrador</option>
                            <option value="TECHNICIAN">Desenvolvedor</option>
                            <option value="USER">Usuário</option>
                        </select>
                    </div>
                </div>
                <div id="direita">
                    <label for="senha"></label>
                    <input type="password" id="senha" name="password" placeholder="Senha" required>
                    <label for="confirmarSenha"></label>
                    <input type="password" id="confirmarSenha" name="confirmarSenha" placeholder="Confirme a senha" required>
                    <div id="fUsuario">
                        <label for="foto">
                            <img src="image/cadastroUsuario/imgUser.png">
                            <p>Escolha uma foto para o seu perfil</p>
                        </label>
                        <input type="file" name="foto" id="foto" style="display: none;">
                    </div>
                    <div id="botoes">
                        <button class="botao" onclick="window.location.href = 'index.jsp'">CANCELAR</button>
                        <button type="submit" onclick="return validarSenha()" value="cadastrar" name="oprt" class="botao">CADASTRAR</button>
                    </div>
                </div>
            </fieldset>
        </form>
    </main>

    <div class="toast">
        <div class="toast-content">
            <i class="fas fa-solid fa-times times"></i>

            <div class="message">
                <span class="text text-1">Ocorreu um erro</span>
                <span class="text text-2">Já existe uma conta com esse nome/e-mail!</span>
            </div>
        </div>
        <i class="fa-solid fa-xmark close"></i>

        <div class="progress"></div>
    </div>

    <c:if test="${requestScope.error}" >
        <script src="js/toast.js"></script>
    </c:if>
</body>
<script>

    let input = document.querySelector("#foto")

    input.addEventListener( 'change', function( e )
    {
        var label = document.querySelector("#fUsuario label"),
		labelVal  = label.innerHTML; 

        var fileName = '';
        fileName = e.target.value.split( "\\" ).pop();

        if( fileName.length > 40 ) fileName = fileName.substring(0, 37).concat('...');

        if( fileName != '' )
            label.querySelector( 'p' ).innerHTML = fileName;
        else
            label.innerHTML = labelVal;
    });

    let senha = document.getElementById('senha');
    let senhaC = document.getElementById('confirmarSenha');

    function validarSenha() {
        if (senha.value != senhaC.value) {
            senhaC.setCustomValidity("Senhas diferentes!");
            senhaC.reportValidity();
            return false;
        } else {
            senhaC.setCustomValidity("");
            return true;
        }
    }

    senhaC.addEventListener('input', validarSenha);
</script>
</html>
