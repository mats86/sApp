import 'package:flutter/material.dart';

class SwimGeneratorFormShell extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const SwimGeneratorFormShell({
    super.key,
    required this.child,
    this.maxWidth = 500.0, // Standardwert für die maximale Breite
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Hintergrundbild
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("images/Rectangle3704.png",), // Pfad zu Ihrem Hintergrundbild
                fit: BoxFit.cover, // Sorgt dafür, dass das Bild den ganzen Container ausfüllt
              ),
            ),
          ),

          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenSize.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24,),
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Card(
                        elevation: 8.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: child, // Der Inhalt der spezifischen Formularseite
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
