from flask import Flask, render_template

# Crea la instancia de la aplicación Flask
app = Flask(__name__)

# Ruta principal "/"
@app.route('/')
def inicio():
    return render_template('index.html', mensaje="¡Hola desde Flask y Docker!")

# Ruta de ejemplo adicional
@app.route('/saludo/<nombre>')
def saludo(nombre):
    return f"<h2>Hola, {nombre}! Tu app Flask está corriendo en Docker 🐳</h2>"

# Punto de entrada de la app
if __name__ == '__main__':
    # 0.0.0.0 permite que Docker exponga la app hacia afuera del contenedor
    app.run(host='0.0.0.0', port=5000, debug=True)