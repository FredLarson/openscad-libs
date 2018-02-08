module validate(valid, message) {
  // It would be great if this was more like a stack trace
  module print_error(string) {
    echo(str("<br/><font color='red'>", string, "<br/>  in module <b>", parent_module(2), "</b> called from <b>", parent_module(3), "</b><br/>"));
  }

  if(!valid) {
    print_error(str("Error: <b>", message, "</b>"));

    if(version()[0] >= 2017) {
      assert(false);
    }
  }
}
