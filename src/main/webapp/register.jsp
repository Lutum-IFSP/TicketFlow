<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="model.entity.User" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <c:set var="url">${pageContext.request.requestURL}</c:set>
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/register.css">
        <link rel="stylesheet" href="css/toast.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
        <title><fmt:message key="title_register" /></title>
    </head>
    <body>
        <div id="cir1" class="circle"></div>
        <div id="cir2" class="circle"></div>
        <main>
            <form action="auth/register" method="POST" enctype="multipart/form-data" accept="image/*">
                <fieldset>
                    <legend><fmt:message key="legend_register" /></legend>
                    <div id="esquerda">
                        <label for="username"></label>
                        <input type="text" id="username" name="username" placeholder="<fmt:message key="user_placeholder" />" required>
                        <label for="email"></label>
                        <input type="email" id="email" name="email" placeholder="<fmt:message key="mail_placeholder" />" required>
                        <div id="cargo">
                            <label for="cargo" style="user-select: none;"><fmt:message key="role_label" /></label>
                            <select id="cargo" name="role">
                                <option value="ADMIN"><fmt:message key="admin_role" /></option>
                                <option value="TECHNICIAN"><fmt:message key="technician_role" /></option>
                                <option value="USER"><fmt:message key="user_role" /></option>
                            </select>
                        </div>
                    </div>
                    <div id="direita">
                        <label for="senha"></label>
                        <input type="password" id="senha" name="password" placeholder="<fmt:message key="pass_placeholder" />" required>
                        <label for="confirmarSenha"></label>
                        <input type="password" id="confirmarSenha" name="confirmarSenha" placeholder="<fmt:message key="confirm_placeholder" />" required>
                        <div id="fUsuario">
                            <label for="foto">
                                <img src="image/register/imgUser.png">
                                <p><fmt:message key="image_placeholder" /></p>
                            </label>
                            <input type="file" name="foto" id="foto" style="display: none;">
                        </div>
                        <div id="botoes">
                            <button class="botao" onclick="window.location.href = 'index.jsp'"><fmt:message key="cancel_button" /></button>
                            <button type="submit" onclick="return validarSenha()" value="cadastrar" name="oprt" id="enviar-btn" class="botao"><fmt:message key="register_button" /></button>
                        </div>
                    </div>
                </fieldset>
            </form>
        </main>

        <div class="toast">
            <div class="toast-content">
                <i class="fas fa-solid fa-times times"></i>

                <div class="message">
                    <span class="text text-1"><fmt:message key="error_message" /></span>
                    <span class="text text-2"><fmt:message key="error_detail_register" /></span>
                </div>
            </div>
            <i class="fa-solid fa-xmark close"></i>

            <div class="progress"></div>
        </div>

        <c:if test="${requestScope.error}" >
            <script src="js/toast.js"></script>
        </c:if>
    </body>

    <p id="different-out" style="display: none;"><fmt:message key="different_password" /></p>

    <script>

        let input = document.querySelector("#foto");
        let different = document.getElementById("different-out");

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
                senhaC.setCustomValidity(different.innerText);
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
