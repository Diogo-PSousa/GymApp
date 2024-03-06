import 'package:fit_friend/MealsDatabase.dart';
import 'package:fit_friend/customAppBar.dart';
import 'package:flutter/material.dart';

class MealsListPage extends StatefulWidget {
  static const routeName = '/MealsListPage';

  const MealsListPage({super.key});

  @override
  MealsListPageState createState() => MealsListPageState();
}

class MealsListPageState extends State<MealsListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _meals = [];

  @override
  void initState() {
    super.initState();
    _getMeals();
  }

  void _getMeals() async {
    final meals = await MealsDatabase.instance.readAll();
    setState(() {
      _meals = meals;
    });
  }

  void _searchMeals(String searchText) async {
    final meals = await MealsDatabase.instance.searchByName(searchText);
    setState(() {
      _meals = meals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("search food"),
              controller: _searchController,
              onChanged: _searchMeals, // Added onChanged property
              decoration: const InputDecoration(
                hintText: 'Search by name',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _meals.length,
              itemBuilder: (BuildContext context, int index) {
                final meal = _meals[index];
                return Card(
                  child: GestureDetector(
                    child: ListTile(
                      title: Text(meal['name']),
                      subtitle: Text(
                        'Calories: ${meal['calories']}, '
                            'Lipids: ${meal['lipids']}, '
                            'Carbohydrates: ${meal['carbohydrates']}, '
                            'Proteins: ${meal['proteins']}',
                      ),
                      trailing: IconButton(
                        key: const Key("choose food"),
                        onPressed: () async {
                          int calories = meal['calories'] as int;
                          int grams = await showDialog(
                            context: context,
                            builder: (context) =>
                                AddMealDialog(mealName: meal['name']),
                          );
                          if (grams > 0) {
                            double calculatedCalories =
                                grams * calories / 100;
                            Navigator.pop(context, {
                              'meal': meal,
                              'calculatedCalories': calculatedCalories
                            });
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class AddMealDialog extends StatefulWidget {
  final String mealName;

  const AddMealDialog({super.key, required this.mealName});

  @override
  _AddMealDialogState createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final TextEditingController _gramsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add ${widget.mealName}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('How many grams?'),
          const SizedBox(height: 8),
          TextField(
            key: const Key("enter food quantity"),
            controller: _gramsController,
            keyboardType: TextInputType.number,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
            child: const Text('Cancel', style: TextStyle(color: Colors.red),),
        ),
        TextButton(
          key: const Key("Ok button"),
          onPressed: (){
            int grams = int.tryParse(_gramsController.text) ?? 0;
            Navigator.of(context).pop(grams);
        },
          child: const Text('Ok', style: TextStyle(color: Colors.red),),
        )
      ],
    );
  }
}