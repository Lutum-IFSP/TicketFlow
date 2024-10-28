<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/toast.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
    <title>TicketFlow - Login</title>
</head>
<body>
    <div id="cir1" class="circle"></div>
    <div id="cir2" class="circle"></div>
    <main>
        <form action="auth/login" method="POST">
            <fieldset>
                <legend>LOGIN</legend>
                <label for="username"></label>
                <input type="text" id="username" name="username" placeholder="Username">
                <label for="senha"></label>
                <input type="password" id="senha" name="password" placeholder="Password">
                <input type="submit" value="LOGIN" id="botao">
            </fieldset>
        </form>
    </main>

    <div class="toast">
        <div class="toast-content">
            <i class="fas fa-solid fa-times times"></i>

            <div class="message">
                <span class="text text-1">Ocorreu um erro</span>
                <span class="text text-2">Usuário e/ou senha incorretos!</span>
            </div>
        </div>
        <i class="fa-solid fa-xmark close"></i>

        <div class="progress"></div>
    </div>

    <c:if test="${requestScope.error}" >
        <script src="js/toast.js"></script>
    </c:if>
</body>
</html>