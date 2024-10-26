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
    <link rel="stylesheet" href="css/index.css">
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
</body>
</html>