<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page import="model.enums.Role, model.entity.User" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="settings_title" /></title>
    <link rel="icon" type="image/x-icon" href="image/favicon.ico">
    <link rel="stylesheet" href="css/setting.css">
    <link rel="stylesheet" href="css/high_contrast.css">
    <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <c:set var="user" value="${sessionScope.user}" />
    <c:set var="adm" value="${(user.role == Role.ADMIN) ? true : false}"/>
</head>
<body>
    <div id="cir1" class="circle"></div>
    <div id="cir2" class="circle"></div>

    <main>
        <c:import url="sidebar.jsp" />

        <div id="user">
            <div id="painelUser" style="visibility: hidden; opacity: 0;">
                <div class="imagemPerfil">
                    <img src="${user.image}" id="imgUserSubmit">
                    <label for="edit"></label>
                    <button class="edit-button">
                        <label for="edit">
                            <i class='bx bx-edit-alt'><input type="file" id="edit" name="novaFoto" style="display: none"></i>
                        </label>
                    </button>
                </div>
                <div id="infoConta">
                    <form action="user/update" method="post" enctype="multipart/form-data" accept="image/*">
                        <input type="file" name="image" id="hidden-image" hidden>
                        <p><fmt:message key="role_p" />: <c:choose>
                            <c:when test="${user.role == Role.ADMIN}">
                                <fmt:message key="admin_role" />
                            </c:when>

                            <c:when test="${user.role == Role.TECHNICIAN}" >
                                <fmt:message key="technician_role" />
                            </c:when>
                            
                            <c:otherwise>
                                <fmt:message key="user_role" />
                            </c:otherwise>
                        </c:choose></p>
                        <label for="apelido"></label>
                        <input type="text" id="apelido" name="username" placeholder="<fmt:message key="user_placeholder" />" value="${user.username}">
                        <label for="emailUsuario"></label>
                        <input type="email" id="emailUsuario" name="email" placeholder="<fmt:message key="mail_placeholder" />" value="${user.email}">

                        <div class="botoes">
                            <input type="button" onclick="openChangePass()" id="alterarSenha" name="alterarSenha" value="<fmt:message key="change_password" />">
                            <input type="submit" id="salvar" name="salvar" value="<fmt:message key="save" />">
                        </div>
                    </form>
                </div>
            </div>

            <div id="customize" style="visibility: hidden; opacity: 0;">
                <div>
                    <p><fmt:message key="high_contrast" /></p>
                    <div class="onoff">
                        <input type="checkbox" class="toggle" id="onoff1" onclick="toggleContrast()">
                        <label for="onoff1"></label>
                    </div>
                </div>
                <hr>
                <div id="traduzir">
                    <label for="linguagens"><fmt:message key="language" /></label>
                    <select id="linguagens" name="linguagens" onchange="lang()">
                        <option value="pt_BR">Português Brasil</option>
                        <option value="en_EN">English</option>
                        <option value="es_ES">Spanish</option>
                        <option value="zh_CN">普通话</option>
                    </select>                
                </div>
            </div>

            <div id="creators" style="visibility: hidden; opacity: 0;">
                <div class="infoCriadores">
                    <img src="image/emilly.jpeg">
                    <div>
                        <h3>Emilly Caxias Reis</h3>
                        <p>
                            <span><a href="https://www.instagram.com/emillycaxias_reis/"><img src="image/instagram.png"></a></span>
                            <span>emillycaxias_reis</span>
                        </p>
                        <p>
                            <span><img src="image/o-email.png"></span>
                            <span>emillycaxiasr@gmail.com</span>
                        </p>
                    </div>
                </div>
                <hr>
                <div class="infoCriadores">
                    <img src="image/everton.jpeg">
                    <div>
                        <h3>Everton Paixão de Oliveira</h3>
                        <p>
                            <span><a href="https://www.instagram.com/everton_oliveira27/"><img src="image/instagram.png"></a></span>
                            <span>everton_oliveira27</span>
                        </p>
                        <p>
                            <span><img src="image/o-email.png"></span>
                            <span>dedepo2704@gmail.com</span>
                        </p>
                    </div>
                </div>
                <hr>
                <div class="infoCriadores">
                    <img src="image/gil.jpeg">
                    <div>
                        <h3>Gustavo Santos Gil</h3>
                        <p>
                            <span><a href="https://www.instagram.com/eugustavogil/"><img src="image/instagram.png"></a></span>
                            <span>eugustavogil</span>
                        </p>
                        <p>
                            <span><img src="image/o-email.png"></span>
                            <span>timidtlk@gmail.com</span>
                        </p>
                    </div>
                </div>
                <hr>
                <div class="infoCriadores">
                    <img src="image/heitor.jpeg">
                    <div>
                        <h3>Heitor Macedo Brazil</h3>
                        <p>
                            <span><a href="https://www.instagram.com/heitorbrazil/"><img src="image/instagram.png"></a></span>
                            <span>heitorbrazil</span>
                        </p>
                        <p>
                            <span><img src="image/o-email.png"></span>
                            <span>heitorbrazil1000@gmail.com</span>
                        </p>
                    </div>
                </div>
            </div>

            <c:if test="${adm}" >
                <div id="croud" style="visibility: hidden; opacity: 0;">
                    <div id="pesquisar">
                        <i class="bx bx-search"></i>
                        <label for="pesquisarUser"></label>
                        <input type="text" id="pesquisarUser" onkeyup="setUsersList()" name="pesquisarUser" placeholder="<fmt:message key="search_label" />">
                    </div>
                    <a href="register.jsp"><input type="button" value=''/></a>
                </div>

                <div class="editarUser" style="visibility: hidden; opacity: 0;">
                    <div class="fecharInfoUser">
                        <i class='bx bx-x' onclick="voltarCrud()"></i>
                    </div>
                    <div class="imagemPerfil">
                        <img src="" id="img-user-display">
                        <label for="edit"></label>
                        <button class="edit-button">
                            <label for="edit">
                                <i class='bx bx-edit-alt'><input type="file" id="edit-user" name="novaFoto" style="display: none"></i>
                            </label>
                        </button>
                    </div>
                    <div id="infoConta">
                        <form action="user/edit" method="post" enctype="multipart/form-data" accept="image/*">
                            <input type="text" id="id-editarUser" name="id" hidden>
                            <input type="file" id="image-user" name="image" name="novaFoto" hidden>
                            <label for="username-editarUser"></label>
                            <input type="text" id="username-editarUser" name="username" placeholder="<fmt:message key="user_placeholder" />">
                            <label for="email-editarUser"></label>
                            <input type="email" id="email-editarUser" name="email" placeholder="<fmt:message key="mail_placeholder" />">
                            <label for="cargoUsuario"></label>
                            <select id="cargoUsuario" name="role-editarUser">
                                <option value="ADMIN"><fmt:message key="admin_role" /></option>
                                <option value="TECHNICIAN"><fmt:message key="technician_role" /></option>
                                <option value="USER"><fmt:message key="user_role" /></option>
                            </select>

                            <div class="botoes">
                                <input type="submit" id="salvar" name="salvar" value="<fmt:message key="save" />">
                                <a href="user/delete?id=''" id="a-user"><input type="button" id="excluir" name="remove" value="<fmt:message key="delete_user" />"></a>
                            </div>
                        </form>
                    </div>
                </div>
            </c:if>

            <div id="opcoesSite">
                <h3><fmt:message key="settings_tooltip" /></h3>
                <ul>
                    <li onclick="user()">
                        <i class="bx bx-user"></i>
                        <span class="links_name"><fmt:message key="user_tooltip" /></span>
                    </li>
                    <li onclick="customize()">
                        <i class='bx bx-customize'></i>
                        <span class="links_name"><fmt:message key="customize_settings" /></span>
                    </li>
                    <li onclick="creators()">
                        <i class='bx bx-group'></i>
                        <span class="links_name"><fmt:message key="creators_settings" /></span>
                    </li>
                    <c:if test="${adm}" >
                        <li id="final" onclick="croud(); setUsersList();">
                            <i class='bx bxs-contact'></i>
                            <span class="links_name"><fmt:message key="crud_settings" /></span>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>

        <div id="bg-change-pass" style="display: none;">
            <div id="area-change-pass">
                <div id="modal-change-pass">
                    <a onclick="closeChangePass()" class="close"></a>
                    <h2><fmt:message key="change_password" /></h2>
                    <input type="password" id="input-change-pass" placeholder="<fmt:message key="old_password" />">
                    <div id="button-space">
                        <button onclick="verify()"><fmt:message key="submit_button" /></button>
                    </div>
                </div>
            </div>
        </div>

    </main>

    <script src="js/high_contrast.js"></script>

    <script>
        let change_pass = document.getElementById("bg-change-pass");

        function openChangePass() {
            change_pass.style.display = "block";
        }
        function closeChangePass() {
            change_pass.style.display = "none";
        }

        if (localStorage.getItem('high-contrast') == 'true') {
            document.getElementById("onoff1").checked = true
        }
    </script>

    <script src="js/settings.js"></script>

    <script>
        document.getElementById('edit').onchange = function (evt) {
            var tgt = evt.target || window.event.srcElement,
                files = tgt.files;
            
            if (FileReader && files && files.length) {
                var fr = new FileReader();
                fr.onload = function () {
                    document.getElementById('imgUserSubmit').src = fr.result;
                }
                fr.readAsDataURL(files[0]);
            }

            document.getElementById('hidden-image').files = document.getElementById('edit').files;
        }

        document.getElementById('edit-user').onchange = function (evt) {
            var tgt = evt.target || window.event.srcElement,
                files = tgt.files;
            
            if (FileReader && files && files.length) {
                var fr = new FileReader();
                fr.onload = function () {
                    document.getElementById('image-user').src = fr.result;
                }
                fr.readAsDataURL(files[0]);
            }

            document.getElementById('image-user').files = document.getElementById('edit-user').files;
        }
    </script>

    <c:if test="${!tech}" >
        <c:import url="newTicket.jsp" />
    </c:if>
</body>
<p id="change-pass-msg" style="display: none;"><fmt:message key="error_detail_user" /></p>

<p id="change-pass" style="display: none;"><fmt:message key="change_password" /></p>
<p id="new-pass" style="display: none;"><fmt:message key="new_password" /></p>
<p id="confirm-pass" style="display: none;"><fmt:message key="confirm_password" /></p>
<p id="submit-pass" style="display: none;"><fmt:message key="submit_button" /></p>
<p id="search-msg" style="display: none;"><fmt:message key="search_label" /></p>
<p id="create-user" style="display: none;"><fmt:message key="create_user" /></p>
<script>
    function lang() {
        let linguagens = document.getElementById("linguagens");

        window.location.href = "lang.jsp?idioma=" + linguagens.value;
    }
</script>
<c:if test="${adm}" >
    <script src="js/users_search.js"></script>
</c:if>
<script src="js/change_pass.js"></script>
</html>