import 'package:tawfeer/src/business_logic/models/product.dart';

class ProductsRepository {
  Future<List<Product>> index() async {
    // await Future.delayed(const Duration(seconds: 3), () => throw Exception('Failed'));
    // return await Future.delayed(const Duration(seconds: 3), () => []);
    return await Future.delayed(const Duration(seconds: 3), () {
      return [
        Product(
          id: 1,
          ownerId: 1,
          productTitle: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 11,
          newPrice: 11,
          expireDate: DateTime(2023, 12, 5),
          category: "Drinks",
          quantity: 55,
          imgUrl:
              'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 15,
        ),
        Product(
          id: 2,
          ownerId: 1,
          productTitle: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 3,
          expireDate: DateTime(2023, 11, 5),
          category: "Shampoos",
          quantity: 30,
          discount: 20,
          imgUrl:
              'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 532,
        ),
        Product(
          id: 3,
          ownerId: 1,
          productTitle: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          newPrice: 8,
          discount: 20,
          expireDate: DateTime(2022, 3, 5),
          category: "Drinks",
          quantity: 55,
          imgUrl:
              'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 412,
        ),
        Product(
          id: 4,
          ownerId: 1,
          productTitle: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          discount: 20,
          newPrice: 1,
          expireDate: DateTime(2022, 9, 3),
          category: "Shampoos",
          quantity: 30,
          imgUrl:
              'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 13,
        ),
        Product(
          id: 5,
          ownerId: 1,
          productTitle: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 16,
          discount: 20,
          newPrice: 7,
          expireDate: DateTime(2022, 12, 5),
          category: "Drinks",
          quantity: 55,
          imgUrl:
              'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 0,
        ),
        Product(
          id: 6,
          ownerId: 1,
          discount: 20,
          productTitle: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 2,
          expireDate: DateTime(2024, 12, 5),
          category: "Shampoos",
          quantity: 30,
          imgUrl:
              'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 31,
        ),
        Product(
          id: 7,
          ownerId: 1,
          discount: 20,
          productTitle: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          newPrice: 15,
          expireDate: DateTime(2025, 12, 5),
          category: "Shampoos",
          quantity: 30,
          imgUrl:
              'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 31,
        ),
      ];
    });
  }

  Future<List<Product>> myProducts({required int id}) async {
    // await Future.delayed(const Duration(seconds: 3), () => throw Exception('Failed'));
    // return await Future.delayed(const Duration(seconds: 3), () => []);
    return await Future.delayed(const Duration(seconds: 3), () {
      return [
        Product(
          id: 1,
          ownerId: 1,
          productTitle: "Pepsi 330 ML",
          description: "Just a Pepsi",
          oldPrice: 11,
          newPrice: 11,
          discount: 20,
          expireDate: DateTime(2023, 12, 5),
          category: "Drinks",
          quantity: 55,
          imgUrl:
              'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          seens: 15,
        ),
        Product(
          id: 2,
          ownerId: 1,
          productTitle: "Pantene shampoo for smooth hair",
          description: "The best shampoo ever",
          oldPrice: 16,
          discount: 20,
          newPrice: 3,
          expireDate: DateTime(2023, 11, 5),
          category: "Shampoos",
          quantity: 30,
          imgUrl:
              'https://www.byrdie.com/thmb/cof_0J6XFN4Jh6I4LMUSBJi9oms=/3024x3024/filters:no_upscale()/pantenebeautifullengthsshampooproductshot-88c6d10c1bd4435a87d983aa56ba06eb.jpg',
          seens: 532,
        ),
      ];
    });
  }

  Future<void> addProduct({required Product product}) async {
    // await Future.delayed(const Duration(seconds: 3), () => throw Exception('Failed'));
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<void> deleteProduct({required int id}) async {
    // await Future.delayed(const Duration(seconds: 3), () => throw Exception('Failed'));
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<Product> getProduct({required int id}) async {
    // await Future.delayed(const Duration(seconds: 3), () => throw Exception('Failed'));
    return await Future.delayed(
      const Duration(seconds: 3),
        () => Product(
          productTitle: 'Pepsi can 330 ML',
          quantity: 30,
          category: 'Drinks',
          discount: 20,
          description: 'The already known pepsi.',
          id: 1,
          oldPrice: 22,
          seens: 223,
          ownerId: 1,
          expireDate: DateTime.parse("2020-05-03"),
          imgUrl: 'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
          newPrice: 16,
        ),
    );
  }
}
