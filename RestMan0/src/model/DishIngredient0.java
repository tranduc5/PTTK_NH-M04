package model;

/** DishIngredient0 - lop thuc the (theo thiet ke D1/D4) */
public class DishIngredient0 {
    private int id;
    private double quantity;
    private int dishId;
    private int ingredientId;

    public DishIngredient0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }
    public int getDishId() { return dishId; }
    public void setDishId(int dishId) { this.dishId = dishId; }
    public int getIngredientId() { return ingredientId; }
    public void setIngredientId(int ingredientId) { this.ingredientId = ingredientId; }
}
