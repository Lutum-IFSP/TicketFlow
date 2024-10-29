<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html5>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Loading...</title>
        <link rel="stylesheet" href="css/index.css">
    </head>
    <body>
        <div class="scene">
            <div class="shadow"></div>
            <div class="jumper">
              <div class="spinner">
                <div class="scaler">
                  <div class="loader">
                    <div class="cuboid">
                      <div class="cuboid__side"></div>
                      <div class="cuboid__side"></div>
                      <div class="cuboid__side"></div>
                      <div class="cuboid__side"></div>
                      <div class="cuboid__side"></div>
                      <div class="cuboid__side"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${sessionScope.user != null}">
                <c:redirect url="tickets.jsp" />
            </c:when>
        
            <c:otherwise>
                <c:redirect url="login.jsp" />
            </c:otherwise>
        </c:choose>
    </body>
</html>