mixin FormsValidator {
  String? emptyValidator(String? value) {
    if ((value ?? "").isEmpty) return "Campo obrigatório";
    return null;
  }

  String? confirmPasswordValidator(String? value, String? anotherPassword) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme sua senha';
    }
    if (value != anotherPassword) {
      return 'As senhas não correspondem';
    }
    return null;
  }

  String? yearValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite um valor.';
    }

    final year = int.tryParse(value);

    if (year == null) {
      return 'Por favor, digite um ano válido.';
    }

    final currentYear = DateTime.now().year;

    if (year > currentYear) {
      return 'O ano não pode ser maior que o ano atual ($currentYear).';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite sua senha.';
    }
    if (value.length < 6) {
      return 'A senha deve ter mais de 6 caracteres.';
    }
    if (value.length > 10) {
      return 'A senha deve ter menos de 10 caracteres.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'A senha deve conter pelo menos uma letra maiúscula.';
    }
    if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return 'A senha deve conter pelo menos um caractere especial.';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite seu e-mail.';
    }
    // Expressão regular para validar um formato de e-mail básico
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, digite um e-mail válido.';
    }
    return null; // E-mail válido
  }
}
