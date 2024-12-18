<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page import="model.enums.Role, model.enums.Priority, model.enums.Stage, model.entity.Ticket, model.entity.User, java.util.ArrayList" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <c:set var="url">${pageContext.request.requestURL}</c:set>
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
        <c:set var="ticket" value="${requestScope.ticket}"/>
        <c:set var="notes" value="${requestScope.notes}"/>
        <c:set var="author" value="${requestScope.author}"/>
        <c:set var="user" value="${sessionScope.user}"/>
        <c:set var="tech" value="${(user.role == Role.TECHNICIAN || user.role == Role.ADMIN) ? true : false}"/>
        <link rel="icon" type="image/x-icon" href="image/icon.png">
        <link rel="stylesheet" href="css/ticket.css" />
        <!-- Boxicons CDN Link -->
        <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" href="css/toast.css">
        <link rel="stylesheet" href="css/high_contrast.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><c:out value="${ticket.title}"/></title>
    </head>
    <body>
        <div id="cir1" class="circle"></div>
        <div id="cir2" class="circle"></div>

        <main>
            <c:import url="sidebar.jsp" />

            <div id="ticketFundo">
                <div id="ticket">
                    <div id="infoTicket">
                        <h1><c:out value="${ticket.title}"/></h1>
                        <hr>

                        <ul>
                            <c:choose>
                                <c:when test="${tech && ticket.priority == Priority.UNDEFINED && ticket.stage == Stage.OPEN}">
                                    <li>
                                        <form action="ticket/change" method="POST">
                                            <input type="text" name="id" value="${ticket.id}" hidden>

                                            <label for="priority"><span>Priority: </span></label>
                                            <select name="priority" id="priority" onchange="this.form.submit()">
                                                <option value="0" ${(ticket.priority == Priority.UNDEFINED) ? "selected" : ""}><fmt:message key="undefined_priority" /></option>
                                                <option value="1" ${(ticket.priority == Priority.LOW) ? "selected" : ""}><fmt:message key="low_priority" /></option>
                                                <option value="2" ${(ticket.priority == Priority.MID) ? "selected" : ""}><fmt:message key="mid_priority" /></option>
                                                <option value="3" ${(ticket.priority == Priority.HIGH) ? "selected" : ""}><fmt:message key="high_priority" /></option>
                                            </select>
                                        </form>
                                    </li>
                                </c:when>
                                
                                <c:otherwise>
                                    <li><span><fmt:message key="priority_label" />: </span>
                                        <c:choose>
                                            <c:when test="${ticket.priority == Priority.UNDEFINED}">
                                                <fmt:message key="undefined_priority" />
                                            </c:when>
                                            
                                            <c:when test="${ticket.priority == Priority.LOW}" >
                                                <fmt:message key="low_priority" />
                                            </c:when>

                                            <c:when test="${ticket.priority == Priority.MID}" >
                                                <fmt:message key="mid_priority" />
                                            </c:when>

                                            <c:otherwise>
                                                <fmt:message key="high_priority" />
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <li><span><fmt:message key="stage_label" />: </span> 
                                <c:choose>
                                    <c:when test="${ticket.stage == Stage.OPEN}">
                                        <fmt:message key="open_stage" />
                                    </c:when>
                                    
                                    <c:otherwise>
                                        <fmt:message key="closed_stage" />
                                    </c:otherwise>
                                </c:choose>
                            </li>
                            <li><span><fmt:message key="created_label" />: </span> <c:out value="${ticket.created}"/></li>
                            <li><span><fmt:message key="updated_label" />: </span> <c:out value="${ticket.updated}"/></li>
                            <li><span><fmt:message key="closed_label" />: </span> <c:out value="${ticket.closed}"/></li>
                            <li><span><fmt:message key="author_label" />: </span> <img src="${author.image}"> ${author.username}</li>
                        </ul>
                    </div>

                    <div id="descricao">
                        <h4><fmt:message key="description_label" />: </h4>
                        <div>
                            ${ticket.description}
                        </div>
                    </div>

                    <div id="chat">
                        <c:choose>
                            <c:when test="${notes.size() > 0}">
                                <c:forEach begin="1" end="${notes.size()}" varStatus="loop">
                                    <div class="resposta">
                                        <div class="identificacao">
                                            <img src="${notes.get(loop.index - 1).poster.image}" alt="${notes.get(loop.index - 1).poster.username}">
                                            <h4>${notes.get(loop.index - 1).poster.username} (${notes.get(loop.index - 1).poster.role})</h4>
                                            <div class="datas">
                                                <p><fmt:message key="send_label" />: ${fn:substringBefore(notes.get(loop.index - 1).send, "T")} ${fn:substring(fn:substringAfter(notes.get(loop.index - 1).send, "T"), 0, 5)}</p>
                                                <p><fmt:message key="updated_label" />: ${fn:substringBefore(notes.get(loop.index - 1).updated, "T")} ${fn:substring(fn:substringAfter(notes.get(loop.index - 1).updated, "T"), 0, 5)}</p>
                                            </div>
                                        </div>
                                        <div class="res">
                                            <p>${notes.get(loop.index - 1).text}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <div id="no-notes">
                                    <img src="image/empty.png" alt="">
                                    <h1><fmt:message key="empty_h1" /></h1>
                                    <span style="color: rgb(105, 105, 72);"><fmt:message key="empty_span" /></span>
                                    <button onclick="document.getElementById('editor-wrap').scrollIntoView();"><fmt:message key="empty_button" /></button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${ticket.stage == Stage.OPEN}" >
                            <hr>

                            <form action="note/post" method="post">
                                <input type="text" name="ticketId" value="${ticket.id}" style="display: none" hidden>

                                <div id="editor-wrap">
                                    <label for="editor"><h3><fmt:message key="editor_label" /></h3></label>
                                    <div id="editor" onchange="setInput()"></div>
                                    <input type="text" id="editor-input" name="editor" style="display: none" value="" required>
                                </div>

                                <div id="botao">
                                    <button type="submit" id="enviarNote"><i class='bx bx-send'></i></button>
                                </div>
                            </form>
                        </c:if>

                        <hr>

                        <c:set var="blockAudio" scope="request" value="true"/>

                        <div id="botoes">
                            <a href="ticket/list?blockAudio=1"><input type="button" value="<fmt:message key="back_button" />"></a>
                            <c:choose>
                                <c:when test="${tech && ticket.stage == Stage.OPEN}">
                                    <a><input type="button" onclick="openModalDelete()" value="<fmt:message key="close_button" />"></a>
                                </c:when>
                                
                                <c:otherwise>
                                    <a href="ticket/delete?id=${ticket.id}"><input type="button" value="<fmt:message key="delete_ticket" />"></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div id="confirm-vignette" style="display: none">
            <div id="confirm-modal">
                <div id="confirm-info">
                    <i class='bx bx-x-circle img'></i>
                    <h1><fmt:message key="confirm_h1" /></h1>
                    <h4><fmt:message key="confirm_h4" /></h4>

                    <div id="confirm-buttons">
                        <button class="confirm-buttons" onclick="closeModalDelete()" id="cancel"><fmt:message key="buttons_cancel" /></button>
                        
                        <a href="ticket/close?id=${ticket.id}"><button class="confirm-buttons" id="confirm"><fmt:message key="buttons_confirm" /></button></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Error popup -->
        <div class="toast">
            <div class="toast-content">
                <i class="fas fa-solid fa-times times"></i>

                <div class="message">
                    <span class="text text-1"><fmt:message key="error_message" /></span>
                    <span class="text text-2"><fmt:message key="error_detail_note" /></span>
                </div>
            </div>
            <i class="fa-solid fa-xmark close"></i>

            <div class="progress"></div>
        </div>

        <c:if test="${!empty param.error}" >
            <script src="js/toast.js"></script>
        </c:if>

        <c:if test="${!tech}" >
            <c:import url="newTicket.jsp" />
        </c:if>
    </body>

    <script src="js/high_contrast.js"></script>

    <script>
        const quill = new Quill('#editor', {
            theme: 'snow'
        });

        let elementToObserve = document.getElementsByClassName("ql-editor")[0];

        let observer = new MutationObserver((mutationList, observer) => {
            document.getElementById("editor-input").setAttribute("value", document.querySelector(".ql-editor").innerHTML)
        });
        
        observer.observe(elementToObserve, {characterData: true, childList: false, attributes: false, subtree: true});

        function openModalDelete() {
            let modal = document.getElementById("confirm-vignette");
            let info = document.getElementById("confirm-info");

            modal.style.display = "block";
            info.classList.add("slide-in-blurred-bottom");
        }
        function closeModalDelete() {
            let modal = document.getElementById("confirm-vignette");
            let info = document.getElementById("confirm-info");

            info.classList.add("slide-out-blurred-bottom");

            setTimeout(() => {
                modal.style.display = "none";
                info.classList.remove("slide-in-blurred-bottom");
                info.classList.remove("slide-out-blurred-bottom");
            }, 600);

        }
    </script>
</html>