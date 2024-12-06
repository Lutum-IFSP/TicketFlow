initializeContrast();
verifyContrast();

function initializeContrast() {
    if (localStorage.getItem('high-contrast') == undefined) {
        localStorage.setItem('high-contrast', 'false')
    }
}

function verifyContrast() {
    if (localStorage.getItem('high-contrast') == 'true') {
        enableContrast()
    }
}

function toggleContrast() {

    if (localStorage.getItem('high-contrast') == 'true') {
        localStorage.setItem('high-contrast', 'false')
    } else {
        localStorage.setItem('high-contrast', 'true')
    }

    enableContrast()

}

function enableContrast() {
    const array = document.querySelectorAll('*')
    const options = document.getElementById('options-menu')

    for (let i = 0; i < array.length; i++) {

        if ( array[i].classList.contains("contrast-mode") ) {

            array[i].classList.remove("contrast-mode")
            array[i].style.backgroundImage = ''

            if (array[i].id == 'sec-cf06') {
                array[i].style.backgroundColor = '#fffbf0'
            } else {
                array[i].style.backgroundColor = ''
            }

            if (array[i].classList.contains('u-btn') || array[i].classList.contains('li-acervo')) {
                array[i].style.border = ''
            }

            if (array[i].id == 'options-menu') {
                options.style.backgroundColor = 'white';
            }

            if (array[i].parentElement != null) {
                if (array[i].parentElement.nodeName == 'BODY') {
                    array[i].style.border = 'none'
                }
            }

        } else {

            if (!array[i].classList.contains('creators')) {

                array[i].classList.add("contrast-mode")
                array[i].style.backgroundImage = 'none'
                array[i].style.backgroundColor = 'black'

                if (array[i].classList.contains('u-btn') || array[i].classList.contains('li-acervo') || array[i].classList.contains('li-botao')) {
                    array[i].style.border = '1px solid white'
                }

                if (array[i].id == 'options-menu') {
                    options.style.backgroundColor = 'black';
                }

                if (array[i].parentElement != null) {
                    if (array[i].parentElement.nodeName == 'BODY') {
                        array[i].style.border = '1px solid white'
                    }
                }
            }
        }

    }
}