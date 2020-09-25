
class Ans {
  int id;
  String ans;

  Ans({ this.id, this.ans,  });

  factory Ans.fromJson(Map<String, dynamic> parsedJson){
    return Ans(
      id : parsedJson['id'],
      ans : parsedJson['Answer'],
    );
  }
}

class Data {
  int id;
  String question;
  List<Ans> answer;

  Data({ this.id, this.question, this.answer });

  factory Data.fromJson(Map<String, dynamic> parsedJson){
    return Data(
      id : parsedJson['id'],
      question : parsedJson['Ques'],
      answer : parsedJson['Ans'],
    );
  }
}

