<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page import="model.enums.Role, model.enums.Priority, model.entity.Ticket, model.entity.User, java.util.ArrayList" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <c:set var="url">${pageContext.request.requestURL}</c:set>
    <c:set var="user" value="${sessionScope.user}"/>
    <c:set var="tech" value="${(user.role == Role.TECHNICIAN || user.role == Role.ADMIN) ? true : false}"/>
    
    <c:choose>
        <c:when test="${tech}">
            <c:set var="listHigh" value="${sessionScope.listHigh}"/>
            <c:set var="listMid" value="${sessionScope.listMid}"/>
            <c:set var="listLow" value="${sessionScope.listLow}"/>
            <c:set var="listUndefined" value="${sessionScope.listUndefined}"/>
        </c:when>

        <c:otherwise>
            <c:set var="listSolved" value="${sessionScope.listSolved}"/>
            <c:set var="listUnresolved" value="${sessionScope.listUnresolved}"/>
        </c:otherwise>
    </c:choose>

    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/toast.css">
    <link rel="stylesheet" href="css/high_contrast.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet">
    <title>TicketFlow</title>

    <c:choose>
        <c:when test="${tech}">
            <link rel="stylesheet" href="css/tickets.css">
        </c:when>
    
        <c:otherwise>
            <link rel="stylesheet" href="css/ticketsUsuario.css">
        </c:otherwise>
    </c:choose>
    <!-- Boxicons CDN Link -->
    <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <div id="cir1" class="circle"></div>
    <div id="cir2" class="circle"></div>

    <c:if test="${!requestScope.blockAudio}" >
        <audio src="sounds/startup.ogg" id="startup" autoplay style="display: none"></audio>
        <script>
            let startupAudio = document.querySelector("#startup");
            startupAudio.volume = 0.2;
        </script>
    </c:if>

    <!-- Error popup -->

    <div class="toast">
        <div class="toast-content">
            <i class="fas fa-solid fa-times times"></i>

            <div class="message">
                <span class="text text-1"><fmt:message key="error_message" /></span>
                <span class="text text-2"><fmt:message key="error_detail_list" /></span>
            </div>
        </div>
        <i class="fa-solid fa-xmark close"></i>

        <div class="progress"></div>
    </div>

    <c:if test="${requestScope.errorGetTicket}" >
        <script src="js/toast.js"></script>
    </c:if>

    <!-- Error popup end-->

    <main>

        <c:import url="sidebar.jsp" />

        <c:choose>
            <c:when test="${tech}">
                <div id="listasTarefas">

                    <div id="listaUrgente" class="lista">

                        <%
                            ArrayList<Ticket> listHigh = (ArrayList<Ticket>) request.getAttribute("listHigh");
                        %>

                        <ul>
                            <h3><fmt:message key="high_urgency" /></h3>
                            <c:choose>
                                <c:when test="${listHigh.size() > 0}">
                                    <c:forEach begin="1" end="${listHigh.size()}" varStatus="loop">
                                        <a href="ticket/details?id=${listHigh.get(loop.index-1).id}">
                                            <li>
                                                <span class="classificacao"><img src="image/tarefaUrgente.png"></span>
                                                <span class="title"><c:out value="${listHigh.get(loop.index - 1).title}"/></span>
                                            </li>
                                        </a>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);"><fmt:message key="no_tickets" /></span>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <!-- Item Example
                            <li>
                                <span class="classificacao"><img src="image/tarefaUrgente.png"></span>
                                <span class="title">Teste</span>
                            </li>
                            -->
                        </ul>
                    </div>
                    
                    <div id="listaMediaUrgencia" class="lista">
                        <ul>
                            <h3><fmt:message key="mid_urgency" /></h3>
                            <c:choose>
                                <c:when test="${listMid.size() > 0}">
                                    <c:forEach begin="1" end="${listMid.size()}" varStatus="loop">
                                        <a href="ticket/details?id=${listMid.get(loop.index-1).id}">
                                            <li>
                                                <span class="classificacao"><img src="image/tarefaMediaUrgencia.png"></span>
                                                <span class="title"><c:out value="${listMid.get(loop.index - 1).title}"/></span>
                                            </li>
                                        </a>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);"><fmt:message key="no_tickets" /></span>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <!-- Item Example
                            <li>
                                <span class="classificacao"><img src="image/tarefaMediaUrgencia.png"></span>
                                <span class="title">Teste</span>
                            </li>
                            -->
                        </ul>
                    </div>

                    <div id="listaBaixaUrgencia" class="lista">
                        <ul>
                            <h3><fmt:message key="low_urgency" /></h3>
                            <c:choose>
                                <c:when test="${listLow.size() > 0}">
                                    <c:forEach begin="1" end="${listLow.size()}" varStatus="loop">
                                        <a href="ticket/details?id=${listLow.get(loop.index-1).id}">
                                            <li>
                                                <span class="classificacao"><img src="image/tarefaBaixaUrgencia.png"></span>
                                                <span class="title"><c:out value="${listLow.get(loop.index - 1).title}"/></span>
                                            </li>
                                        </a>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);"><fmt:message key="no_tickets" /></span>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <!-- Item Example
                            <li>
                                <span class="classificacao"><img src="image/tarefaBaixaUrgencia.png"></span>
                                <span class="title">Teste</span>
                            </li>
                            -->
                        </ul>
                    </div>
                    
                    <div id="listaNaoClassificado" class="lista">
                        <ul>
                            <h3><fmt:message key="undefined_urgency" /></h3>
                            <c:choose>
                                <c:when test="${listUndefined.size() > 0}">
                                    <c:forEach begin="1" end="${listUndefined.size()}" varStatus="loop">
                                        <a href="ticket/details?id=${listUndefined.get(loop.index-1).id}">
                                            <li>
                                                <span class="classificacao"><img src="image/solucionado.png"></span>
                                                <span class="title"><c:out value="${listUndefined.get(loop.index - 1).title}"/></span>
                                            </li>
                                        </a>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);"><fmt:message key="no_tickets" /></span>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <!-- Item Example
                            <li>
                                <span class="classificacao"><img src="image/tarefaBaixaUrgencia.png"></span>
                                <span class="title">Teste</span>
                            </li>
                            -->
                        </ul>
                    </div>
                </div>
            </c:when>
        
            <c:otherwise>
                
                <div id="listas">
                    <div id="ticketsRespondidos" class="lista">
                        <ul>
                            <h3><fmt:message key="solved_tickets" /></h3>
                            <c:choose>
                                <c:when test="${listSolved.size() > 0}">
                                    <c:forEach begin="1" end="${listSolved.size()}" varStatus="loop">
                                        <a href="ticket/details?id=${listSolved.get(loop.index-1).id}">
                                            <li>
                                                <span class="classificacao"><img src="image/solucionado.png"></span>
                                                <span class="title"><c:out value="${listSolved.get(loop.index - 1).title}"/></span>
                                            </li>
                                        </a>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);"><fmt:message key="no_tickets" /></span>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <!-- Item Example
                            <li>
                                <span class="classificacao"><img src="image/solucionado.png"></span>
                                <span class="title">Teste</span>
                            </li>
                            -->
                        </ul>
                    </div>

                    <div id="ticketsAbertos" class="lista">
                        <ul>
                            <h3><fmt:message key="unsolved_tickets" /></h3>
                            <c:choose>
                                <c:when test="${listUnresolved.size() > 0}">

                                    <c:forEach begin="1" end="${listUnresolved.size()}" varStatus="loop">
                                        <c:choose>
                                            <c:when test="${listUnresolved.get(loop.index - 1).priority == Priority.UNDEFINED}">
                                                <c:set var="img" value="image/solucionado.png"/>
                                            </c:when>
                                            
                                            <c:when test="${listUnresolved.get(loop.index - 1).priority == Priority.LOW}">
                                                <c:set var="img" value="image/tarefaBaixaUrgencia.png"/>
                                            </c:when>
                                            
                                            <c:when test="${listUnresolved.get(loop.index - 1).priority == Priority.MID}">
                                                <c:set var="img" value="image/tarefaMediaUrgencia.png"/>
                                            </c:when>
                                            
                                            <c:otherwise>
                                                <c:set var="img" value="image/tarefaUrgente.png"/>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <a href="ticket/details?id=${listUnresolved.get(loop.index-1).id}">
                                            <li>
                                                <span class="classificacao"><img src="${img}"></span>
                                                <span class="title"><c:out value="${listUnresolved.get(loop.index - 1).title}"/></span>
                                            </li>
                                        </a>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);"><fmt:message key="no_tickets" /></span>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <!-- Item Example
                            <li>
                                <span class="classificacao"><img src="image/tarefaMediaUrgencia.png"></span>
                                <span class="title">Titulo</span>
                            </li>
                            -->
                        </ul>
                    </div>
                </div> 

                <c:import url="newTicket.jsp" />
            </c:otherwise>
        </c:choose>
