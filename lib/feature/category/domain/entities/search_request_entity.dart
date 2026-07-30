class SearchRequestEntity {
  String search;
  int skip;
  int limit;

  SearchRequestEntity({this.search = '', this.skip = 0, this.limit = 5});
}
