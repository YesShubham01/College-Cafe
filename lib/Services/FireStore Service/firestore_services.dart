import 'package:cafe/Services/FireStore%20Service/single_item_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStore {
  Future<List<SingleItemData>> get_available_food_items() async {
    List<SingleItemData> result = [];
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Reference to the "Menu" collection
    CollectionReference menuCollection = firestore.collection('Menu');
    // Reference to the "All Items" document
    DocumentReference allItemsDocument = menuCollection.doc('All Items');
    // Query a subcollection (e.g., "Food")
    QuerySnapshot<Map<String, dynamic>> foodCollection = await allItemsDocument
        .collection('Food')
        .where('available', isEqualTo: true)
        .get();

    // Access documents within the "Food" subcollection
    for (var doc in foodCollection.docs) {
      Map<String, dynamic> data = doc.data();
      // Access data in the document
      SingleItemData temp = SingleItemData(
          name: data['name'],
          price: data['price'],
          image: data['image'],
          id: data['id']);
      result.add(temp);
    }

    return result;
  }

  //testing
  Future<String> backendTest() async {
    String dataText = '';
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the "Menu" collection
      final CollectionReference menuCollection = firestore.collection('Menu');

      // Reference to the "All Items" document
      final DocumentReference allItemsDocument =
          menuCollection.doc('All Items');

      // Check if the "All Items" document exists
      final DocumentSnapshot<Object?> documentSnapshot =
          await allItemsDocument.get();

      if (documentSnapshot.exists) {
        // Document exists, now check subcollections (e.g., "Food")
        final QuerySnapshot<Map<String, dynamic>> foodCollection =
            await allItemsDocument.collection('Food').get();

        // Check if there are documents in the "Food" subcollection
        if (foodCollection.docs.isNotEmpty) {
          for (var doc in foodCollection.docs) {
            Map<String, dynamic> data = doc.data();
            dataText += data['name'].toString() +
                data['price'].toString() +
                data['image'].toString();
          }
          return dataText;
        } else {
          return 'not found';
        }
      } else {
        return 'not found';
      }
    } catch (e) {
      // Handle any errors that may occur during the Firestore query
      print('Error: $e');
      return 'Error';
    }
  }

  Future<Map<String, dynamic>> readUserData() async {
    Map<String, dynamic> userData = {};

    try {
      String? userUid = FirebaseAuth.instance.currentUser?.uid;

      if (userUid != null) {
        DocumentSnapshot<Map<String, dynamic>> userDocument =
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userUid)
                .get();

        if (userDocument.exists) {
          userData = userDocument.data() as Map<String, dynamic>;
        } else {
          print('User document does not exist.');
        }
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error reading data: $e');
    }

    return userData;
  }

  Future<void> createNewUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String? userUid = auth.currentUser?.uid;

      if (userUid != null) {
        Map<String, dynamic> data = {
          'name': auth.currentUser?.displayName,
          'cart': [],
        };
        await FirebaseFirestore.instance
            .collection(
                'Users') // Collection name, you can change it as per your requirement
            .doc(userUid) // Document ID is the user's UID
            .set(
                data,
                SetOptions(
                    merge:
                        true)); // SetOptions(merge: true) ensures it doesn't overwrite existing data
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> addToCart(int item) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String? userUid = auth.currentUser?.uid;

      if (userUid != null) {
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('Users').doc(userUid);

        DocumentSnapshot userDoc = await userDocRef.get();
        if (userDoc.exists) {
          List<dynamic> cart = userDoc['cart'];
          cart.add(item);

          await userDocRef.update({'cart': cart});
        } else {
          print('User document does not exist.');
        }
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<void> removeFromCart(int item) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String? userUid = auth.currentUser?.uid;

      if (userUid != null) {
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('Users').doc(userUid);

        DocumentSnapshot userDoc = await userDocRef.get();
        if (userDoc.exists) {
          List<dynamic> cart = userDoc['cart'];
          cart.remove(item);

          await userDocRef.update({'cart': cart});
        } else {
          print('User document does not exist.');
        }
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  Future<List<SingleItemData>> getCartItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<SingleItemData> items = [];

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String? userUid = auth.currentUser?.uid;

      if (userUid != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentReference<Map<String, dynamic>> userDocRef =
            firestore.collection('Users').doc(userUid);

        DocumentSnapshot<Map<String, dynamic>> userDoc = await userDocRef.get();
        if (userDoc.exists) {
          List<dynamic> cart = userDoc['cart'];

          CollectionReference<Map<String, dynamic>> foodCollection =
              firestore.collection('Menu').doc('All Items').collection('Food');

          QuerySnapshot<Map<String, dynamic>> querySnapshot =
              await foodCollection.where('id', whereIn: cart).get();

          for (var doc in querySnapshot.docs) {
            Map<String, dynamic> data = doc.data();
            SingleItemData item = SingleItemData(
              name: data['name'],
              price: data['price'],
              image: data['image'],
              id: data['id'],
            );
            items.add(item);
          }
        } else {
          print('User document does not exist.');
        }
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error fetching items from cart: $e');
    }

    return items;
  }
}
