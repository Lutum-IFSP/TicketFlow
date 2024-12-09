function verify() {
    let input = document.getElementById("input-change-pass");
    let url = `user/verify?old-password="${input.value}"`;

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Requisição errada');
            }
            return response.json();
        })
        .then(data => {
            if (data.verified) {
                let modal = document.getElementById('modal-change-pass');

                modal.innerHTML = `
                    <a onclick="closeChangePass()" class="close"></a>
                    <h2>${document.getElementById("change-pass").innerText}</h2>
                    <form method="post" action="user/changepassword">
                        <input type="password" id="senha" name="password" placeholder="${document.getElementById("new-pass").innerText}">
                        <input type="password" id="confirmarSenha" placeholder="${document.getElementById("confirm-pass").innerText}">
                        <div id="button-space">
                            <button type="submit" onclick="validarSenha()">${document.getElementById("submit-pass").innerText}</button>
                        </div>
                    </form>
                `;
            } else {
                input.setCustomValidity(document.getElementById("change-pass-msg").innerText);
                input.reportValidity();
            }
        })
        .catch(error => {
            console.error("Erro: ", error);
        });
}

function validarSenha() {
    let senha = document.getElementById('senha');
    let senhaC = document.getElementById('confirmarSenha');

    if (senha.value != senhaC.value) {
        senhaC.setCustomValidity(different.innerText);
        senhaC.reportValidity();
        return false;
    } else {
        senhaC.setCustomValidity("");
        return true;
    }
}