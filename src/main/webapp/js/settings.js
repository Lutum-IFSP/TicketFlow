const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);

if (urlParams.get('user') != null) {
    user();
}
if (urlParams.get('customize') != null) {
    customize();
}

function validateUser(input) {
    let inputField = document.getElementById(input);
    let url = `user/exists?username="${input.value}"`;

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Requisição errada');
            }
            return response.json();
        })
        .then(data => {
            if (data.verified) {
                
            } else {
                input.setCustomValidity(document.getElementById("change-pass-msg").innerText);
                input.reportValidity();
            }
        })
        .catch(error => {
            console.error("Erro: ", error);
        });
}

function user(){
    let user = document.querySelector("div#painelUser")
    let customize = document.querySelector("div#customize")
    let croud = document.querySelector("div#croud")
    let creators = document.querySelector("div#creators")
    let editarUser = document.getElementsByClassName("editarUser")[0]

    if(user.style.visibility == "hidden"){
        user.style.visibility = "visible"
        user.style.opacity = "1"
        if (editarUser != null) {
            editarUser.style.visibility = "hidden"
            editarUser.style.opacity = "0"
        }
        if (croud != null) {
            croud.style.visibility = "hidden"
            croud.style.opacity = "0"
        }
        customize.style.visibility = "hidden"
        customize.style.opacity = "0"
        creators.style.visibility = "hidden"
        creators.style.opacity = "0"
    }
    else{
        user.style.visibility = "hidden"
        user.style.opacity = "0"
    }
}

function customize(){
    let user = document.querySelector("div#painelUser")
    let customize = document.querySelector("div#customize")
    let format = document.querySelector("div#format")
    let croud = document.querySelector("div#croud")
    let creators = document.querySelector("div#creators")
    let editarUser = document.getElementsByClassName("editarUser")[0]

    if(customize.style.visibility == "hidden"){
        user.style.visibility = "hidden"
        user.style.opacity = "0"
        if (editarUser != null) {
            editarUser.style.visibility = "hidden"
            editarUser.style.opacity = "0"
        }
        if (croud != null) {
            croud.style.visibility = "hidden"
            croud.style.opacity = "0"
        }
        customize.style.visibility = "visible"
        customize.style.opacity = "1"
        creators.style.visibility = "hidden"
        creators.style.opacity = "0"
    }
    else{
        customize.style.visibility = "hidden"
        customize.style.opacity = "0"
    }
}

function creators(){
    let user = document.querySelector("div#painelUser")
    let customize = document.querySelector("div#customize")
    let croud = document.querySelector("div#croud")
    let creators = document.querySelector("div#creators")
    let editarUser = document.getElementsByClassName("editarUser")[0]

    if(creators.style.visibility == "hidden"){
        user.style.visibility = "hidden"
        user.style.opacity = "0"
        if (editarUser != null) {
            editarUser.style.visibility = "hidden"
            editarUser.style.opacity = "0"
        }
        if (croud != null) {
            croud.style.visibility = "hidden"
            croud.style.opacity = "0"
        }
        customize.style.visibility = "hidden"
        customize.style.opacity = "0"
        creators.style.visibility = "visible"
        creators.style.opacity = "1"
    }
    else{
        creators.style.visibility = "hidden"
        creators.style.opacity = "0"
    }
}

function croud(){
    let user = document.querySelector("div#painelUser")
    let customize = document.querySelector("div#customize")
    let creators = document.querySelector("div#creators")
    let croud = document.querySelector("div#croud")
    let editarUser = document.getElementsByClassName("editarUser")[0]

    if(croud.style.visibility == "hidden"){
        user.style.visibility = "hidden"
        user.style.opacity = "0"
        if (editarUser != null) {
            editarUser.style.visibility = "hidden"
            editarUser.style.opacity = "0"
        }
        croud.style.visibility = "visible"
        croud.style.opacity = "1"
        customize.style.visibility = "hidden"
        customize.style.opacity = "0"
        creators.style.visibility = "hidden"
        creators.style.opacity = "0"
    }
    else{
        croud.style.visibility = "hidden"
        croud.style.opacity = "0"
    }
}

function infoUsuarios(id, username, email, role, image){
    let croud = document.querySelector("div#croud")
    let editarUser = document.getElementsByClassName("editarUser")[0]
    
    let linkId = document.getElementById("a-user");
    let idInput = document.getElementById("id-editarUser");
    let usernameInput = document.getElementById("username-editarUser");
    let emailInput = document.getElementById("email-editarUser");
    let imageInput = document.getElementById("img-user-display");
    let roleInput = document.getElementById("cargoUsuario");

    linkId.href = `user/delete?id=${id}`;
    idInput.value = id;
    usernameInput.value = username;
    emailInput.value = email;
    imageInput.src = image;
    roleInput.value = role;

    if(editarUser.style.visibility == "hidden"){
        editarUser.style.visibility = "visible"
        editarUser.style.opacity = "1"
        if (croud != null) {
            croud.style.visibility = "hidden"
            croud.style.opacity = "0"
        }
    }
    else{
        editarUser.style.visibility = "hidden"
        editarUser.style.opacity = "0"
    }
}

function voltarCrud(){
    let croud = document.querySelector("div#croud")
    let editarUser = document.getElementsByClassName("editarUser")[0]

    if(croud.style.visibility == "hidden"){
        editarUser.style.visibility = "hidden"
        editarUser.style.opacity = "0"
        croud.style.visibility = "visible"
        croud.style.opacity = "1"
    }
    else{
        croud.style.visibility = "hidden"
        croud.style.opacity = "0"
    }
}