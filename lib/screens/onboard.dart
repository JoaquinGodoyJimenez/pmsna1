import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsna1/widgets/card_itc.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final data = [
    CardITCData(
      title: "Nuestra institución",
      subtitle:
          "El Tecnológico de Celaya ahora TecNM en Celaya, inicia actividades el 14 de abril de 1958.",
      image: const AssetImage('assets/logo_itc.png'),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation1.json"),
    ),
    CardITCData(
      title: "Sistemas computacionales",
      subtitle:
          "Los egresados de la carrera serán profesionistas capaces de diseñar e implementar infraestructura computacional para aportar soluciones en beneficio de la sociedad.",
      image: const AssetImage('assets/isc.png'),
      backgroundColor: Colors.white,
      titleColor: const Color.fromRGBO(0, 10, 56, 1),
      subtitleColor: Colors.black,
      background: LottieBuilder.asset("assets/animation2.json"),
    ),
    CardITCData(
      title: "Instalaciones",
      subtitle: "Descubre nuestras instalaciones en nuestros dos campus.",
      image: const AssetImage('assets/builds.png'),
      backgroundColor: Colors.yellowAccent,
      titleColor: const Color.fromRGBO(2, 3, 129, 1),
      subtitleColor: Colors.black,
      background: LottieBuilder.asset("assets/animation1.json"),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConcentricPageView(
            itemCount: 3,
            colors: data.map((e) => e.backgroundColor).toList(),
            itemBuilder: (int index) {
              return CardITC(data: data[index]);
            }));
  }
}
