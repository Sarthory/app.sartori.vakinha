import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_controller.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  var _showPassword = false;
  var _showPasswordConfirm = false;

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess(
              'Cadastro realizado com sucesso!\nFaça seu primeiro login!',
            );
            Navigator.of(context).popAndPushNamed('/login');
          },
          error: () {
            hideLoader();
            showError('Erro ao realizar cadstro.');
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastre-se',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    "Preencha os campos abaixo para criar seu cadastro.",
                    style: context.textStyles.textMedium.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //NAME
                    controller: _nameEC,
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required('Nome é obrigatório.'),
                      Validatorless.min(3, 'Insira um nome válido.'),
                      Validatorless.max(80, 'Insira um nome válido.')
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    //EMAIL
                    controller: _emailEC,
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail é obrigatório.'),
                      Validatorless.email('Insira um e-mail válido.')
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    //PASSWORD
                    controller: _passwordEC,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        child: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black38,
                        ),
                        onTap: () => setState(
                          () => _showPassword = !_showPassword,
                        ),
                      ),
                      label: Text('Senha'),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha é obrigatória.'),
                      Validatorless.min(6, 'Senha mínima de 6 caracteres.')
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    //PASSWORD CONFIRMATION
                    obscureText: !_showPasswordConfirm,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        child: Icon(
                          _showPasswordConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black38,
                        ),
                        onTap: () => setState(
                          () => _showPasswordConfirm = !_showPasswordConfirm,
                        ),
                      ),
                      label: Text('Confirme a senha'),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmação obrigatória.'),
                      Validatorless.compare(
                        _passwordEC,
                        'Senhas diferentes informadas.',
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: DeliveryButton(
                      label: 'CRIAR MEU CADASTRO',
                      width: double.infinity,
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.registerAccount(
                            _nameEC.text,
                            _emailEC.text,
                            _passwordEC.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
