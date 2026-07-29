class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1/';
  static const String categories = 'home/categories';
  static const String products = 'home/products';
  static final String signin = "auth/signIn";
  static final String signup = "auth/signUp";
  static String productsByCategory(String slug)=>"home/products/category/$slug?skip=0&limit=5";
  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjUwMDg4NWNjYzdlODkwMzMzNjUzNSIsImlhdCI6MTc4NTAyMzIxOSwiZXhwIjoxNzg3NjE1MjE5fQ.BwPUqDvzIvht2Kf-Ym1iQhpPQcZeBTfKJAGes3PLDG0";
  static const search="home/productsFilter";
  static  String productsDetails(int id) => 'home/products';
}
