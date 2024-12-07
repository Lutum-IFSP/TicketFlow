<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page import="model.enums.Role, model.entity.User" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TicketFlow - Configurações</title>
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
                        <p>Cargo: ${user.role}</p>
                        <label for="apelido"></label>
                        <input type="text" id="apelido" name="username" placeholder="Username" value="${user.username}">
                        <label for="emailUsuario"></label>
                        <input type="email" id="emailUsuario" name="email" placeholder="Email do usuário" value="${user.email}">

                        <div class="botoes">
                            <input type="button" id="alterarSenha" name="alterarSenha" value="Alterar Senha">
                            <input type="submit" id="salvar" name="salvar" value="Salvar alterações">
                        </div>
                    </form>
                </div>
            </div>

            <div id="customize" style="visibility: hidden; opacity: 0;">
                <div>
                    <p>Alto contraste</p>
                    <div class="onoff">
                        <input type="checkbox" class="toggle" id="onoff1" onclick="toggleContrast()">
                        <label for="onoff1"></label>
                    </div>
                </div>
                
                <div id="claroEscuro">
                    <p>Modo: </p>
                    <label for="claro">
                        <input type="radio" id="claro" name="claro_escuro">
                        <span>Claro</span>
                    </label>

                    <label for="escuro">
                        <input type="radio" id="escuro" name="claro_escuro">
                        <span>Escuro</span>
                    </label>
                </div>

                <div>
                    <label for="cor">Cor do tema</label>
                    <input type="color" id="cor" name="cor" value="#f9ff4f">
                </div>
                <hr>
                <div id="formatoData">
                    <label for="formData">Escolha o formato da data</label>
                    <select id="formData" name="formData">
                        <option value="op1">dd/mm/yy 00:00h</option>
                        <option value="op2">dd-mês-yyyy 00:00:00</option>
                        <option value="op3">dd mês yyyy 00:00:00 GST</option>
                        <option value="op4">Outro</option>
                    </select>
                    <div id="customizarData">
                        <label for="newData"></label>
                        <input type="text" id="newData" name="newData" placeholder="Customize seu formato de data">
                        <input type="button" value="FORMATAR" id="buttonF" name="buttonF">
                    </div>
                </div>
                <div id="traduzir">
                    <label for="linguagens">Linguagem</label>
                    <select id="linguagens" name="linguagens">
                        <option value="pt_BR">Português Brasil</option>
                        <option value="en_EN">Inglês</option>
                        <option value="es_ES">Espanhol</option>
                        <option value="zh_CN">Mandarim</option>
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
                        <input type="text" id="pesquisarUser" name="pesquisarUser" placeholder="Search...">
                    </div>
                    <div class="userInfo" onclick="infoUsuarios()">
                        <img src="${user.image}">
                        <h3>Nome do usuário</h3>
                    </div>
                </div>

                <div id="editarUser" style="visibility: hidden; opacity: 0;">
                    <div class="fecharInfoUser">
                        <i class='bx bx-x' onclick="voltarCrud()"></i>
                    </div>
                    <div class="imagemPerfil">
                        <img src="${user.image}">
                        <label for="edit"></label>
                        <button class="edit-button">
                            <label for="edit">
                                <i class='bx bx-edit-alt'><input type="file" id="edit" name="novaFoto" style="display: none"></i>
                            </label>
                        </button>
                    </div>
                    <div id="infoConta">
                        <p>Cargo: </p>
                        <label for="nomeUsuario"></label>
                        <input type="text" id="nomeUsuario" name="nomeUsuario" placeholder="Nome do usuário">
                        <label for="apelido"></label>
                        <input type="text" id="apelido" name="apelido" placeholder="Username">
                        <label for="emailUsuario"></label>
                        <input type="email" id="emailUsuario" name="emailUsuario" placeholder="Email do usuário">
                        <label for="cargoUsuario"></label>
                        <select id="cargoUsuario">
                            <option value="adm">Administrador</option>
                            <option value="adm">Administrador</option>
                            <option value="adm">Administrador</option>
                        </select>

                        <div class="botoes">
                            <input type="button" id="salvar" name="salvar" value="Salvar alterações">
                        </div>
                    </div>
                </div>
            </c:if>

            <div id="opcoesSite">
                <h3>Settings</h3>
                <ul>
                    <li onclick="user()">
                        <i class="bx bx-user"></i>
                        <span class="links_name">User</span>
                    </li>
                    <li onclick="customize()">
                        <i class='bx bx-customize'></i>
                        <span class="links_name">Customize</span>
                    </li>
                    <li onclick="creators()">
                        <i class='bx bx-group'></i>
                        <span class="links_name">Creators</span>
                    </li>
                    <c:if test="${adm}" >
                        <li id="final" onclick="croud()">
                            <i class='bx bxs-contact'></i>
                            <span class="links_name">CRUD</span>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>

    </main>

    <script src="js/high_contrast.js"></script>

    <script>
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
    </script>

    <c:if test="${!tech}" >
        <c:import url="newTicket.jsp" />
    </c:if>
</body>
</html>