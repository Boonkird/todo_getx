import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  // final box = GetStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> init() async {
    await GetStorage.init();
  }

  Future<String> write(String key, dynamic value, {required String uid}) async {
    try {
      final docRef = await _firestore.collection(key).add(value);
      docRef.update({'docId': docRef.id});
      return docRef.id;
    } catch (e) {
      print('StorageService.write: $e');
      return '';
    }
  }

  Future<List<Map<String, dynamic>>> read(String key, {String? uid}) async {
    try {
      if (uid != null) {
        final snapshot =
            await _firestore.collection(key).where('uid', isEqualTo: uid).get();
        return snapshot.docs.map((e) => e.data()).toList();
      } else {
        final snapshot = await _firestore.collection(key).get();
        return snapshot.docs.map((e) => e.data()).toList();
      }
    } catch (e) {
      print('StorageService.read: $e');
      return [];
    }
  }

  Future<void> delete(String key, String docId) async {
    try {
      await _firestore.collection(key).doc(docId).delete();
    } catch (e) {
      print('StorageService.delete: $e');
    }
  }

  Future<void> update(String key, String docId, dynamic value) async {
    try {
      await _firestore.collection(key).doc(docId).update(value);
    } catch (e) {
      print('StorageService.update: $e');
    }
  }
}
