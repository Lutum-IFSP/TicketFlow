let logout = document.querySelector("#log_out");
let sidebar = document.querySelector(".sidebar");
let closeBtn = document.querySelector("#btn");
let searchBtn = document.querySelector(".bx-search");
let input = document.querySelector("#bx-search-input");
let autocomplete = document.getElementById("search-autocomplete");
let list = document.getElementById("search-list");

closeBtn.addEventListener("click", () => {
    sidebar.classList.toggle("open");
    menuBtnChange(); //calling the function(optional)
});
searchBtn.addEventListener("click", () => {
    // Sidebar open when you click on the search iocn
    sidebar.classList.toggle("open");
    menuBtnChange(); //calling the function(optional)
    input.focus();
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

function autocompleteShow() {
    autocomplete.style.display = "block";
    autocomplete.style.maxHeight = "30vh";
}

function autocompleteClose() {
    setTimeout(() => {
        autocomplete.style.display = "none";
        autocomplete.style.maxHeight = "0vh";
    }, 300) 
}

function setList() {
    let url = `ticket/search?q="${input.value}"`;

    list.innerHTML = ""

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Requisição errada');
            }
            return response.json();
        })
        .then(data => {
            data.forEach(element => {
                let file = ""
                switch (element.priority) {
                    case "HIGH":
                        file = "image/tarefaUrgente.png";
                        break;
                    case "MID":
                        file = "image/tarefaMediaUrgencia.png";
                        break;
                    case "LOW":
                        file = "image/tarefaBaixaUrgencia.png";
                        break;
                    default:
                        file = "image/tarefaNClassificada.png";
                        break;
                }

                let string = `<li>
                                <a href="ticket/details?id=${element.id}">
                                    <img src="${file}" class="search-priority" alt="${element.priority}">
                                    <span>${element.title}</span>
                                </a>
                            </li>`;

                list.innerHTML = list.innerHTML + string;
            });
        })
        .catch(error => {
            console.error("Erro: ", error);
        });
}