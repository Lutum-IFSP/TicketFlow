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
    <c:set var="user" value="${sessionScope.user}"/>
    <c:set var="tech" value="${(user.role == Role.TECHNICIAN || user.role == Role.ADMIN) ? true : false}"/>

    <!-- temp -->
    
    <c:choose>
        <c:when test="${tech}">
            <c:set var="listHigh" value="${sessionScope.listHigh}"/>
            <c:set var="listMid" value="${sessionScope.listMid}"/>
            <c:set var="listLow" value="${sessionScope.listLow}"/>
            <c:set var="listUndefined" value="${sessionScope.listUndefined}"/>
        </c:when>

        <c:otherwise>
            <c:set var="listUnresolved" value="${sessionScope.listUnresolved}"/>
            <c:set var="listSolved" value="${sessionScope.listSolved}"/>
        </c:otherwise>
    </c:choose>

    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
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

    <main>
        <c:choose>
            <c:when test="${tech}">
        <!-- Sidebar -->
                <div class="sidebar">
                    <div class="logo-details">
                        <i class="bx icon" style="background-image: url(image/icon_ticketflow.svg); background-size: contain; background-position: center; margin-right: .5vw; filter: brightness(3);"></i>
                        <div class="logo_name">TicketFlow</div>
                        <i class="bx bx-menu" id="btn"></i>
                    </div>
                    <ul class="nav-list">
                        <li>
                            <i class="bx bx-search"></i>
                            <input type="text" placeholder="Search..." />
                            <span class="tooltip">Search</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="material-symbols-outlined"> dashboard </i>
                                <span class="links_name">Dashboard</span>
                            </a>
                            <span class="tooltip">Dashboard</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="material-symbols-outlined"> confirmation_number </i>
                                <span class="links_name">Tickets</span>
                            </a>
                            <span class="tooltip">Tickets</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="bx bx-pie-chart-alt-2"></i>
                                <span class="links_name">Analytics</span>
                            </a>
                            <span class="tooltip">Analytics</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="bx bx-chat"></i>
                                <span class="links_name">Messages</span>
                            </a>
                            <span class="tooltip">Messages</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="bx bx-user"></i>
                                <span class="links_name">User</span>
                            </a>
                            <span class="tooltip">User</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="bx bx-cog"></i>
                                <span class="links_name">Setting</span>
                            </a>
                            <span class="tooltip">Setting</span>
                        </li>
                        <li class="profile">
                            <div class="profile-details">
                                <img src="${user.image}" alt="profileImg" />
                                <div class="name_job">
                                    <div class="name">${user.username}</div>
                                    <div class="job">${user.role}</div>
                                </div>
                            </div>
                            <i class="bx bx-log-out" id="log_out"></i>
                        </li>
                    </ul>
                </div>
        <!-- Sidebar end -->

                <div id="listasTarefas">
                    <div id="listaUrgente" class="lista">
                        <ul>
                            <h3>High Urgency</h3>
                            <c:choose>
                                <c:when test="${listHigh.size() > 0}">
                                    <c:forEach begin="1" end="${listHigh.size()}" varStatus="loop">
                                        <li>
                                            <span class="classificacao"><img src="image/tarefaUrgente.png"></span>
                                            <span class="title"><c:out value="${listHigh.get(loop.index - 1).title}"/></span>
                                        </li>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);">No tickets here</span>
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
                            <h3>Medium Urgency</h3>
                            <c:choose>
                                <c:when test="${listMid.size() > 0}">
                                    <c:forEach begin="1" end="${listMid.size()}" varStatus="loop">
                                        <li>
                                            <span class="classificacao"><img src="image/tarefaMediaUrgencia.png"></span>
                                            <span class="title"><c:out value="${listMid.get(loop.index - 1).title}"/></span>
                                        </li>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);">No tickets here</span>
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
                            <h3>Low Urgency</h3>
                            <c:choose>
                                <c:when test="${listLow.size() > 0}">
                                    <c:forEach begin="1" end="${listLow.size()}" varStatus="loop">
                                        <li>
                                            <span class="classificacao"><img src="image/tarefaBaixaUrgencia.png"></span>
                                            <span class="title"><c:out value="${listLow.get(loop.index - 1).title}"/></span>
                                        </li>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);">No tickets here</span>
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
                            <h3>Undefined</h3>
                            <c:choose>
                                <c:when test="${listUndefined.size() > 0}">
                                    <c:forEach begin="1" end="${listUndefined.size()}" varStatus="loop">
                                        <li>
                                            <span class="classificacao"><img src="image/solucionado.png"></span>
                                            <span class="title"><c:out value="${listUndefined.get(loop.index - 1).title}"/></span>
                                        </li>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);">No tickets here</span>
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
                <!-- Sidebar -->
                <div class="sidebar">
                    <div class="logo-details">
                        <i class="bx icon" style="background-image: url(image/icon_ticketflow.svg); background-size: contain; background-position: center; margin-right: .5vw; filter: brightness(3);"></i>
                        <div class="logo_name">TicketFlow</div>
                        <i class="bx bx-menu" id="btn"></i>
                    </div>
                    <ul class="nav-list">
                        <li>
                            <i class="bx bx-search"></i>
                            <input type="text" placeholder="Search..." />
                            <span class="tooltip">Search</span>
                        </li>
                        <li onclick="abrirmodelNewTicket()">
                            <a>
                                <i class='bx bx-plus-circle'></i>
                                <span class="links_name">New ticket</span>
                            </a>
                            <span class="tooltip">New ticket</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="material-symbols-outlined"> confirmation_number </i>
                                <span class="links_name">Tickets</span>
                            </a>
                            <span class="tooltip">Tickets</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="bx bx-chat"></i>
                                <span class="links_name">Messages</span>
                            </a>
                            <span class="tooltip">Messages</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="bx bx-user"></i>
                                <span class="links_name">User</span>
                            </a>
                            <span class="tooltip">User</span>
                        </li>
                        <li>
                            <a href="#">
                                <i class="bx bx-cog"></i>
                                <span class="links_name">Setting</span>
                            </a>
                            <span class="tooltip">Setting</span>
                        </li>
                        <li class="profile">
                            <div class="profile-details">
                                <img src="${user.image}" alt="profileImg" />
                                <div class="name_job">
                                    <div class="name">${user.username}</div>
                                    <div class="job">${user.role}</div>
                                </div>
                            </div>
                            <i class="bx bx-log-out" id="log_out"></i>
                        </li>
                    </ul>
                </div>
                <!-- Sidebar end -->

                <div id="listas">
                    <div id="ticketsRespondidos" class="lista">
                        <ul>
                            <h3>Solved</h3>
                            <c:choose>
                                <c:when test="${listSolved.size() > 0}">
                                    <c:forEach begin="1" end="${listSolved.size()}" varStatus="loop">
                                        <li>
                                            <span class="classificacao"><img src="image/solucionado.png"></span>
                                            <span class="title"><c:out value="${listSolved.get(loop.index - 1).title}"/></span>
                                        </li>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);">No tickets here</span>
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
                            <h3>Unresolved</h3>
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
                                        
                                        <li>
                                            <span class="classificacao"><img src="${img}"></span>
                                            <span class="title"><c:out value="${listUnresolved.get(loop.index - 1).title}"/></span>
                                        </li>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <li>
                                        <span class="title" style="color: rgb(105, 105, 72);">No tickets here</span>
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

                <!-- Create Ticket -->
                <div id="fundo">
                    <div id="newTicket">
                        <div id="formTicket">
                            <span class="material-symbols-outlined" id="close" onclick="fecharmodelNewTicket()">close</span>
                            <form action="ticket/create" method="post">
                                <div style="margin-bottom: -200px;">
                                    <label for="titulo">Título do ticket</label>
                                    <input type="text" id="titulo" name="titulo" required>
                                </div>

                                <div id="editor-wrap">
                                    <label for="editor">Descreva com detalhes o seu problema/dúvida</label>
                                    <div id="editor" onchange="setInput()"></div>
                                    <input type="text" id="editor-input" name="editor" style="display: none" value="" required>
                                </div>

                                <div>
                                    <input type="submit" value="ENVIAR" id="enviarTicket" name="enviarTicket">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- Create Ticket End -->
            </c:otherwise>
        </c:choose>
    </main>

    <c:if test="${!tech}" >
        <script>
            const quill = new Quill('#editor', {
                theme: 'snow'
            });

            let elementToObserve = document.getElementsByClassName("ql-editor")[0];

            let observer = new MutationObserver((mutationList, observer) => {
                document.getElementById("editor-input").setAttribute("value", document.querySelector(".ql-editor").innerHTML)
            });
            
            observer.observe(elementToObserve, {characterData: true, childList: false, attributes: false, subtree: true});
        </script>
    </c:if>


    <script>
        let logout = document.querySelector("#log_out");
        let sidebar = document.querySelector(".sidebar");
        let closeBtn = document.querySelector("#btn");
        let searchBtn = document.querySelector(".bx-search");

        function abrirmodelNewTicket(){
            let fundo = document.getElementById("fundo")
            
            fundo.style.display = "block";
        }

        function fecharmodelNewTicket(){
            let fundo = document.getElementById("fundo")

            fundo.style.display = "none"
        }

        closeBtn.addEventListener("click", () => {
            sidebar.classList.toggle("open");
            menuBtnChange(); //calling the function(optional)
        });
        searchBtn.addEventListener("click", () => {
            // Sidebar open when you click on the search iocn
            sidebar.classList.toggle("open");
            menuBtnChange(); //calling the function(optional)
        });
        logout.addEventListener("click", () => {
            window.location.href = "auth/logout";
        });
        // following are the code to change sidebar button(optional)
        function menuBtnChange() {
            if (sidebar.classList.contains("open")) {
                closeBtn.classList.replace("bx-menu", "bx-menu-alt-right"); //replacing the iocns class
            } else {
                closeBtn.classList.replace("bx-menu-alt-right", "bx-menu"); //replacing the iocns class
            }
        }
    </script>
</body>
</html>
