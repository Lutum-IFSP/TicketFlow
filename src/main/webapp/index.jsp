<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<!DOCTYPE html5>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TicketFlow</title>
        <link rel="stylesheet" href="css/index.css">
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionScope.user != null}">
                <c:redirect url="tickets.jsp" />
            </c:when>
        
            <c:otherwise>
                <c:redirect url="auth/empty"/>
            </c:otherwise>
        </c:choose>
    </body>
</html>