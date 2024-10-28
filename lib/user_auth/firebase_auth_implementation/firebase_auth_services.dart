import 'package:firebase_auth/firebase_auth.dart';
import '../../toast.dart';
// class FirebaseAuthService{
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   Future<User?> signUpWithEmailAndPassword(String email, String password) async{
//     try{
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       return credential.user;
//     }catch (e){
//       print("Some error occcured");
//     }
//   }

//   Future<User?> signInWithEmailAndPassword(String email, String password) async{
//     try{
//       UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return credential.user;
//     }catch (e){
//       print("Some error occcured");
//     }
//   }
// }
class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email đã được sử dụng') {
        showToast(message: 'Địa chỉ email đã được sử dụng.');
      } else {
        showToast(message: 'Đã xảy ra lỗi: ${e.code}');
      }
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Không tìm được người dùng' || e.code == 'Sai mật khẩu') {
        showToast(message: 'Email hoặc mật khẩu không hợp lệ.');
      } else {
        showToast(message: 'Đã xảy ra lỗi: ${e.code}');
      }

    }
    return null;

  }




}