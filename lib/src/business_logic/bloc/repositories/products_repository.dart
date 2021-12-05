import 'package:tawfeer/src/business_logic/models/product.dart';

class ProductsRepository {
  Future<List<Product>> index() async {
    return await Future.delayed(const Duration(seconds: 3), () {
      return [
        Product(
          productName: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 March 2021",
          category: "Drinks",
          quantity: 55,
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
        ),
        Product(
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
        ),
        Product(
          productName: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 March 2021",
          category: "Drinks",
          quantity: 55,
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
        ),
        Product(
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
        ),
        Product(
          productName: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 March 2021",
          category: "Drinks",
          quantity: 55,
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
        ),
        Product(
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
        ),
        Product(
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
        ),
      ];
    });
    // throw Exception('Failed');
  }
}
