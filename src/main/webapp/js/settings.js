const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);

if (urlParams.get('user') != null) {
    user();
}

function user(){
    let user = document.querySelector("div#painelUser")
    let customize = document.querySelector("div#customize")
    let croud = document.querySelector("div#croud")
    let creators = document.querySelector("div#creators")
    let editarUser = document.querySelector("#editarUser")

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
    let editarUser = document.querySelector("#editarUser")

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
    let editarUser = document.querySelector("#editarUser")

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
    let format = document.querySelector("div#format")
    let creators = document.querySelector("div#creators")
    let croud = document.querySelector("div#croud")
    let editarUser = document.querySelector("#editarUser")

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

function infoUsuarios(){
    let croud = document.querySelector("div#croud")
    let editarUser = document.querySelector("#editarUser")

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
    let editarUser = document.querySelector("#editarUser")

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

//Para aparecer o input de customizar a data
const selectElement = document.getElementById('formData'); 
let customizarData = document.querySelector("div#customizarData");

selectElement.addEventListener('change', function () {
    const selectedOption = selectElement.value; 
    console.log('Opção selecionada:', selectedOption);
    executarAcao(selectedOption);
});

function executarAcao(opcao) {
    if (opcao === "op4") { 
        customizarData.style.visibility = "visible";
        customizarData.style.opacity = "1";
    } else {
        customizarData.style.visibility = "hidden"; 
        customizarData.style.opacity = "0";
    }
}   