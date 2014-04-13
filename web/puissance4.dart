import 'dart:html';
import 'dart:math' as Math;
import 'dart:async';
import 'package:browser/dart.js';
import 'package:browser/interop.js';





int width = 460;
int height = 460;

var firstRound = true;
var countW = 60;
var countR = countW/2;
var xoffset = 20, yoffset = 20;
var xpos = 0, ypos = 0;

CanvasElement canvas;
CanvasRenderingContext2D context;

var theCanvas = document.querySelector("#canvas");
var canW = document.getElementById('canvas').clientWidth;
var playerColor = '';
var player = 1;
var pos, gridpos, won;
var myGrid = new List(7);

void main()
{

  canvas = new CanvasElement();
  canvas.width = width;
  canvas.height = height;
  querySelector('#canvas').nodes.add(canvas);

  context = canvas.getContext('2d');


  for (var i = 0; i < 7; i++) {
    myGrid[i] = [0,0,0,0,0,0];
  }



  initGrid();
}

void drawCounter(MouseEvent e) {
  getColor();
  xpos = e.client.x;
  ypos = e.client.y;
  context.stroke();
  context.fillStyle = "rgba(0,0,0,1)";

  if (xpos > xoffset + countR + 10 && xpos < (countR + countW * 7) - (xoffset))
  {
    clear();
    context.fillStyle = playerColor;
    context.beginPath();
    context.arc(xpos - 10, (countR) + yoffset, countR - 7, 0, Math.PI * 2, true);
    context.closePath();
    context.fill();
    context.stroke();

    context.beginPath();
    context.arc(xpos - 10, (countR) + yoffset, countR - 20, 0, Math.PI * 2, true);
    context.closePath();
    context.fill();
    context.stroke();
  }
}

void getColor(){
  player == 1 ? playerColor = '#fff200':playerColor = '#ed1c24';
}

void clear() {
  context.clearRect(0, yoffset, canW, countW);
}

void checkGrid() {
  //if all grid full and no match then draw!
  var temp = '';
  for(var i = 0; i <= 6; i++) //check vertical counters
  {
    temp = myGrid[i].join();
    if (temp.lastIndexOf(player.toString() + player.toString() + player.toString() + player.toString()) > 0)
      won = true;
  }

  temp = '';

  for (var j = 0 ; j < 6; j++) //check horizontal counters
    for (var i = 0; i < 7; i++)
    {
      if ((i % 7) == 0) temp += '\r\n';
      temp += myGrid[i][j].toString();
    }
  if (temp.lastIndexOf(player.toString() + player.toString() + player.toString() + player.toString()) > - 1)
    won = true;

  temp = '';


  for (var i = 1; i <= 4; i++) //check diagonal counters
    temp += myGrid[i - 1][i + 1].toString();

  temp += '\r\n';

  for (var i = 1; i <= 4; i++)
    temp += myGrid[i + 2][i - 1].toString();

  temp += '\r\n';

  for (var i = 1; i <= 5; i++)
    temp += myGrid[i - 1][i].toString();

  temp = temp + '\r\n';

  for (var i = 1; i <= 6; i++)
    temp += myGrid[i - 1][i - 1].toString();

  temp += '\r\n';

  for (var i = 1; i <= 6; i++)
    temp += myGrid[i][i - 1].toString();

  temp += '\r\n';

  for (var i = 1; i <= 5; i++)
    temp += myGrid[i + 1][i - 1].toString();

  temp += '\r\n';

  for (var i = 0; i <= 3; i++)
    temp += myGrid[i][(i - 3).abs()].toString();

  temp += '\r\n';

  for (var i = 0; i <= 4; i++)
    temp += myGrid[i][(i - 3).abs()].toString();

  temp += '\r\n';

  for (var i = 0; i <= 4; i++)
    temp += myGrid[i][(i - 4).abs()].toString();

  temp += '\r\n';

  for (var i = 0; i <= 5; i++)
    temp += myGrid[i][(i - 5).abs()].toString();

  temp += '\r\n';

  for (var i = 0; i <= 5; i++)
    temp += myGrid[i + 1][(i - 5).abs()].toString();

  temp += '\r\n';

  for (var i = 0; i <= 4; i++)
    temp += myGrid[i + 2][(i - 5).abs()].toString();

  temp += '\r\n';

  for (var i = 0; i <= 3; i++)
    temp += myGrid[i + 3][(i - 5).abs()].toString();

  if (temp.lastIndexOf(player.toString() + '' + player.toString() + '' + player.toString() + '' + player.toString()) > -1) won = true;

  if (won)
  {
    window.alert('Player '+ player.toString() +' won');
    initGrid();
  }
  else
  {
    var hasEmpty = false;
    for(int x = 0; x < 7; x++)
    {
      for(int y = 0; y < 6; y++)
      {
          hasEmpty = myGrid[x][y] == 0;

          if(hasEmpty)
            return;
      }
    }

    if(!hasEmpty)
    {
      window.alert('Tie match!');
      initGrid();
    }
  }


}



