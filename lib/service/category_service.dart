import 'package:ChallengeApp/Model/Categorymodel.dart';
import 'package:ChallengeApp/repository/repository.dart';

class CategoryService{
  Repository _repository;

  CategoryService(){
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.insertData('categories',category.categoryMap());
  }

  readCategories() async {
   return await _repository.readData('categories');
  }

  deleteCategory(categoryId) async {
    return await _repository.deleteData('categories', categoryId);
  }
}