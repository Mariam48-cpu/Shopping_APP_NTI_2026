class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1/';
  static const String categories = 'home/categories';
  static const String products = 'home/products';
  static final String signin = "auth/signIn";
  static final String signup = "auth/signUp";
  static String productsByCategory(String slug) =>
      "home/products/category/$slug?skip=0&limit=5";
  static final String account = "portfoilo/userData";
  static final String updateAccount = "portfoilo/addImage";
  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjc0YmYzNGU0ZDg0ZGE3NTVkZWExMSIsImlhdCI6MTc4NTI3OTg4NywiZXhwIjoxNzg3ODcxODg3fQ.n-Mhhb2Gc-0KorIbMVAc0ata8L7-bC1LbMxwxz-J7rI";
}
