import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/pages/auth/login/login_controller.dart';
import 'package:dw9_delivery_app/app/pages/auth/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          login: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Login realizado com sucesso!');
            Navigator.pop(context, true);
          },
          loginError: () {
            hideLoader();
            showError(controller.state.errorMessage ?? "");
          },
          error: () {
            hideLoader();
            showError(controller.state.errorMessage ?? "");
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: context.textStyles.textTitle,
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
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text('Senha'),
                        ),
                        validator:
                            Validatorless.required('Senha é obrigatória.'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: DeliveryButton(
                          label: 'ENTRAR',
                          width: double.infinity,
                          onPressed: () {
                            var val =
                                _formKey.currentState?.validate() ?? false;
                            if (val) {
                              controller.performLogin(
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
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem uma conta?",
                        style: context.textStyles.textBold,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed('/register');
                          },
                          child: Text(
                            "Cadastre-se",
                            style: context.textStyles.textBold.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
