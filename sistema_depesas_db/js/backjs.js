document.addEventListener('DOMContentLoaded', function() {
    const despesasList = document.getElementById('despesas-list');
    const addDespesaForm = document.getElementById('add-despesa-form');

    // Função para carregar despesas do backend e exibi-las na UI
    function carregarDespesas() {
        // Aqui é feito uma requisição GET para o backend para obter as despesas do banco de dados
        // O backend retorna uma lista de despesas no formato JSON
        const despesas = [
            { id: 1, descricao: 'Restaurante', valor: 50.00, categoria: 'Alimentação', data: '2024-02-27' },
            { id: 2, descricao: 'Gasolina', valor: 80.00, categoria: 'Transporte', data: '2024-02-26' }
            // Adicione mais despesas conforme necessário
        ];

        // Limpa a lista de despesas antes de adicionar novas
        despesasList.innerHTML = '';

        // Adiciona cada despesa à lista
        despesas.forEach(despesa => {
            const despesaItem = document.createElement('div');
            despesaItem.classList.add('despesa-item');
            despesaItem.innerHTML = `
                <strong>${despesa.descricao}</strong> - ${despesa.valor} - ${despesa.categoria} - ${despesa.data}
            `;
            despesasList.appendChild(despesaItem);
        });
    }

    // Função para adicionar uma nova despesa
    addDespesaForm.addEventListener('submit', function(event) {
        event.preventDefault();

        const descricao = document.getElementById('descricao').value;
        const valor = document.getElementById('valor').value;
        const categoria = document.getElementById('categoria').value;
        const data = document.getElementById('data').value;

        // Aqui é realizada uma requisição POST para o backend para adicionar a nova despesa ao banco de dados
        // Após adicionar com sucesso, é possivel chamar a função carregarDespesas() para atualizar a lista na UI
        console.log('Nova despesa adicionada:', { descricao, valor, categoria, data });
    });

    // Carrega as despesas ao carregar a página
    carregarDespesas();
});

document.addEventListener('DOMContentLoaded', function() {
    const addDespesaForm = document.getElementById('add-despesa-form');

    addDespesaForm.addEventListener('submit', function(event) {
        event.preventDefault();

        const descricao = document.getElementById('descricao').value;
        const valor = document.getElementById('valor').value;
        const categoria = document.getElementById('categoria').value;
        const data = document.getElementById('data').value;

        fetch('/api/despesas', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                descricao,
                valor,
                categoria,
                data
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log('Despesa adicionada com sucesso:', data);
            // Atualizar a interface para exibir a nova despesa 
        })
        .catch(error => console.error('Erro ao adicionar despesa:', error));
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const despesasList = document.getElementById('despesas-list');

    // Função para carregar despesas do backend e exibi-las na UI
    function carregarDespesas() {
        fetch('/api/despesas')
        .then(response => response.json())
        .then(data => {
            // Limpar a lista de despesas antes de adicionar novas
            despesasList.innerHTML = '';

            // Adicionar cada despesa à lista
            data.forEach(despesa => {
                const despesaItem = document.createElement('div');
                despesaItem.classList.add('despesa-item');
                despesaItem.innerHTML = `
                    <strong>${despesa.descricao}</strong> - ${despesa.valor} - ${despesa.categoria} - ${despesa.data}
                `;
                despesasList.appendChild(despesaItem);
            });
        })
        .catch(error => console.error('Erro ao carregar despesas:', error));
    }

    // Carregar as despesas ao carregar a página
    carregarDespesas();
});