¨
        <c:if test="${!empty requestScope.deleteStatus}" >
            <div id="status-vignette">
                <div id="status-modal">
                    <div id="status-info">
                        <c:choose>
                            <c:when test="${(requestScope.deleteStatus == true)}">
                                <div id="status-circle"><i class='bx bx-check' ></i></div>
                            </c:when>
                            
                            <c:otherwise>
                                <div id="status-circle"><i class='bx bx-x' ></i></div>
                            </c:otherwise>
                        </c:choose>
                        <i class='bx bx-x' onclick="closeDeleteModal()"></i>
                        
                        <c:choose>
                            <c:when test="${(requestScope.deleteStatus == true)}">
                                <h1><fmt:message key="success_message" /></h1>
                            </c:when>
                            
                            <c:otherwise>
                                <h1><fmt:message key="error_message" /></h1>
                            </c:otherwise>
                        </c:choose>
                        <button onclick="closeDeleteModal()"><fmt:message key="button_ok" /></button>
                    </div>
                </div>
            </div>

            <c:if test="${requestScope.deleteStatus == false}" >
                <script>
                    let modal = document.getElementById("status-info");
                    let circle = document.getElementById("status-circle");
                    let button = document.querySelector("#status-info button");

                    modal.style.borderTopColor = "red";
                    circle.style.backgroundColor = "red";
                    circle.style.boxShadow = "0px 0px 10px 5px rgba(255, 0, 0, 0.397)"
                    button.style.backgroundColor = "red";
                </script>
            </c:if>

            <script>
                function closeDeleteModal() {
                    let modal = document.getElementById("status-vignette");

                    modal.style.display = "none";
                }
            </script>
        </c:if>
    </main>

    <script src="js/high_contrast.js"></script>
</body>
</html>
