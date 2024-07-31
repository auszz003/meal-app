import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kInialFilters = {
  Filters.gluttenfree: false,
  Filters.lactosefree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int selectedPageIndex = 0;
  final List<Meal> favoriteMeal = [];
  Map<Filters, bool> selectedFilters = kInialFilters;

  void selectedScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            currentFilters: selectedFilters,
          ),
        ),
      );
      selectedFilters = result ?? kInialFilters;
    }
  }

  void showMessage(String Message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Message),
      ),
    );
  }

  void selectedPage(int index) {
    setState(
      () {
        selectedPageIndex = index;
      },
    );
  }

  void toggleFavourite(Meal meal) {
    final isExisting = favoriteMeal.contains(meal);

    if (isExisting) {
      setState(() {
        favoriteMeal.remove(meal);
      });
      showMessage("Meal is no longer favorite!");
    } else {
      setState(
        () {
          favoriteMeal.add(meal);
        },
      );
      showMessage("Meal marked as favorite!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where(
      (meal) {
        if (selectedFilters[Filters.gluttenfree]! && !meal.isGlutenFree) {
          return false;
        }
        if (selectedFilters[Filters.lactosefree]! && !meal.isLactoseFree) {
          return false;
        }
        if (selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (selectedFilters[Filters.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();

    Widget activePage = CategoriesScreen(
      ontoggleFavorite: toggleFavourite,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeal,
        ontoggleFavorite: toggleFavourite,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: selectedScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}
