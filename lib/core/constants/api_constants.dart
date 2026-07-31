class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1/';
  static const String categories = 'home/categories';
  static const String products = 'home/products';
  static final String signIn = "auth/signIn";
  static final String signUp = "auth/signUp";
  static String productsByCategory(String slug) =>
      "home/products/category/$slug?skip=0&limit=5";
  static const search = "home/productsFilter";
  static String productsDetails(int id) => 'home/products/$id';
}
