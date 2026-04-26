<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Matemática 6º Ano - Jogo SAEB</title>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .main-layout {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 20px;
            max-width: 1400px;
            margin: 0 auto;
            flex-wrap: wrap;
        }
        
        /* ANÚNCIOS */
        .ads-container {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .ad-side {
            flex: 0 0 160px;
            background: rgba(0,0,0,0.2);
            border-radius: 20px;
            backdrop-filter: blur(10px);
            padding: 15px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .ad-card {
            background: white;
            border-radius: 15px;
            padding: 10px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .ad-card:hover { transform: scale(1.02); }
        .ad-card img { width: 100%; max-height: 150px; object-fit: cover; border-radius: 10px; }
        .ad-card-title { font-weight: bold; color: #2c3e50; margin-top: 8px; font-size: 0.8rem; }
        
        .ad-top, .ad-bottom { width: 100%; max-width: 500px; margin: 0 auto; display: none; }
        .ad-banner { background: rgba(255,255,255,0.95); border-radius: 15px; padding: 10px; margin-bottom: 15px; text-align: center; cursor: pointer; }
        .ad-banner img { max-width: 100%; height: 60px; object-fit: contain; border-radius: 8px; }
        
        /* JOGO */
        .game-container {
            flex: 1;
            min-width: 300px;
            max-width: 500px;
        }
        
        .game-card {
            background: white;
            border-radius: 30px;
            padding: 25px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
        }
        
        .game-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .level-badge, .score-badge, .streak-badge {
            padding: 8px 15px;
            border-radius: 25px;
            font-weight: bold;
        }
        .level-badge { background: #2c3e50; color: white; }
        .score-badge { background: #f1c40f; color: #333; }
        .streak-badge { background: #e74c3c; color: white; }
        
        .progress-container { margin-bottom: 20px; }
        .progress-bar { width: 100%; height: 10px; background: #eee; border-radius: 10px; overflow: hidden; }
        .progress-fill { height: 100%; background: #27ae60; transition: width 0.5s; }
        
        .question-area {
            background: #f8f9fa;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
        }
        
        .question-text {
            font-size: 1.2rem;
            color: #333;
            line-height: 1.4;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .alternatives { display: flex; flex-direction: column; gap: 12px; }
        
        .alternative {
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            padding: 15px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .alternative:hover { border-color: #3498db; transform: scale(1.02); }
        
        .alternative-letter {
            width: 40px;
            height: 40px;
            background: #2c3e50;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .alternative-text { flex: 1; font-size: 1rem; color: #333; text-align: left; }
        
        .alternative.selected {
            background: #3498db;
            border-color: #3498db;
        }
        .alternative.selected .alternative-text { color: white; }
        .alternative.selected .alternative-letter { background: white; color: #3498db; }
        
        .alternative.disabled {
            opacity: 0.7;
            cursor: not-allowed;
            pointer-events: none;
        }
        
        .alternative.correct-temp {
            background: #27ae60;
            border-color: #27ae60;
        }
        .alternative.correct-temp .alternative-text { color: white; }
        .alternative.correct-temp .alternative-letter { background: white; color: #27ae60; }
        
        .alternative.wrong-temp {
            background: #e74c3c;
            border-color: #e74c3c;
        }
        .alternative.wrong-temp .alternative-text { color: white; }
        .alternative.wrong-temp .alternative-letter { background: white; color: #e74c3c; }
        
        .lives { display: flex; justify-content: center; gap: 10px; margin: 20px 0; }
        .heart { font-size: 1.8rem; transition: all 0.3s; }
        .heart.lost { opacity: 0.3; filter: grayscale(1); }
        
        .btn-next, .btn-restart {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 15px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s;
            margin-top: 10px;
        }
        .btn-next { background: #27ae60; color: white; }
        .btn-next:hover { transform: scale(0.98); }
        .btn-next:disabled { opacity: 0.5; cursor: not-allowed; }
        .btn-restart { background: #3498db; color: white; }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.8);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal-content {
            background: white;
            border-radius: 30px;
            padding: 30px;
            max-width: 400px;
            width: 90%;
            text-align: center;
        }
        
        .ranking-list { max-height: 400px; overflow-y: auto; margin: 20px 0; }
        .rank-item { display: flex; justify-content: space-between; padding: 10px; border-bottom: 1px solid #eee; }
        
        footer {
            margin-top: 20px;
            color: rgba(255,255,255,0.7);
            font-size: 0.8rem;
            cursor: pointer;
            text-align: center;
        }
        
        @media (max-width: 900px) {
            .ad-side { display: none; }
            .ad-top, .ad-bottom { display: block; }
        }
        
        @media (min-width: 901px) {
            .ad-top, .ad-bottom { display: none !important; }
        }
    </style>
</head>
<body>
    <div class="ads-container">
        <!-- ANÚNCIOS LATERAIS ESQUERDOS -->
        <div class="ad-side" id="ad-left">
            <div class="ad-card" onclick="openAdLink('side1')">
                <img id="side-ad-1-img" src="https://via.placeholder.com/160x150?text=Anuncio" alt="Anúncio">
                <div class="ad-card-title" id="side-ad-1-title">Espaço para Anúncio</div>
            </div>
            <div class="ad-card" onclick="openAdLink('side2')">
                <img id="side-ad-2-img" src="https://via.placeholder.com/160x150?text=Anuncio" alt="Anúncio">
                <div class="ad-card-title" id="side-ad-2-title">Espaço para Anúncio</div>
            </div>
        </div>
        
        <!-- JOGO PRINCIPAL -->
        <div class="game-container">
            <div class="ad-top">
                <div class="ad-banner" onclick="openAdLink('top')">
                    <img id="top-ad-img" src="https://via.placeholder.com/468x60?text=Anuncio" alt="Anúncio">
                </div>
            </div>
            
            <div class="game-card">
                <div class="game-header">
                    <div class="level-badge" id="level-display">📚 Nível 1</div>
                    <div class="score-badge" id="score-display">⭐ Pontos: 0</div>
                    <div class="streak-badge" id="streak-display">🔥 Sequência: 0</div>
                </div>
                
                <div class="progress-container">
                    <div class="progress-bar">
                        <div class="progress-fill" id="progress-fill" style="width: 0%"></div>
                    </div>
                    <div style="font-size: 0.8rem; margin-top: 5px;" id="progress-text">Questão 1 de 10</div>
                </div>
                
                <div class="lives" id="lives-container">❤️ ❤️ ❤️</div>
                
                <div class="question-area">
                    <div class="question-text" id="question-text">Carregando...</div>
                    <div class="alternatives" id="alternatives"></div>
                </div>
                
                <button class="btn-next" id="next-btn" onclick="avancarQuestao()" disabled>▶ PRÓXIMA QUESTÃO</button>
                <button class="btn-restart" onclick="restartGame()">🔄 RECOMEÇAR JOGO</button>
            </div>
            
            <div class="ad-bottom">
                <div class="ad-banner" onclick="openAdLink('bottom')">
                    <img id="bottom-ad-img" src="https://via.placeholder.com/468x60?text=Anuncio" alt="Anúncio">
                </div>
            </div>
        </div>
        
        <!-- ANÚNCIOS LATERAIS DIREITOS -->
        <div class="ad-side" id="ad-right">
            <div class="ad-card" onclick="openAdLink('side3')">
                <img id="side-ad-3-img" src="https://via.placeholder.com/160x150?text=Anuncio" alt="Anúncio">
                <div class="ad-card-title" id="side-ad-3-title">Espaço para Anúncio</div>
            </div>
            <div class="ad-card" onclick="openAdLink('side4')">
                <img id="side-ad-4-img" src="https://via.placeholder.com/160x150?text=Anuncio" alt="Anúncio">
                <div class="ad-card-title" id="side-ad-4-title">Espaço para Anúncio</div>
            </div>
        </div>
    </div>
    
    <!-- MODAIS -->
    <div id="ranking-modal" class="modal">
        <div class="modal-content">
            <h2>🏆 RANKING GERAL 🏆</h2>
            <div class="ranking-list" id="ranking-list"></div>
            <button class="btn-next" onclick="closeRanking()" style="background:#666">FECHAR</button>
        </div>
    </div>
    
    <div id="gameover-modal" class="modal">
        <div class="modal-content">
            <h2 id="gameover-title">🎉 PARABÉNS! 🎉</h2>
            <p id="gameover-text"></p>
            <p id="gameover-stats"></p>
            <button class="btn-next" onclick="restartGame()">JOGAR NOVAMENTE</button>
            <button class="btn-restart" onclick="showRanking()">🏆 VER RANKING</button>
        </div>
    </div>
    
    <footer onclick="openAdmin()">© 2026 | Clique para Configurar Anúncios</footer>

    <script>
        // ========== BANCO DE QUESTÕES (BNCC 6º ANO) ==========
        const questionsDatabase = [
            // NÍVEL 1
            { nivel: 1, texto: "Qual é o resultado de 25 + 37?", a: "52", b: "62", c: "72", d: "82", correta: "b" },
            { nivel: 1, texto: "Quanto é 8 × 7?", a: "48", b: "56", c: "64", d: "72", correta: "b" },
            { nivel: 1, texto: "O dobro de 15 é:", a: "25", b: "30", c: "35", d: "40", correta: "b" },
            { nivel: 1, texto: "3² é igual a:", a: "6", b: "8", c: "9", d: "12", correta: "c" },
            { nivel: 1, texto: "10 - 4 × 2 = ?", a: "12", b: "8", c: "2", d: "6", correta: "c" },
            { nivel: 1, texto: "A metade de 50 é:", a: "20", b: "25", c: "30", d: "35", correta: "b" },
            { nivel: 1, texto: "Qual o sucessor de 199?", a: "198", b: "200", c: "201", d: "210", correta: "b" },
            { nivel: 1, texto: "1000 ÷ 10 = ?", a: "10", b: "100", c: "1000", d: "1", correta: "b" },
            { nivel: 1, texto: "Uma dúzia equivale a:", a: "10", b: "11", c: "12", d: "13", correta: "c" },
            { nivel: 1, texto: "Qual o valor de 5 × 0?", a: "0", b: "5", c: "10", d: "1", correta: "a" },
            
            // NÍVEL 2
            { nivel: 2, texto: "144 ÷ 12 = ?", a: "10", b: "11", c: "12", d: "13", correta: "c" },
            { nivel: 2, texto: "2³ + 3² = ?", a: "13", b: "15", c: "17", d: "19", correta: "c" },
            { nivel: 2, texto: "Raiz quadrada de 64 é:", a: "6", b: "7", c: "8", d: "9", correta: "c" },
            { nivel: 2, texto: "35% de 200 = ?", a: "50", b: "60", c: "70", d: "80", correta: "c" },
            { nivel: 2, texto: "MMC de 4 e 6 é:", a: "8", b: "10", c: "12", d: "14", correta: "c" },
            { nivel: 2, texto: "Área do quadrado de lado 7cm:", a: "28cm²", b: "42cm²", c: "49cm²", d: "56cm²", correta: "c" },
            { nivel: 2, texto: "2/5 em decimal é:", a: "0,2", b: "0,25", c: "0,4", d: "0,5", correta: "c" },
            { nivel: 2, texto: "50 + 30 × 2 = ?", a: "110", b: "130", c: "160", d: "100", correta: "a" },
            { nivel: 2, texto: "0,5 em fração é:", a: "1/3", b: "1/2", c: "2/3", d: "3/4", correta: "b" },
            { nivel: 2, texto: "Uma dúzia e meia:", a: "12", b: "15", c: "18", d: "24", correta: "c" },
            
            // NÍVEL 3
            { nivel: 3, texto: "3 × (4 + 7) - 2³ = ?", a: "25", b: "29", c: "33", d: "37", correta: "a" },
            { nivel: 3, texto: "x + 12 = 30 → x = ?", a: "12", b: "15", c: "18", d: "20", correta: "c" },
            { nivel: 3, texto: "0,75 em fração:", a: "3/4", b: "2/3", c: "1/2", d: "4/5", correta: "a" },
            { nivel: 3, texto: "MDC de 18 e 24:", a: "3", b: "4", c: "6", d: "8", correta: "c" },
            { nivel: 3, texto: "√81 + 2² = ?", a: "11", b: "12", c: "13", d: "14", correta: "c" },
            { nivel: 3, texto: "Perímetro retângulo 5×3:", a: "15cm", b: "16cm", c: "18cm", d: "20cm", correta: "b" },
            { nivel: 3, texto: "25% de R$200:", a: "R$25", b: "R$50", c: "R$75", d: "R$100", correta: "b" },
            { nivel: 3, texto: "Ângulo reto mede:", a: "45°", b: "60°", c: "90°", d: "180°", correta: "c" },
            { nivel: 3, texto: "2³ × 2² = ?", a: "2⁵", b: "2⁶", c: "2⁴", d: "2³", correta: "a" },
            { nivel: 3, texto: "3/4 é maior que:", a: "1/2", b: "1/3", c: "1/4", d: "Todas", correta: "d" },
            
            // NÍVEL 4
            { nivel: 4, texto: "(8 + 12) ÷ 4 × 3 = ?", a: "10", b: "12", c: "15", d: "18", correta: "c" },
            { nivel: 4, texto: "4³ = ?", a: "16", b: "32", c: "64", d: "128", correta: "c" },
            { nivel: 4, texto: "15/20 em porcentagem:", a: "65%", b: "70%", c: "75%", d: "80%", correta: "c" },
            { nivel: 4, texto: "MMC de 6,8,12:", a: "12", b: "24", c: "36", d: "48", correta: "b" },
            { nivel: 4, texto: "3x = 27 → x = ?", a: "7", b: "8", c: "9", d: "10", correta: "c" },
            { nivel: 4, texto: "√121 = ?", a: "10", b: "11", c: "12", d: "13", correta: "b" },
            { nivel: 4, texto: "0,333... em fração:", a: "1/2", b: "1/3", c: "2/3", d: "3/4", correta: "b" },
            { nivel: 4, texto: "15 - 8 + 3 × 2 = ?", a: "13", b: "14", c: "15", d: "16", correta: "a" },
            { nivel: 4, texto: "Triplo de um número +5 = 20", a: "3", b: "4", c: "5", d: "6", correta: "c" },
            { nivel: 4, texto: "3/8 + 2/8 = ?", a: "5/8", b: "5/16", c: "6/8", d: "1/4", correta: "a" },
            
            // NÍVEL 5
            { nivel: 5, texto: "20 - [3 + (5 - 2)] = ?", a: "10", b: "12", c: "14", d: "16", correta: "c" },
            { nivel: 5, texto: "6² + 8² = ?", a: "64", b: "100", c: "144", d: "169", correta: "b" },
            { nivel: 5, texto: "(-3) × (-4) × (-2) = ?", a: "-24", b: "24", c: "-12", d: "12", correta: "a" },
            { nivel: 5, texto: "Média de 8,10,12,14:", a: "10", b: "11", c: "12", d: "13", correta: "b" },
            { nivel: 5, texto: "1/2 equivalente com denom.10:", a: "2/10", b: "3/10", c: "4/10", d: "5/10", correta: "d" },
        ];
        
        // Completar níveis 6 a 10
        for(let nivel = 6; nivel <= 10; nivel++) {
            for(let i = 1; i <= 10; i++) {
                questionsDatabase.push({
                    nivel: nivel,
                    texto: `Desafio ${i} do Nível ${nivel}: Qual é o resultado da operação?`,
                    a: "Alternativa A", b: "Alternativa B", c: "Alternativa C", d: "Alternativa D",
                    correta: ["a","b","c","d"][Math.floor(Math.random() * 4)]
                });
            }
        }
        
        // ========== VARIÁVEIS DO JOGO ==========
        let currentLevel = 1;
        let currentQuestions = [];
        let currentIndex = 0;
        let totalScore = 0;
        let streak = 0;
        let lives = 3;
        let selectedAlternative = null;
        let answered = false;
        let timeoutId = null;
        let playerName = "";
        let ranking = JSON.parse(localStorage.getItem('math_ranking')) || [];
        
        // ========== FUNÇÕES DO JOGO ==========
        function initGame() {
            playerName = prompt("Digite seu nome para começar:") || "Jogador";
            if(playerName.trim() === "") playerName = "Jogador";
            loadLevel(1);
        }
        
        function loadLevel(level) {
            currentLevel = level;
            currentQuestions = questionsDatabase.filter(q => q.nivel === level);
            
            if(currentQuestions.length === 0) {
                for(let i = 1; i <= 10; i++) {
                    currentQuestions.push({
                        nivel: level,
                        texto: `Questão ${i} do Nível ${level}`,
                        a: "Alternativa A", b: "Alternativa B", c: "Alternativa C", d: "Alternativa D",
                        correta: ["a","b","c","d"][Math.floor(Math.random() * 4)]
                    });
                }
            }
            
            currentQuestions = currentQuestions.slice(0, 10);
            currentIndex = 0;
            lives = 3;
            streak = 0;
            selectedAlternative = null;
            answered = false;
            
            if(timeoutId) clearTimeout(timeoutId);
            
            updateUI();
            loadQuestion();
        }
        
        function loadQuestion() {
            if(currentIndex >= currentQuestions.length) {
                if(currentLevel < 10) {
                    currentLevel++;
                    loadLevel(currentLevel);
                } else {
                    completeGame();
                }
                return;
            }
            
            const q = currentQuestions[currentIndex];
            document.getElementById('question-text').innerHTML = q.texto;
            
            // Gerar alternativas
            const alternativesDiv = document.getElementById('alternatives');
            alternativesDiv.innerHTML = `
                <div class="alternative" data-letter="a">
                    <div class="alternative-letter">A</div>
                    <div class="alternative-text">${q.a}</div>
                </div>
                <div class="alternative" data-letter="b">
                    <div class="alternative-letter">B</div>
                    <div class="alternative-text">${q.b}</div>
                </div>
                <div class="alternative" data-letter="c">
                    <div class="alternative-letter">C</div>
                    <div class="alternative-text">${q.c}</div>
                </div>
                <div class="alternative" data-letter="d">
                    <div class="alternative-letter">D</div>
                    <div class="alternative-text">${q.d}</div>
                </div>
            `;
            
            // Adicionar eventos
            document.querySelectorAll('.alternative').forEach(alt => {
                alt.onclick = () => selectAlternative(alt);
            });
            
            // Resetar estado
            selectedAlternative = null;
            answered = false;
            
            // Habilitar alternativas
            document.querySelectorAll('.alternative').forEach(alt => {
                alt.classList.remove('disabled', 'selected', 'correct-temp', 'wrong-temp');
            });
            
            // Desabilitar botão próximo
            const nextBtn = document.getElementById('next-btn');
            nextBtn.disabled = true;
            nextBtn.innerHTML = '▶ PRÓXIMA QUESTÃO';
            
            // Atualizar progresso
            const progress = (currentIndex / currentQuestions.length) * 100;
            document.getElementById('progress-fill').style.width = progress + "%";
            document.getElementById('progress-text').innerHTML = `Questão ${currentIndex + 1} de ${currentQuestions.length}`;
        }
        
        function selectAlternative(alt) {
            if(answered) return;
            if(selectedAlternative) {
                selectedAlternative.classList.remove('selected');
            }
            selectedAlternative = alt;
            alt.classList.add('selected');
            
            const nextBtn = document.getElementById('next-btn');
            nextBtn.disabled = false;
        }
        
        // ========== FUNÇÃO AVANCAR QUESTÃO CORRIGIDA ==========
        function avancarQuestao() {
            // Verifica se já respondeu ou não tem alternativa selecionada
            if(answered) return;
            if(!selectedAlternative) {
                showFeedback("⚠️ Selecione uma alternativa antes de continuar!", "error");
                return;
            }
            
            answered = true;
            
            const q = currentQuestions[currentIndex];
            const selectedLetter = selectedAlternative.getAttribute('data-letter');
            const isCorrect = (selectedLetter === q.correta);
            const correctLetter = q.correta;
            let correctText = "";
            
            // Encontrar o texto da alternativa correta
            document.querySelectorAll('.alternative').forEach(alt => {
                if(alt.getAttribute('data-letter') === correctLetter) {
                    correctText = alt.querySelector('.alternative-text').innerHTML;
                }
            });
            
            // Mostrar feedback visual nas alternativas
            document.querySelectorAll('.alternative').forEach(alt => {
                alt.classList.add('disabled');
                if(alt.getAttribute('data-letter') === correctLetter) {
                    alt.classList.add('correct-temp');
                }
                if(alt === selectedAlternative && !isCorrect) {
                    alt.classList.add('wrong-temp');
                }
                if(alt === selectedAlternative && isCorrect) {
                    alt.classList.add('correct-temp');
                }
            });
            
            // Processar acerto/erro
            if(isCorrect) {
                streak++;
                const points = 10 + (streak * 2);
                totalScore += points;
                canvasConfetti({ particleCount: 50, spread: 60, origin: { y: 0.6 } });
                showFeedback(`✅ CORRETO! +${points} pontos!`, "success");
            } else {
                streak = 0;
                lives--;
                updateLives();
                showFeedback(`❌ ERRADO! A resposta correta é: ${correctLetter.toUpperCase()}) ${correctText}`, "error");
                
                if(lives <= 0) {
                    timeoutId = setTimeout(() => gameOver(), 3000);
                    return;
                }
            }
            
            updateUI();
            saveProgress();
            
            // Aguarda 3 segundos e AVANÇA para a próxima questão
            timeoutId = setTimeout(() => {
                // Remove classes temporárias
                document.querySelectorAll('.alternative').forEach(alt => {
                    alt.classList.remove('correct-temp', 'wrong-temp');
                });
                
                // AVANÇA PARA A PRÓXIMA QUESTÃO
                currentIndex++;
                answered = false;
                selectedAlternative = null;
                loadQuestion();
                timeoutId = null;
            }, 3000);
        }
        
        function updateUI() {
            document.getElementById('level-display').innerHTML = `📚 Nível ${currentLevel}`;
            document.getElementById('score-display').innerHTML = `⭐ Pontos: ${totalScore}`;
            document.getElementById('streak-display').innerHTML = `🔥 Sequência: ${streak}`;
            updateLives();
        }
        
        function updateLives() {
            const livesContainer = document.getElementById('lives-container');
            let hearts = '';
            for(let i = 0; i < 3; i++) {
                hearts += `<span class="heart ${i >= lives ? 'lost' : ''}">${i < lives ? '❤️' : '🖤'}</span>`;
            }
            livesContainer.innerHTML = hearts;
        }
        
        function showFeedback(message, type) {
            const feedback = document.createElement('div');
            feedback.style.position = 'fixed';
            feedback.style.top = '80px';
            feedback.style.left = '50%';
            feedback.style.transform = 'translateX(-50%)';
            feedback.style.backgroundColor = type === 'success' ? '#27ae60' : type === 'error' ? '#e74c3c' : '#3498db';
            feedback.style.color = 'white';
            feedback.style.padding = '15px 25px';
            feedback.style.borderRadius = '25px';
            feedback.style.zIndex = '2000';
            feedback.style.fontWeight = 'bold';
            feedback.style.fontSize = '1rem';
            feedback.style.boxShadow = '0 4px 15px rgba(0,0,0,0.2)';
            feedback.innerHTML = message;
            document.body.appendChild(feedback);
            setTimeout(() => feedback.remove(), 2800);
        }
        
        function saveProgress() {
            localStorage.setItem(`math_progress_${playerName}`, JSON.stringify({
                name: playerName,
                level: currentLevel,
                score: totalScore,
                date: new Date().toISOString()
            }));
        }
        
        function saveRanking() {
            ranking.push({
                name: playerName,
                score: totalScore,
                maxLevel: currentLevel,
                date: new Date().toISOString()
            });
            ranking.sort((a,b) => b.score - a.score);
            ranking = ranking.slice(0, 20);
            localStorage.setItem('math_ranking', JSON.stringify(ranking));
        }
        
        function gameOver() {
            if(timeoutId) clearTimeout(timeoutId);
            saveRanking();
            document.getElementById('gameover-title').innerHTML = "💀 GAME OVER 💀";
            document.getElementById('gameover-text').innerHTML = `Você não passou do Nível ${currentLevel}!`;
            document.getElementById('gameover-stats').innerHTML = `Pontuação final: ${totalScore} pontos`;
            document.getElementById('gameover-modal').style.display = 'flex';
        }
        
        function completeGame() {
            saveRanking();
            document.getElementById('gameover-title').innerHTML = "🎉 PARABÉNS! 🎉";
            document.getElementById('gameover-text').innerHTML = "Você completou todos os 10 níveis!";
            document.getElementById('gameover-stats').innerHTML = `Pontuação final: ${totalScore} pontos<br>🏆 Mestre da Matemática! 🏆`;
            canvasConfetti({ particleCount: 500, spread: 150, origin: { y: 0.5 } });
            document.getElementById('gameover-modal').style.display = 'flex';
        }
        
        function restartGame() {
            if(timeoutId) clearTimeout(timeoutId);
            currentLevel = 1;
            totalScore = 0;
            streak = 0;
            document.getElementById('gameover-modal').style.display = 'none';
            loadLevel(1);
        }
        
        function showRanking() {
            const rankingList = document.getElementById('ranking-list');
            if(ranking.length === 0) {
                rankingList.innerHTML = '<div class="rank-item">Nenhum jogador ainda</div>';
            } else {
                rankingList.innerHTML = ranking.map((r, idx) => `
                    <div class="rank-item">
                        <span>${idx+1}º ${r.name}</span>
                        <span>${r.score} pts</span>
                        <span>Nv ${r.maxLevel}</span>
                    </div>
                `).join('');
            }
            document.getElementById('ranking-modal').style.display = 'flex';
        }
        
        function closeRanking() {
            document.getElementById('ranking-modal').style.display = 'none';
        }
        
        // ========== ANÚNCIOS ==========
        function openAdLink(position) {
            const adLinks = JSON.parse(localStorage.getItem('ad_links')) || {};
            const link = adLinks[position] || "#";
            if(link !== "#") window.open(link, '_blank');
        }
        
        function loadAds() {
            const ads = JSON.parse(localStorage.getItem('ads_config')) || {};
            const positions = ['side1', 'side2', 'side3', 'side4', 'top', 'bottom'];
            positions.forEach(pos => {
                const ad = ads[pos] || {};
                if(pos.includes('side')) {
                    const num = pos.replace('side', '');
                    const imgEl = document.getElementById(`side-ad-${num}-img`);
                    const titleEl = document.getElementById(`side-ad-${num}-title`);
                    if(imgEl) imgEl.src = ad.img || `https://via.placeholder.com/160x150?text=Anuncio`;
                    if(titleEl) titleEl.innerHTML = ad.title || `Espaço para Anúncio`;
                } else if(pos === 'top') {
                    const imgEl = document.getElementById('top-ad-img');
                    if(imgEl) imgEl.src = ad.img || "https://via.placeholder.com/468x60?text=Anuncio";
                } else if(pos === 'bottom') {
                    const imgEl = document.getElementById('bottom-ad-img');
                    if(imgEl) imgEl.src = ad.img || "https://via.placeholder.com/468x60?text=Anuncio";
                }
            });
        }
        
        function openAdmin() {
            const senha = prompt("Senha do administrador:");
            if(senha === "Admin2024") {
                const posicao = prompt("Configurar anúncio:\n1 - Lateral Esquerda 1\n2 - Lateral Esquerda 2\n3 - Topo\n4 - Rodapé\n5 - Lateral Direita 1\n6 - Lateral Direita 2\n\nDigite o número:");
                const positions = {1:'side1',2:'side2',3:'top',4:'bottom',5:'side3',6:'side4'};
                const position = positions[posicao];
                if(position) {
                    const imgUrl = prompt("URL da imagem:");
                    const linkUrl = prompt("URL de destino:");
                    const title = prompt("Título do anúncio:");
                    const ads = JSON.parse(localStorage.getItem('ads_config')) || {};
                    ads[position] = { img: imgUrl, link: linkUrl, title: title };
                    localStorage.setItem('ads_config', JSON.stringify(ads));
                    const adLinks = JSON.parse(localStorage.getItem('ad_links')) || {};
                    adLinks[position] = linkUrl;
                    localStorage.setItem('ad_links', JSON.stringify(adLinks));
                    alert("Anúncio salvo! Recarregue a página.");
                    location.reload();
                }
            }
        }
        
        // ========== INICIALIZAR ==========
        window.onload = () => {
            loadAds();
            initGame();
        };
    </script>
</body>
</html>
