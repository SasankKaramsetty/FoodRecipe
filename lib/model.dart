class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late double appcalories;
  late String appurl;
  late List<Ingredient> appIngredients;
  late List<String> appSteps;
  late double apptime;

  RecipeModel({
    this.applabel = "LABEL",
    this.appcalories = 0.0,
    this.appimgUrl = "IMAGE",
    this.appurl = "URL",
    required this.appIngredients,
    required this.appSteps,
    required this.apptime, 
  });

  factory RecipeModel.fromMap(Map? recipe) {
    return RecipeModel(
      applabel: recipe?["label"] ?? "LABEL",
      appcalories: (recipe?["calories"] ?? 0).toDouble(),
      appimgUrl: recipe?["image"] ?? "IMAGE",
      appurl: recipe?["url"] ?? "URL",
      apptime: recipe?["totalTime"],
      appIngredients: List<Ingredient>.from(
        (recipe?["ingredients"] as List<dynamic>? ?? [])
            .map((ingredient) => Ingredient.fromMap(ingredient)),
      ),
      appSteps:
          List<String>.from(recipe?["steps"] ?? []), 
    );
  }
}

class Ingredient {
  late String text;
  late double quantity;
  late String? measure; 
  late String food;
  late double weight;
  late String image;
  late List<String> steps;

  Ingredient({
    required this.text,
    required this.quantity,
    required this.food,
    required this.weight,
    required this.image,
    required List<String>? steps,
    this.measure,
  }) : steps = steps ?? [];

  factory Ingredient.fromMap(Map? ingredient) {
    return Ingredient(
      text: ingredient?["text"] ?? "",
      quantity: (ingredient?["quantity"] ?? 0).toDouble(),
      food: ingredient?["food"] ?? "",
      weight: (ingredient?["weight"] ?? 0).toDouble(),
      image: ingredient?["image"] ?? "",
      steps: List<String>.from(ingredient?["steps"] ?? []),
      measure: _handleMeasure(ingredient?["measure"]),
    );
  }

  static String? _handleMeasure(dynamic measure) {
    if (measure is String && measure.toLowerCase() == "<unit>") {
      return null; 
    }
    return measure?.toString();
  }
}
