// app.js
const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();

const app = express();
const PORT = process.env.PORT || 3000;

// Configurando o middleware bodyParser para interpretar corpos de requisição JSON
app.use(bodyParser.json());

// Conectando ao banco de dados SQLite
const db = new sqlite3.Database(':memory:');

// Criando a tabela de despesas
db.serialize(() => {
    db.run(`CREATE TABLE IF NOT EXISTS despesas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao TEXT,
        valor REAL,
        categoria TEXT,
        data DATE
    )`);
});

// Rota para obter todas as despesas
app.get('/api/despesas', (req, res) => {
    db.all('SELECT * FROM despesas', (err, rows) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json(rows);
    });
});

// Rota para adicionar uma nova despesa
app.post('/api/despesas', (req, res) => {
    const { descricao, valor, categoria, data } = req.body;
    if (!descricao || !valor || !categoria || !data) {
        res.status(400).json({ error: 'Todos os campos são obrigatórios.' });
        return;
    }
    db.run('INSERT INTO despesas (descricao, valor, categoria, data) VALUES (?, ?, ?, ?)',
        [descricao, valor, categoria, data],
        function (err) {
            if (err) {
                res.status(500).json({ error: err.message });
                return;
            }
            res.json({
                id: this.lastID,
                descricao,
                valor,
                categoria,
                data
            });
        });
});

// Iniciando o servidor
app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});
