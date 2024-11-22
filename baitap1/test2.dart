void main(){
  Object obj = "Hello Phong";

  if(obj is String){
    print("OBJ Ja String");
  }

  if(obj is! int){
    print("OBJ khong phai la int");
  }

  String str = obj as String;
  print(str.toUpperCase());
}