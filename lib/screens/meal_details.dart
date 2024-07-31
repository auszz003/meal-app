import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(
      {super.key, required this.meal, required this.ontoggleFavorite});
  final Meal meal;
  final void Function(Meal meal) ontoggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            meal.title,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border_outlined),
              onPressed: () {
                ontoggleFavorite(meal);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Ingredients",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(
                height: 10,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: TextStyle(
                      fontSize: 16,
                      //fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Steps",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(
                height: 10,
              ),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    step,
                    style: TextStyle(
                        fontSize: 16,
                        //fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
