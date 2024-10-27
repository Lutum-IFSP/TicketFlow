<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/cadastroUsuario.css">
    <title>TicketFlow - Login</title>
</head>
<body>
    <div id="cir1" class="circle"></div>
    <div id="cir2" class="circle"></div>
    <main>
        <form action="auth/register" method="POST">
            <fieldset>
                <legend>CADASTRO</legend>
                <div id="esquerda">
                    <label for="username"></label>
                    <input type="text" id="username" name="username" placeholder="Username" required>
                    <label for="email"></label>
                    <input type="email" id="email" name="email" placeholder="E-mail" required>
                    <div d="cargo">
                        <label for="cargo">Selecione o cargo no novo usuário</label>
                        <select id="cargo" name="cargo">
                            <option value="administrador">Administrador</option>
                            <option value="desenvolverdor">Desenvolverdor</option>
                        </select>
                    </div>
                </div>
                <div id="direita">
                    <label for="senha"></label>
                    <input type="password" id="senha" name="password" placeholder="Password" required>
                    <label for="confirmarSenha"></label>
                    <input type="password" id="confirmarSenha" name="confirmarSenha" placeholder="Confirm password" required>
                    <div id="botoes">
                        <input type="submit" value="CANCELAR" class="botao">
                        <button type="submit" onclick="return validarSenha()" value="cadastrar" name="oprt" class="botao">CADASTRAR</button>
                    </div>
                </div>
            </fieldset>
        </form>
    </main>
</body>
<script>
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
