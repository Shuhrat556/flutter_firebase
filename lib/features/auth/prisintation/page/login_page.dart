class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) => value!.isEmpty ? 'Email required' : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) => value!.length < 6 ? 'Min 6 chars' : null,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          SignInRequested(
                            _emailController.text,
                            _passwordController.text,
                          ),
                        );
                      }
                    },
                    child: Text('Sign In'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}