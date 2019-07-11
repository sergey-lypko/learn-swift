// *  *  *  Textfield delegate   *   *   *

// Задача: во View есть два TextField. Во ViewController необходимо определять,
// какой из TextField в данный момент находится в фокусе

// ViewController должен conform UITextFieldDelegate protocol
class MyViewController: BaseViewController<SomeView>, UITextFieldDelegate {...}

// ViewController должен дерегировать TextFields на себя 
override func viewDidLoad / configureBinds {
  super.viewDidLoad()

  contentView.textField.delegate = self
}

// ViewController затем реализует методы протокола UITextFieldDelegate
// например textFieldDidBeginEditing
func textFieldDidBeginEditing(_ textField: UITextField) {
  ...
}

// Во View, для удобства имеет смысл задать tag's для TextField
override func configureView {
  super.configureView()  

  fiatAmountTextField.tag = 1

  // вспомагательные свойства, чтобы не показывать клавиатуру
  fiatAmountTextField.inputView = UIView()
  fiatAmountTextField.inputAccessoryView = UIView()
} 

