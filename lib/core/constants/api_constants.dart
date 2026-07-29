class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1/';
  static const String categories = 'home/categories';
  static const String products = 'home/products';
  static final String signin = "auth/signIn";
  static final String signup = "auth/signUp";
  static String productsByCategory(String slug) =>
      "home/products/category/$slug?skip=0&limit=5";
  static final String account = "portfoilo/userData";
  static final String updateAccount = "portfoilo/editUserData";
  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNmEyNmI1M2IzY2U3OGFjZDA2YzgzNiIsImlhdCI6MTc4NTM0MTY4MSwiZXhwIjoxNzg3OTMzNjgxfQ.yKfCPVHv1_xyKeOCnco-BwbrM7xyB-mzbe32Bd1JRqQ";
}
