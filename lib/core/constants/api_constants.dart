class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1/';
  static const String categories = 'home/categories';
  static const String products = 'home/products';
  static final String signin = "auth/signIn";
  static final String signup = "auth/signUp";
  static String productsByCategory(String slug)=>"home/products/category/$slug?skip=0&limit=5";
  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjdhYzFkOGI3OGVhZTUzZjM0Yjg2YyIsImlhdCI6MTc4NTIwMDU1MiwiZXhwIjoxNzg3NzkyNTUyfQ.QeeQbW1pQzBM3DzxpYXW0bMw_pxvaLMCV0xrxD1F2a4";
   static String addCart = "user/addCart";
   static String getCart = "user/getCart";
   static String deleteCart = "user/deleteCart";
}
