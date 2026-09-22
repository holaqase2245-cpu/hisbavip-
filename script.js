let currentGameType = "ورق";
let rounds = 5;
let players = [
let players = [
  {name:"", score:0},
  {name:"", score:0},
  {name:"", score:0},
  {name:"", score:0}
];

let currentRound = 1;
let history = JSON.parse(localStorage.getItem("hisbaHistory") || "[]");

const clickAudio = new Audio();
const winAudio = new Audio();

function clickSound(){
  try{
    const ctx = new (window.AudioContext || window.webkitAudioContext)();
    const osc = ctx.createOscillator();
    const gain = ctx.createGain();

    osc.frequency.value = 650;
    gain.gain.setValueAtTime(0.035,ctx.currentTime);
    gain.gain.exponentialRampToValueAtTime(
      0.001,
      ctx.currentTime + 0.08
    );

    osc.connect(gain);
    gain.connect(ctx.destination);
    osc.start();
    osc.stop(ctx.currentTime + 0.08);
  }catch(e){}
}

document.addEventListener("click",e=>{
  if(e.target.tagName === "BUTTON"){
    clickSound();
  }
});

function showScreen(id){
  document.querySelectorAll(".screen").forEach(s=>{
    s.classList.remove("active");
  });

  document.getElementById(id).classList.add("active");
  window.scrollTo(0,0);
}

function newGame(type){
  currentGameType = type;
  players = [
    {name:"حازم",score:0},
    {name:"أحمد",score:0},
    {name:"علي",score:0},
    {name:"سجاد",score:0}
  ];

  currentRound = 1;
  renderPlayers();
  showScreen("setup");
}

function selectGame(type){
  currentGameType = type;

  document.getElementById("paperBtn")
    .classList.toggle("active",type==="ورق");

  document.getElementById("dominoBtn")
    .classList.toggle("active",type==="دومينو");
}

function setRounds(number){
  rounds = number;

  document.querySelectorAll(".rounds button")
    .forEach(b=>b.classList.remove("active"));

  event.target.classList.add("active");
}

function renderPlayers(){
  const box = document.getElementById("players");

  box.innerHTML = players.map((p,i)=>`
    <div class="player-row">
      <span class="player-number">${i+1}</span>
      <input
        value="${p.name}"
        onchange="players[${i}].name=this.value"
        placeholder="اسم اللاعب"
      >
      <button class="remove" onclick="removePlayer(${i})">×</button>
    </div>
  `).join("");
}

function addPlayer(){
  if(players.length >= 6){
    alert("الحد الأقصى 6 لاعبين");
    return;
  }

  players.push({
    name:"لاعب "+(players.length+1),
    score:0
  });

  renderPlayers();
}

function removePlayer(index){
  if(players.length <= 2){
    alert("يجب أن يبقى لاعبان على الأقل");
    return;
  }

  players.splice(index,1);
  renderPlayers();
}

function startGame(){
  players.forEach(p=>p.score=0);
  currentRound=1;
  renderScorePlayers();
  showScreen("game");
}

function renderScorePlayers(){
  document.getElementById("roundNumber").textContent =
    `${currentRound} / ${rounds}`;

  document.getElementById("roundTitle").textContent =
    `الجولة ${currentRound}`;

  document.getElementById("scorePlayers").innerHTML =
    players.map((p,i)=>`
      <div class="score-row">
        <span class="score-name">${p.name}</span>
        <span>${p.score}</span>
        <input
          class="score-input"
          id="score${i}"
          type="number"
          value="0"
        >
      </div>
    `).join("");
}

function saveRound(){
  players.forEach((p,i)=>{
    const value =
      Number(document.getElementById("score"+i).value) || 0;

    p.score += value;
  });

  if(currentRound >= rounds){
    finishGame();
  }else{
    currentRound++;
    renderScorePlayers();
  }
}

function resetRound(){
  document.querySelectorAll(".score-input")
    .forEach(input=>input.value=0);
}

function finishGame(){

  let winner = players.reduce((a,b)=>
    b.score > a.score ? b : a
  );

  document.getElementById("winnerName").textContent =
    winner.name;

  document.getElementById("winnerScore").textContent =
    winner.score;

  document.getElementById("finalScores").innerHTML =
    players.map(p=>`
      <div class="score-row">
        <span class="score-name">${p.name}</span>
        <strong>${p.score}</strong>
      </div>
    `).join("");

  history.unshift({
    type:currentGameType,
    date:new Date().toLocaleString("ar-IQ"),
    players:players.map(p=>({...p}))
  });

  localStorage.setItem(
    "hisbaHistory",
    JSON.stringify(history)
  );

  showScreen("summary");
  fireworks();
  victorySound();
}

function showHistory(){
  renderHistory();
  showScreen("history");
}

function renderHistory(){

  const box=document.getElementById("historyList");

  if(history.length===0){
    box.innerHTML=
      `<p style="text-align:center;color:#77848f">
        لا توجد ألعاب سابقة
      </p>`;
    return;
  }

  box.innerHTML=history.map(game=>`
    <div class="history-item">
      <span style="font-size:30px">
        ${game.type==="ورق"?"🂡":"🎲"}
      </span>

      <div>
        <b>${game.type}</b>
        <small style="display:block;color:#7d8b96">
          ${game.players.length} لاعبين
        </small>
        <small style="color:#687781">
          ${game.date}
        </small>
      </div>
    </div>
  `).join("");
}

function deleteHistory(){
  if(confirm("حذف جميع الألعاب السابقة؟")){
    history=[];
    localStorage.removeItem("hisbaHistory");
    renderHistory();
  }
}

function victorySound(){
  try{
    const ctx=new (window.AudioContext||
      window.webkitAudioContext)();

    [523,659,784,1046].forEach((freq,i)=>{
      const osc=ctx.createOscillator();
      const gain=ctx.createGain();

      osc.frequency.value=freq;

      gain.gain.setValueAtTime(
        0.001,
        ctx.currentTime+i*0.18
      );

      gain.gain.exponentialRampToValueAtTime(
        0.08,
        ctx.currentTime+i*0.18+0.04
      );

      gain.gain.exponentialRampToValueAtTime(
        0.001,
        ctx.currentTime+i*0.18+0.45
      );

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(ctx.currentTime+i*0.18);
      osc.stop(ctx.currentTime+i*0.18+0.5);
    });
  }catch(e){}
}

function fireworks(){

  const canvas=document.getElementById("fireworksCanvas");
  const ctx=canvas.getContext("2d");

  canvas.width=innerWidth;
  canvas.height=innerHeight;

  let particles=[];

  for(let i=0;i<180;i++){

    const angle=Math.random()*Math.PI*2;
    const speed=Math.random()*7+2;

    particles.push({
      x:innerWidth/2,
      y:innerHeight/3,
      vx:Math.cos(angle)*speed,
      vy:Math.sin(angle)*speed,
      life:100,
      size:Math.random()*3+1
    });
  }

  function animate(){

    ctx.clearRect(0,0,canvas.width,canvas.height);

    particles.forEach(p=>{

      p.x+=p.vx;
      p.y+=p.vy;
      p.vy+=0.08;
      p.life--;

      ctx.globalAlpha=p.life/100;
      ctx.fillStyle=
        `hsl(${Math.random()*50+25},100%,60%)`;

      ctx.beginPath();
      ctx.arc(p.x,p.y,p.size,0,Math.PI*2);
      ctx.fill();
    });

    if(particles.some(p=>p.life>0)){
      requestAnimationFrame(animate);
    }else{
      ctx.clearRect(0,0,canvas.width,canvas.height);
    }
  }

  animate();
}

renderPlayers();
