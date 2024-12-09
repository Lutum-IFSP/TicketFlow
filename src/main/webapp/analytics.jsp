<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <c:set var="url">${pageContext.request.requestURL}</c:set>
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
        
        <link rel="stylesheet" href="css/analytics.css"/>
        <!-- Boxicons CDN Link -->
        <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" href="css/toast.css">
        <link rel="stylesheet" href="css/high_contrast.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <title><fmt:message key="analytics" /></title>
    </head>
    <body>
        <div id="cir1" class="circle"></div>
        <div id="cir2" class="circle"></div>

        <!-- Data -->
        
        <main>
            <c:import url="sidebar.jsp" />

            <div id="ticketFundo">
                <div id="ticket">
                    <h1>Analytics</h1>
                    <hr>
                    <div style="
                        display: flex;
                        flex-direction: column;
                    ">
                        <div style="
                            display: flex;
                            flex-direction: row;
                        ">
                            <div style="background-color: red; width: 20em; height: 8em; margin-right: 1em;"></div>
                            <div style="background-color: red; width: 20em; height: 8em;"></div>
                        </div>
                        <div id="chart_div"></div>
                        <div style="
                            display: flex;
                            flex-direction: row;
                            margin-top: 1em;
                        ">
                            <div style="background-color: red; width: 20em; height: 8em; margin-right: 1em;"></div>
                            <div style="background-color: red; width: 20em; height: 8em;"></div>
                        </div>

                    </div>
                </div>
            </div>
        </main>
        <script src="js/analytics.js"></script>
    </body>
</html>