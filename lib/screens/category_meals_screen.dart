import 'package:flutter/material.dart';
import 'package:job_solution/dummy_data.dart';
import 'package:job_solution/models/meal.dart';
import 'package:job_solution/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static final routeName = '/category';
  final List<Meal> availableMeal;
  CategoryMealsScreen(this.availableMeal);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {


  String categoryTitle;
  List<Meal> displydeMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routeArgs =
      ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displydeMeals = widget.availableMeal.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;

    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
      setState(() {
        displydeMeals.removeWhere((meal) => meal.id == mealId);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: displydeMeals[index].id,
                title: displydeMeals[index].title,
                imageUrl: displydeMeals[index].imageUrl,
                duration: displydeMeals[index].duration,
                complexity: displydeMeals[index].complexity,
                affordability: displydeMeals[index].affordability,
            );
          },
          itemCount: displydeMeals.length,
        ),
    );
  }
}
