<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page import="model.entity.User" %>
<!DOCTYPE html>
    <html lang="pt-br">
    <head>
        <c:set var="user" value="${sessionScope.user}"/>
        <c:if test="${requestScope.verified != null}">
            <c:set var="verified" value="${requestScope.verified}"/>
            <c:if test="${verified}">
                <script>
                    let newPassForm = document.getElementById("new-password-form");
                    let typeOldPass = document.getElementById("type-old-password");

                    newPassForm.style = "display: flex;";
                    typeOldPass.style = "display: none;";
                </script>
            </c:if>
        </c:if>

        <c:if test="${requestScope.status != null}">
            <c:set var="status" value="${requestScope.status}"/>
        </c:if>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/ticket.css">
        <link rel="stylesheet" href="css/toast.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <title><c:out value="${user.username}"/></title>
    </head>
    <body>
        <main style="margin-left: 8%;">
            <c:import url="sidebar.jsp" />

            <h1><img src="${user.image}" style="height: 5vw; width: 5vw; border-radius: 100%;"><c:out value="${user.username}"/></h1>
            <h3><c:out value="${user.role}"/></h3>
            <h4><c:out value="${user.email}"/></h4>
            <hr>
            <h5>Password</h5>
            <button onclick="changePassword()" id="button">Change Password</button>

            <div id="type-old-password" style="display: none;">
                <form action="auth/verify" method="post">
                    <label for="old-password">Type your password</label>
                    <input type="text" id="old-password" name="old-password"><br>

                    <input type="submit" value="Verify Old Password">
                </form>
            </div>

            <c:if test="${verified != null && verified}">
                <div id="new-password-form" style="display: none;">
                    <form action="auth/newpassword" method="post">
                        <label for="password"></label>
                        <input type="password" id="password" name="password" placeholder="New Password" required>
                        <label for="passwordConfirm"></label>
                        <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm New Password" required><br>

                        <input type="submit" onclick="return validatePassword()" value="Change Password">
                    </form>
                </div>
            </c:if>

            <c:if test="${status != null && status}"> 
                <div id="status-div">
                    <h5>Password Changed!</h5>
                </div>
            </c:if>

            <!-- Error popup -->
            <div class="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-times times"></i>

                    <div class="message">
                        <span class="text text-1">Ocorreu um erro</span>
                        <span class="text text-2">Senha incorreta</span>
                    </div>
                </div>
                <i class="fa-solid fa-xmark close"></i>

                <div class="progress"></div>
            </div>

            <c:if test="${requestScope.verified == false}" >
                <script src="js/toast.js"></script>
                <script>
                    document.getElementById("type-old-password").style = "display: none;";
                </script>
            </c:if>
            <!-- Error popup end-->
        </main>

        <script>
            let pass = document.getElementById('password');
            let passC = document.getElementById('passwordConfirm');

            function validatePasswod() {
                if (pass.value != passC.value) {
                    passC.setCustomValidity("Senhas diferentes!");
                    passC.reportValidity();
                    return false;
                } else {
                    passC.setCustomValidity("");
                    return true;
                }
            }

            passC.addEventListener('input', validatePasswod);

            function changePassword() {
                document.getElementById("type-old-password").style = "display: flex;";
            }

        </script>
    </body>
</html>