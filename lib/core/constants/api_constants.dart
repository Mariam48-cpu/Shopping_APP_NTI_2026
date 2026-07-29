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
  static const String uploadImage = "portfoilo/addImage";
  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNmE0ZTI0M2IzY2U3OGFjZDA2Y2EwMSIsImlhdCI6MTc4NTM1MTczNiwiZXhwIjoxNzg3OTQzNzM2fQ.NcIhayjgYpxTki1jmrmVnEwnMj0b-2SuIhNBxRHYXOc";
}
