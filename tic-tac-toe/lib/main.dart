import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ui/colors.dart';
import 'logic/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _GameScreen();
}

class _GameScreen extends State<MyHomePage> {
  Game game = Game();

  void initState() {
    super.initState();
    //TODO - inititalize game board
    print('game');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          game.isWinner()
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !game.isTie
                        ? Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Image.asset(game.currentPlayer
                                    ? game.playerO
                                    : game.playerX),
                              ),
                              Text(
                                game.currentPlayer ? "'s turn" : "'s turn",
                                style: const TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                width: 140,
                                child: Image.asset('./assets/skuli.png'),
                              ),
                              Text(
                                'Common strákar, smá standard!🤡',
                                style: const TextStyle(
                                  fontSize: 23,
                                ),
                              ),
                            ],
                          )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Image.asset('${game.winner}'),
                        ),
                        Center(
                          child: Text(
                            game.currentPlayer
                                ? 'Take that Gunnar you son of a bitch!'
                                : ' Take that Hjalti you son of a bitch!',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          SizedBox(
            width: 400, //TODO - setja í breytu
            height: 600, //TODO - setja í breytu
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MainColor.white,
                      ),
                      width: 200,
                      height: 200,
                      child: Center(
                        child: game.board[index].isEmpty
                            ? const Text('')
                            : Image.asset(
                                game.board[index],
                              ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        game.game(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = ['', '', '', '', '', '', '', '', ''];
                game.currentPlayer = true;
                game.gameOver = false;
                game.playerO = './assets/gunni.png';
                game.playerX = './assets/hjalti.png';
                game.winner = '';
                game.turnCounter = 0;
                game.currentPlayer = true;
                game.isTie = false;
              });
            },
            icon: const Icon(Icons.replay),
            label: const Text('Restart'),
          )
        ]),
      ),
    );
  }
}
