import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/chat_bubble.dart';
import 'ui/colors.dart';
import 'logic/game.dart';
import 'package:flutter/services.dart';

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
    //TODO - initialize game board
    print('game');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: MainColor.backgroundGradient),
        padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 143,
                child: game.isWinner()
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          !game.isTie
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child:
                                          Image.asset(game.currentPlayerIcon),
                                    ),
                                    Text(
                                      "'s turn",
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.grey[200]),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Image.asset('./assets/skuli.png'),
                                    ),
                                    const SizedBox(height: 10),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 50.0),
                                      child: ChatBubble(
                                          message:
                                              'Common strákar, smá standard!🤡',
                                          isSentByMe: false),
                                    )
                                  ],
                                )
                        ],
                      )
                    : Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Image.asset('${game.currentPlayerIcon}'),
                            ), // Adjust spacing
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: ChatBubble(
                                  message: game.currentPlayer
                                      ? 'Take that Gunnar you son of a bitch!'
                                      : 'Take that Hjalti you son of a bitch!',
                                  isSentByMe: false),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                width: 400, //TODO - setja í breytu
                height: 500, //TODO - setja í breytu
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0), // Adjust padding
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade400,
                          ),
                          width: 100,
                          height: 100,
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
                            if (!game.gameOver) {
                              SystemSound.play(SystemSoundType.click);
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    child: Image.asset(
                      'assets/ntv.png',
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Visibility(
                    visible: game.gameOver,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          foregroundColor: Colors.grey.shade200,
                          textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () {
                        setState(() {
                          game.board = ['', '', '', '', '', '', '', '', ''];
                          game.currentPlayer = true;
                          game.gameOver = false;
                          game.winner = '';
                          game.turnCounter = 0;
                          game.currentPlayer = true;
                          game.isTie = false;
                          game.currentPlayerIcon = Game.playerO;
                        });
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Icon(
                          Icons.replay,
                          size: 50,
                        ),
                      ),
                      label: const Text(''),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
