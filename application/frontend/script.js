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
        
        if (previousInput !== '') {
            calculateResult();
        }
        
        operation = op;
        previousInput = currentInput;
        shouldResetScreen = true;
    }

    function calculateResult() {
        if (previousInput === '' || operation === null || shouldResetScreen) return;
        
        let computation;
        const prev = parseFloat(previousInput);
        const current = parseFloat(currentInput);
        
        if (isNaN(prev) || isNaN(current)) return;
        
        switch (operation) {
            case '+':
                computation = prev + current;
                break;
            case '-':
                computation = prev - current;
                break;
            case '*':
                computation = prev * current;
                break;
            case '/':
                if (current === 0) {
                    currentInput = 'Error';
                    updateDisplay();
                    setTimeout(clearDisplay, 1500);
                    return;
                }
                computation = prev / current;
                break;
            default:
                return;
        }
        
        currentInput = computation.toString();
        operation = null;
        previousInput = '';
        shouldResetScreen = true;
        updateDisplay();
    }

    function clearDisplay() {
        currentInput = '0';
        previousInput = '';
        operation = null;
        updateDisplay();
    }

    // Add event listeners to all buttons
    document.querySelectorAll('button').forEach(button => {
        button.addEventListener('click', function() {
            if (this.hasAttribute('data-number')) {
                appendNumber(this.getAttribute('data-number'));
            } else if (this.hasAttribute('data-operation')) {
                setOperation(this.getAttribute('data-operation'));
            } else if (this.getAttribute('data-action') === 'equals') {
                calculateResult();
            } else if (this.getAttribute('data-action') === 'clear') {
                clearDisplay();
            }
        });
    });

    // Keyboard support
    document.addEventListener('keydown', (event) => {
        if (event.key >= '0' && event.key <= '9') {
            appendNumber(event.key);
        } else if (event.key === '.') {
            appendNumber('.');
        } else if (event.key === '+' || event.key === '-' || event.key === '*' || event.key === '/') {
            setOperation(event.key);
        } else if (event.key === 'Enter' || event.key === '=') {
            event.preventDefault();
            calculateResult();
        } else if (event.key === 'Escape' || event.key === 'Delete') {
            clearDisplay();
        } else if (event.key === 'Backspace') {
            if (currentInput.length > 1 && currentInput !== '0') {
                currentInput = currentInput.slice(0, -1);
            } else {
                currentInput = '0';
            }
            updateDisplay();
        }
    });

    updateDisplay();
});