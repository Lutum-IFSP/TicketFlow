<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page import="model.enums.Role, model.entity.User" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<c:set var="url">${pageContext.request.requestURL}</c:set>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />

<c:set var="user" value="${sessionScope.user}"/>
<c:set var="tech" value="${(user.role == Role.TECHNICIAN || user.role == Role.ADMIN) ? true : false}"/> 
<!-- Boxicons CDN Link -->
<link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<link rel="stylesheet" href="css/sidebar.css">
<link rel="stylesheet" href="css/high_contrast.css">

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
            <input type="text" id="bx-search-input" placeholder="<fmt:message key="search_placeholder" />" onkeyup="setList(this.value)" onfocus="autocompleteShow()" onfocusout="autocompleteClose()" />
            <span class="tooltip"><fmt:message key="search_tooltip" /></span>
            <div id="search-autocomplete">
                <ul id="search-list">
                </ul>
            </div>
        </li>
        <li>
            <a href="ticket/list?blockAudio=1">
                <i class="bx bx-home-alt"></i>
                <span class="links_name"><fmt:message key="home_tooltip" /></span>
            </a>
            <span class="tooltip"><fmt:message key="home_tooltip" /></span>
        </li>

        <c:if test="${!tech}" >
            <li onclick="abrirmodelNewTicket()">
                <a>
                    <i class='bx bx-plus-circle'></i>
                    <span class="links_name"><fmt:message key="new_tooltip" /></span>
                </a>
                <span class="tooltip"><fmt:message key="new_tooltip" /></span>
            </li>
        </c:if>

        <li>
            <a href="analytics.jsp">
                <i class="bx bx-pie-chart-alt-2"></i>
                <span class="links_name"><fmt:message key="analytics_tooltip" /></span>
            </a>
            <span class="tooltip"><fmt:message key="analytics_tooltip" /></span>
        </li>
        <li>
            <a href="settings.jsp?user=1">
                <i class="bx bx-user"></i>
                <span class="links_name"><fmt:message key="user_tooltip" /></span>
            </a>
            <span class="tooltip"><fmt:message key="user_tooltip" /></span>
        </li>
        <li>
            <a href="settings.jsp">
                <i class="bx bx-cog"></i>
                <span class="links_name"><fmt:message key="settings_tooltip" /></span>
            </a>
            <span class="tooltip"><fmt:message key="settings_tooltip" /></span>
        </li>
        <li class="profile">
            <div class="profile-details">
                <img src="${user.image}" alt="profileImg" />
                <div class="name_job">
                    <div class="name">${user.username}</div>

                    <div class="job">
                        <c:choose>
                            <c:when test="${user.role == Role.ADMIN}">
                                <fmt:message key="admin_role" />
                            </c:when>

                            <c:when test="${user.role == Role.TECHNICIAN}" >
                                <fmt:message key="technician_role" />
                            </c:when>
                            
                            <c:otherwise>
                                <fmt:message key="user_role" />
                            </c:otherwise>
                    </c:choose>
                    </div>
                </div>
            </div>
            <i class="bx bx-log-out" id="log_out"></i>
        </li>
    </ul>
</div>
<!-- Sidebar end -->

<script src="js/sidebar.js"></script>