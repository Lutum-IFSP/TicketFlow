function setUsersList() {
    let list = document.getElementById("croud");
    let input = document.getElementById("pesquisarUser");    
    let url = `user/search?q="${input.value}"`;

    list.innerHTML = `
                    <div id="pesquisar">
                        <i class="bx bx-search"></i>
                        <label for="pesquisarUser"></label>
                        <input type="text" id="pesquisarUser" name="pesquisarUser" placeholder="${document.getElementById("search-msg").innerText}">
                    </div>
                    `;

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Requisição errada');
            }
            return response.json();
        })
        .then(data => {
            data.forEach(user => {
                if (user.role != "ADMIN") {
                    let string = `
                        <div class="userInfo" onclick='infoUsuarios("${user.id}", "${user.username}", "${user.email}", "${user.role}", "${user.image}")'>
                            <img src="${user.image}">
                            <h3>${user.username}</h3>
                        </div>
                    `;

                    list.innerHTML = list.innerHTML + string;
                }
            });

            list.innerHTML = list.innerHTML + `
                <a href="register.jsp"><input type="button" value='${document.getElementById("create-user").innerText}'/></a>
            `;
        })
        .catch(error => {
            console.error("Erro: ", error);
        });
}