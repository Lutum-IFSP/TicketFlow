<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page import="model.enums.Role, model.enums.Priority, model.entity.Ticket, model.entity.User, java.util.ArrayList" %>
<!DOCTYPE html>
    <html lang="pt-br">
    <head>
        <c:set var="url">${pageContext.request.requestURL}</c:set>
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <c:set var="ticket" value="${requestScope.ticket}"/>
        <c:set var="notes" value="${requestScope.notes}"/>
        <c:set var="author" value="${requestScope.author}"/>
        <c:set var="user" value="${sessionScope.user}"/>
        <c:set var="tech" value="${(user.role == Role.TECHNICIAN || user.role == Role.ADMIN) ? true : false}"/>
        <title><c:out value="${ticket.title}"/></title>
    </head>
    <body>
        <h1><c:out value="${ticket.title}"/></h1>
        <hr>
        <p>Tags: <c:out value="${ticket.tags}"/></p>
        <p>Description: <c:out value="${ticket.description}"/></p>
        <p>Stage: <c:out value="${ticket.stage}"/></p>
        <c:choose>
            <c:when test="${tech}">
                <form action="ticket/change" method="POST">
                    <input type="text" name="id" value="${ticket.id}" hidden>

                    <label for="priority">Priority: </label>
                    <select name="priority" id="priority" onchange="this.form.submit()">
                        <option value="0" ${(ticket.priority == Priority.UNDEFINED) ? "selected" : ""}>UNDEFINED</option>
                        <option value="1" ${(ticket.priority == Priority.LOW) ? "selected" : ""}>LOW</option>
                        <option value="2" ${(ticket.priority == Priority.MID) ? "selected" : ""}>MID</option>
                        <option value="3" ${(ticket.priority == Priority.HIGH) ? "selected" : ""}>HIGH</option>
                    </select>
                </form>
            </c:when>
            
            <c:otherwise>
                <p>Priority: <c:out value="${ticket.priority}"/></p>
            </c:otherwise>
        </c:choose>
        <p>Created: <c:out value="${ticket.created}"/></p>
        <p>Updated: <c:out value="${ticket.updated}"/></p>
        <p>Closed: <c:out value="${ticket.closed}"/></p>
        <p>Author: <c:out value="${author.username}"/></p>

        <hr>

        <ul>
            <c:choose>
                <c:when test="${notes.size() > 0}">
                    <c:forEach begin="1" end="${notes.size()}" varStatus="loop">
                        <li>
                            <span class="classificacao"><img src="${notes.get(loop.index - 1).poster.image}" alt="profileImg" /></span>
                            <span class="title">${notes.get(loop.index -1).text}</span>
                        </li>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <li>
                        <span class="title" style="color: rgb(105, 105, 72);">No notes</span>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </body>
</html>
