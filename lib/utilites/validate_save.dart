dynamic validateAndSave(formKey) {
      final form = formKey.currentState;
      if (form != null && form.validate()) {
        form.save();
      } else {}
    }