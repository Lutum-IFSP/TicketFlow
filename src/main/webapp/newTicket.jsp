<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<c:set var="url">${pageContext.request.requestURL}</c:set>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />

<c:set var="user" value="${sessionScope.user}"/>
<c:set var="tech" value="${(user.role == Role.TECHNICIAN || user.role == Role.ADMIN) ? true : false}"/> 
<!-- Boxicons CDN Link -->
<link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<link rel="stylesheet" href="css/high_contrast.css">
<link rel="stylesheet" href="css/new_ticket.css">
<script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet">

<!-- Create Ticket -->
<div id="fundo">
    <div id="newTicket">
        <div id="formTicket">
            <span class="material-symbols-outlined" id="close" onclick="fecharmodelNewTicket()">close</span>
            <form action="ticket/create" method="post">
                <div>
                    <label for="titulo"><fmt:message key="new_title" /></label>
                    <input type="text" id="titulo" name="titulo" maxlength="255" required>
                </div>

                <div id="editor-wrap">
                    <label for="editor"><fmt:message key="new_editor" /></label>
                    <div id="editor"></div>
                    <input type="text" id="editor-input" name="editor" style="display: none" value="" required>
                </div>

                <div>
                    <input type="submit" value="<fmt:message key="button_editor" />" id="enviarTicket" name="enviarTicket">
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Create Ticket End -->

<script>
    const quill = new Quill('#editor', {
        theme: 'snow'
    });

    let elementToObserve = document.getElementsByClassName("ql-editor")[0];

    let observer = new MutationObserver((mutationList, observer) => {
        document.getElementById("editor-input").setAttribute("value", document.querySelector(".ql-editor").innerHTML)
    });
    
    observer.observe(elementToObserve, {characterData: true, childList: false, attributes: false, subtree: true});

    function abrirmodelNewTicket(){
        let fundo = document.getElementById("fundo")
        
        fundo.style.display = "block";
    }

    function fecharmodelNewTicket(){
        let fundo = document.getElementById("fundo")

        fundo.style.display = "none"
    }
</script>