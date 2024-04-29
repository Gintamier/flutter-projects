class Game {
  static final boardLength = 9;

  //TODO:
  // - Player
  String playerO = './assets/gunni.png';
  String playerX = './assets/hjalti.png';
  String winner = '';
  int turnCounter = 0;
  bool currentPlayer = true;
  bool isTie = false;
  // - Game
  bool gameOver = false;
  game(index) {
    if (!gameOver) {
      turnCounter++;
      if (this.board[index].isEmpty) {
        this.board[index] = currentPlayer ? playerO : playerX;
        this.turn();
        isWinner();
        if (turnCounter == 9 && winner == '') {
          isTie = true;
          playerO = './assets/skuli.png';
          playerX = './assets/skuli.png';
          winner = './assets/skuli.png';
        }
      }
    }
  }

  //  - variables - whos turn it is?
  turn() {
    currentPlayer = !this.currentPlayer;
  }

  //  - board
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  //  - winnerCheck()
  isWinner() {
    if (board[0] == playerO && board[1] == playerO && board[2] == playerO) {
      winner = playerO;
      this.gameOver = true;
    } else if (board[0] == playerX &&
        board[1] == playerX &&
        board[2] == playerX) {
      winner = playerX;
      this.gameOver = true;
    }
    if (board[3] == playerO && board[4] == playerO && board[5] == playerO) {
      winner = playerO;
      this.gameOver = true;
    } else if (board[3] == playerX &&
        board[4] == playerX &&
        board[5] == playerX) {
      winner = playerX;
      this.gameOver = true;
    }
    if (board[6] == playerO && board[7] == playerO && board[8] == playerO) {
      winner = playerO;
      this.gameOver = true;
    } else if (board[6] == playerX &&
        board[7] == playerX &&
        board[8] == playerX) {
      winner = playerX;
      this.gameOver = true;
    }

    if (board[0] == playerO && board[3] == playerO && board[6] == playerO) {
      winner = playerO;
      this.gameOver = true;
    } else if (board[0] == playerX &&
        board[3] == playerX &&
        board[6] == playerX) {
      winner = playerX;
      this.gameOver = true;
    }
    if (board[1] == playerO && board[4] == playerO && board[7] == playerO) {
      winner = playerO;
      this.gameOver = true;
    } else if (board[1] == playerX &&
        board[4] == playerX &&
        board[7] == playerX) {
      winner = playerX;
      gameOver = true;
    }
    if (board[2] == playerO && board[5] == playerO && board[8] == playerO) {
      winner = playerO;
      this.gameOver = true;
    } else if (board[2] == playerX &&
        board[5] == playerX &&
        board[8] == playerX) {
      winner = playerX;
      this.gameOver = true;
    }
    if (board[2] == playerO && board[4] == playerO && board[6] == playerO) {
      winner = playerO;
      this.gameOver = true;
    } else if (board[2] == playerX &&
        board[4] == playerX &&
        board[6] == playerX) {
      winner = playerX;
      this.gameOver = true;
    }

    if (board[0] == playerO && board[4] == playerO && board[8] == playerO) {
      winner = playerO;
      this.gameOver = true;
    } else if (board[0] == playerX &&
        board[4] == playerX &&
        board[8] == playerX) {
      winner = playerX;
      this.gameOver = true;
    }

    return !this.gameOver;
  }
}
