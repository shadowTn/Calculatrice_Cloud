document.addEventListener('DOMContentLoaded', function() {
    const display = document.getElementById('display');
    let currentInput = '0';
    let previousInput = '';
    let operation = null;
    let shouldResetScreen = false;

    function updateDisplay() {
        display.value = currentInput;
    }

    function appendNumber(number) {
        if (currentInput === '0' || shouldResetScreen) {
            currentInput = number;
            shouldResetScreen = false;
        } else {
            if (number === '.' && currentInput.includes('.')) return;
            currentInput += number;
        }
        updateDisplay();
    }

    function setOperation(op) {
        if (currentInput === '') return;
        if (previousInput !== '') return;
        operation = op;
        previousInput = currentInput;
        shouldResetScreen = true;
    }

    function clearDisplay() {
        currentInput = '0';
        previousInput = '';
        operation = null;
        updateDisplay();
    }

    // ⭐Envoi au backend
    async function calculateCloudResult() {
        if (previousInput === '' || operation === null) return;
        
        let response = await fetch("/api/operation", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({"first_element": previousInput, "second_element": currentInput, "operation": operation})
        });
        let data = await response.json();
        let job_id = data.id;

        // Polling pour récupérer résultat
        let interval = setInterval(async () => {
            let res = await fetch("/api/result/" + job_id);

            if (res.status === 404) {
                currentInput = "Erreur";
                updateDisplay();
                clearInterval(interval);
                return;
            }

            let resultData = await res.json();

            if (resultData.status === "done") {
                currentInput = resultData.result.toString();
                updateDisplay();
                clearInterval(interval);
            }
        }, 1000);

        previousInput = '';
        operation = null;
        shouldResetScreen = true;
    }

    // Gestion des boutons
    document.querySelectorAll('button').forEach(button => {
        button.addEventListener('click', function() {
            if (this.hasAttribute('data-number')) {
                appendNumber(this.getAttribute('data-number'));
            } 
            else if (this.hasAttribute('data-operation')) {
                setOperation(this.getAttribute('data-operation'));
            } 
            else if (this.getAttribute('data-action') === 'equals') {
                calculateCloudResult();   // << appel cloud ici
            } 
            else if (this.getAttribute('data-action') === 'clear') {
                clearDisplay();
            }
        });
    });

    updateDisplay();
});
