<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page import="model.enums.Role, model.entity.User" %>

<c:set var="url">${pageContext.request.requestURL}</c:set>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />

<c:set var="user" value="${sessionScope.user}"/>
<c:set var="tech" value="${(user.role == Role.TECHNICIAN || user.role == Role.ADMIN) ? true : false}"/> 
<link rel="stylesheet" href="css/sidebar.css">

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
                <i class="bx bx-home-alt"></i>
                <span class="links_name">Home</span>
            </a>
            <span class="tooltip">Home</span>
        </li>

        <c:if test="${!tech}" >
            <li onclick="abrirmodelNewTicket()">
                <a>
                    <i class='bx bx-plus-circle'></i>
                    <span class="links_name">New ticket</span>
                </a>
                <span class="tooltip">New ticket</span>
            </li>
        </c:if>

        <li>
            <a href="#">
                <i class="bx bx-pie-chart-alt-2"></i>
                <span class="links_name">Analytics</span>
            </a>
            <span class="tooltip">Analytics</span>
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