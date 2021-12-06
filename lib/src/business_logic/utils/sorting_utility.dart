import 'package:tawfeer/src/business_logic/models/product.dart';

class SortingUtility {
  static List<Product> sortByPrice(List<Product> list) {
    list.sort((Product a, Product b) {
      if (a.newPrice > b.newPrice) {
        return 1;
      } else if (a.newPrice < b.newPrice) {
        return -1;
      }
      return 0;
    });
    return list;
  }

  static List<Product> sortByViews(List<Product> list) {
    list.sort((Product a, Product b) {
      if (a.seens > b.seens) {
        return 1;
      } else if (a.seens < b.seens) {
        return -1;
      }
      return 0;
    });
    return list.reversed.toList();
  }
}
