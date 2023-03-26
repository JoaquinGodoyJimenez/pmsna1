import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmsna1/widgets/loading_modal_widget.dart';
import 'package:path/path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePermanent = await saveFilePermanently(image.path);

      setState(() {
        this._image = imagePermanent;
      });

      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Error al elegir imagen: $e');
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  set image(File image) {}

  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor escriba su nombre';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Nombre completo'), border: OutlineInputBorder()),
    );

    final txtCorreo = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor escriba su correo electrónico';
        }
        if (!EmailValidator.validate(value)) {
          return 'Por favor escriba un correo válido';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Correo electrónico'), border: OutlineInputBorder()),
    );

    final txtPassword = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor escriba su contraseña';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Contraseña'), border: OutlineInputBorder()),
    );

    final spaceHorizontal = const SizedBox(
      height: 10,
    );

    final imgdefault = Image.asset(
      'assets/default.png',
      height: 100,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: .4,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/fondo_itc.jpg'))),
            child: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  width: 400,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 70,
                      ),
                      spaceHorizontal,
                      txtNombre,
                      spaceHorizontal,
                      txtCorreo,
                      spaceHorizontal,
                      txtPassword,
                      const SizedBox(
                        height: 40,
                      ),
                      _image != null
                          ? Image.file(
                              _image!,
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/default.png',
                              width: 200,
                              height: 200,
                            ),
                      const SizedBox(
                        height: 40,
                      ),
                      spaceHorizontal,
                      CustomButton(
                        title: 'Elegir de la galería',
                        icon: Icons.image_outlined,
                        onClick: () => getImage(ImageSource.gallery),
                      ),
                      spaceHorizontal,
                      CustomButton(
                        title: 'Tomar una foto',
                        icon: Icons.camera,
                        onClick: () => getImage(ImageSource.camera),
                      ),
                      spaceHorizontal,
                      Container(
                        width: 280,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Registrando espere un momento.')),
                              );
                            }
                          },
                          child: const Text('Registrarse'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(title)
        ],
      ),
    ),
  );
}
