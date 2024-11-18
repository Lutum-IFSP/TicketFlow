<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <c:set var="url">${pageContext.request.requestURL}</c:set>
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="css/toast.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
        <title><fmt:message key="title_login" /></title>
    </head>
    <body>
        <div id="cir1" class="circle"></div>
        <div id="cir2" class="circle"></div>
        <main>
            <form action="auth/login" method="POST">
                <fieldset>
                    <legend><fmt:message key="legend_login" /></legend>
                    <label for="username"></label>
                    <input type="text" id="username" name="username" placeholder="<fmt:message key="user_placeholder" />">
                    <label for="senha"></label>
                    <input type="password" id="senha" name="password" placeholder="<fmt:message key="pass_placeholder" />">
                    <input type="submit" value="<fmt:message key="button_login" />" id="botao">
                </fieldset>
            </form>
        </main>

        <div class="toast">
            <div class="toast-content">
                <i class="fas fa-solid fa-times times"></i>

                <div class="message">
                    <span class="text text-1"><fmt:message key="error_message" /></span>
                    <span class="text text-2"><fmt:message key="error_detail_login" /></span>
                </div>
            </div>
            <i class="fa-solid fa-xmark close"></i>

            <div class="progress"></div>
        </div>

        <c:if test="${requestScope.error}" >
            <script src="js/toast.js"></script>
        </c:if>

        <div id="loading">
            <div class="loader"></div> 
        </div>
    </body>

    <script>
        let btn = document.querySelector("#botao");
        let loading = document.querySelector("#loading");

        btn.addEventListener('click', () => {
            loading.style.display = 'flex';
        });
    </script>
</html>