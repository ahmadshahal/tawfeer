import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/models/review.dart';
import 'package:tawfeer/src/business_logic/services/api_services/product_api.dart';

class ProductsRepository {
  final ProductAPI _productAPI = ProductAPI();

  Future<List<Product>> index() async {
    return await _productAPI.index();
  }

  Future<List<Product>> myProducts() async {
    return await _productAPI.myProducts();
  }

  Future<void> addProduct({required Product product}) async {
    await _productAPI.store(product);
  }

  Future<void> editProduct({required Product product}) async {
    await _productAPI.update(product);
  }

  Future<void> deleteProduct({required int id}) async {
    await _productAPI.destroy(id);
  }

  Future<Product> getProduct({required int id}) async {
    return await _productAPI.show(id);
  }

  Future<List<Review>> getReviews({required int id}) async {
    return await Future.delayed(const Duration(seconds: 3), () => [
      Review(comment: "My First Comment", ownerFullName: "Ahmad Shahal"),
      Review(comment: "My Second Comment", ownerFullName: "Ahmad Shahal"),
      Review(comment: "My Third Comment", ownerFullName: "Ahmad Shahal"),
      Review(comment: "My Fourth Comment", ownerFullName: "Ahmad Shahal"),
    ]);
  }
}
