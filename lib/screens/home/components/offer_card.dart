import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key,
    required this.image,
    required this.name,
    required this.offer,
  }) : super(key: key);

  final String name;
  final String offer;
  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        String brandName = "Careem";

        final response = await http.get(
          Uri.parse(
              'https://www.google.com/search?q=$brandName&client=safari&rls=en&sxsrf=ALiCzsbc7jVPGpW9wKDlqH_wEziyH2DT3g:1665687911785&tbm=isch&source=iu&ictx=1&vet=1&fir=OOHUXMn-_e_ZrM%252Cm5dQVUxQl58RDM%252C%252Fg%252F11cmqkl_vh&usg=AI4_-kQHuR35Bk0o4rTym9E4_2sPczQL-w&sa=X&ved=2ahUKEwiijaeC8936AhWhhP0HHQWnBPgQ_B16BAhlEAI#imgrc=OOHUXMn-_e_ZrM'),
        );
        var document = parse(response.body);

        final elements = await document.querySelectorAll('.png');

        print(elements.map((a) => a.querySelector('img')!.attributes['src']).toList());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.width * 0.015),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5.0),
              blurRadius: 10.0,
              spreadRadius: -7.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  offer,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
