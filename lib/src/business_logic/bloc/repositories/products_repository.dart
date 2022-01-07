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
    return await _productAPI.getReviews(id);
  }

  Future<void> addReview({required String comment, required int id}) async {
    return await _productAPI.addReview(comment, id);
  }
}
