import 'package:tawfeer/src/business_logic/models/product.dart';

class ProductsRepository {
  Future<List<Product>> index() async {
    // await Future.delayed(const Duration(seconds: 3), () => throw Exception('Failed'));
    // return await Future.delayed(const Duration(seconds: 3), () => []);
    return await Future.delayed(const Duration(seconds: 3), () {
      return [
        Product(
          id: 1,
          productName: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 March 2021",
          category: "Drinks",
          quantity: 55,
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 15,
        ),
        Product(
          id: 2,
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 532,
        ),
        Product(
          id: 3,
          productName: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 March 2021",
          category: "Drinks",
          quantity: 55,
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 412,
        ),
        Product(
          id: 4,
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 13,
        ),
        Product(
          id: 5,
          productName: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 March 2021",
          category: "Drinks",
          quantity: 55,
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 0,
        ),
        Product(
          id: 6,
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 31,
        ),
        Product(
          id: 7,
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 31,
        ),
      ];
    });
  }

  Future<List<Product>> myProducts({required int id}) async {
    await Future.delayed(const Duration(seconds: 3), () => throw Exception('Failed'));
    /*
    // return await Future.delayed(const Duration(seconds: 3), () => []);
    return await Future.delayed(const Duration(seconds: 3), () {
      return [
        Product(
          id: 1,
          productName: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 March 2021",
          category: "Drinks",
          quantity: 55,
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 15,
        ),
        Product(
          id: 2,
          productName: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 April 2021",
          category: "Shampoos",
          quantity: 30,
          imgUrl: 'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 532,
        ),
        Product(
          id: 3,
          productName: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 12,
          expireDate: "04 March 2021",
          category: "Drinks",
          quantity: 55,
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 412,
        ),
      ];
    });
     */
  }
}
