class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1/';
  static const String categories = 'home/categories';
  static const String products = 'home/products';
  static final String signin = "auth/signIn";
  static final String signup = "auth/signUp";
  // static const String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNmEyZGU1M2IzY2U3OGFjZDA2YzhhMCIsImlhdCI6MTc4NTM0MzQ3MCwiZXhwIjoxNzg3OTM1NDcwfQ.jS2Ur1x63JjHRzmbJSUhEtJq1xGoQCBsCVgOuYTLYOQ";
  static String addCart = "user/addCart";
  static String getCart = "user/getCart";
  static String deleteCart = "user/deleteCart";
  static String addToFavourite = "user/addFavorite";
  static String getFavourite = "user/getFavorite";
  static String deleteFavourite = "user/deleteFavorite";
  static final String signIn = "auth/signIn";
  static final String signUp = "auth/signUp";
  static String productsByCategory(String slug) =>
      "home/products/category/$slug?skip=0&limit=5";
  static const search = "home/productsFilter";
  static String productsDetails(int id) => 'home/products/$id';
  static final String account = "portfoilo/userData";
  static final String updateAccount = "portfoilo/editUserData";
  static const String uploadImage = "portfoilo/addImage";
}