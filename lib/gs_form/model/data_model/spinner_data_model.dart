class SpinnerDataModel {
  String name;
  int id;
  bool? isSelected;
  dynamic data;


  SpinnerDataModel({required this.name, required this.id, this.data, bool ?isSelected})
      : isSelected = isSelected ?? false ;
}