void dropCounter(){
  //if column full, don't just move to next players turn
  //create counter function with color/radius parameter or a circle function
    getColor();
    if (xpos > xoffset + countR && xpos < (countR + countW * 7) - (xoffset))
    {
      if (gridpos == 0 && pos == 0)
        gridpos = (((xpos - xoffset / 7) / 60).round() - 1);

      if (gridpos > -1 && gridpos < 7)
      {
        if(myGrid[gridpos][0] != 0)
        {
          gridpos = 0;
          pos = 0;
          return;
        }

        clear();
        if (pos > 0)
        {
          context.fillStyle = 'white';
          context.beginPath();
          context.arc(countR + gridpos * countW + xoffset, ((countR + 60) + (pos * 60) - 60 + yoffset) - countW, countR - 20, 0, Math.PI * 2, true);
          context.closePath();
          context.fill();
        }



        pos=0;
        for(int x = 0; x < 5; x++)
        {
          if(myGrid[gridpos][pos+1] == 0)
            pos++;
          else
            break;
        }

      myGrid[gridpos][pos] = player;


      pos++;

      context.fillStyle = playerColor;
      context.beginPath();
      context.arc(countR + gridpos * countW + xoffset, (countR + 60) + (pos * 60) - 60 + yoffset, countR - 7, 0, Math.PI * 2, true);
      context.closePath();
      context.fill();
      context.stroke();

      context.beginPath();
      context.arc(countR + gridpos * countW + xoffset, (countR + 60) + (pos * 60) - 60 + yoffset, countR - 20, 0, Math.PI * 2, true);
      context.closePath();
      context.fill();
      context.stroke();

      pos--;

      checkGrid();

      if (!won && myGrid[gridpos][pos] == player)
        player == 1 ? player++ : player = 1;



      pos = 0;
      gridpos = 0;

      }
    }
  }

  void clearGrid() {
    for (var j = 0; j < 6; j++)
      for (var i = 0; i < 7; i++)
        myGrid[i][j] = 0;
  }

  void initGrid() {
      won = false;
      gridpos = 0; pos = 0;
      clearGrid();


      for (var j = 1; j <= 6; j++)
        for (var i = 0; i < 7; i++)
        {
          context.fillStyle = "rgba(255,255,255,1)";
          context.beginPath();
          context.arc(countR + i * countW + xoffset, (countR + 60) + (j * 60) - 60 + yoffset,countR - 3, 0, Math.PI * 2,true);
          context.closePath();
          context.fill();
          context.stroke();
        }

      if(firstRound)
      {
        canvas.onMouseMove.listen((MouseEvent e){drawCounter(e);});
        canvas.onClick.listen((MouseEvent e){dropCounter();});
        firstRound = false;
      }
    }