import 'package:tawfeer/src/business_logic/models/product.dart';

class SortingUtility {

  static List<Product> sortBy(List<Product> list, int sortIndex) {
    if(sortIndex == 0) {
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
    else if(sortIndex == 1) {
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
    // TODO: sortByDate
    return list;
  }
}
