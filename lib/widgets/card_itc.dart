import 'package:flutter/cupertino.dart';
import 'package:pmsna1/responsive.dart';

class CardITCData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  const CardITCData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background,
  });
}

class CardITC extends StatelessWidget {
  const CardITC({required this.data, super.key});

  final CardITCData data;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (data.background != null) data.background!,
        Responsive(
            mobile: MobileCard(data: data), desktop: DesktopCard(data: data))
      ],
    );
  }
}

class MobileCard extends StatelessWidget {
  const MobileCard({
    super.key,
    required this.data,
  });

  final CardITCData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          const Spacer(
            flex: 3,
          ),
          Flexible(flex: 20, child: Image(image: data.image)),
          const Spacer(
            flex: 1,
          ),
          Text(
            data.title.toUpperCase(),
            style: TextStyle(
                color: data.titleColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
            maxLines: 1,
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            data.subtitle,
            style: TextStyle(
              color: data.subtitleColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const Spacer(
            flex: 10,
          ),
        ],
      ),
    );
  }
}

class DesktopCard extends StatelessWidget {
  const DesktopCard({
    super.key,
    required this.data,
  });

  final CardITCData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Row(
        children: [
          Flexible(flex: 5, child: Image(image: data.image)),
          const Spacer(
            flex: 1,
          ),
          Column(
            children: [
              Container(
                height: 300,
              ),
              Text(
                data.title.toUpperCase(),
                style: TextStyle(
                    color: data.titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
                maxLines: 1,
              ),
              Container(
                width: 500,
                child: Text(
                  data.subtitle,
                  style: TextStyle(
                    color: data.subtitleColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
