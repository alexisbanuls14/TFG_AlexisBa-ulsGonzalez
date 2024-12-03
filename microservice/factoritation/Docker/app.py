from flask import Flask, request, jsonify
import math

app = Flask(__name__)

def factorize(n):
    """Calcula los factores primos de un número de forma ineficiente."""
    factors = []
    divisor = 2
    while n > 1:
        while n % divisor == 0:
            factors.append(divisor)
            n //= divisor
        divisor += 1
        if divisor > math.sqrt(n):  # Optimización menor
            if n > 1:
                factors.append(n)
                break
    return factors

@app.route('/factorize', methods=['GET'])
def get_factors():
    try:
        number = int(request.args.get('number', 1000000000000037))  # Número predeterminado muy grande
        if number < 2:
            return jsonify({"error": "El número debe ser mayor o igual a 2"}), 400

        factors = factorize(number)
        return jsonify({"number": number, "factors": factors})
    except ValueError:
        return jsonify({"error": "Debes proporcionar un número válido"}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
