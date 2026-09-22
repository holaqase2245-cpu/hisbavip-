function calculate() {
  const number1 = Number(document.getElementById("number1").value);
  const number2 = Number(document.getElementById("number2").value);
  const operation = document.getElementById("operation").value;

  let result;

  if (operation === "+") {
    result = number1 + number2;
  } else if (operation === "-") {
    result = number1 - number2;
  } else if (operation === "*") {
    result = number1 * number2;
  } else if (operation === "/") {
    if (number2 === 0) {
      result = "لا يمكن القسمة على صفر";
    } else {
      result = number1 / number2;
    }
  }

  document.getElementById("result").textContent =
    "النتيجة: " + result;
}
