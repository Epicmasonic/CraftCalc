namespace Project_Program
{
    public partial class Form1 : Form
    {

        public Form1()
        {
            InitializeComponent();
        }

        // Recipe Builder
        Item[] builderIn = [];
        Item[] builderOut = [];
        Recipe[] recipeBook = [];

        static string ToTitle/*Case*/(string text)
        {
            if (text != string.Empty) {
                text = text.ToLower();

                string firstLetter = text.Remove(1);
                string otherLetters = text.Remove(0, 1);

                return firstLetter.ToUpper() + otherLetters;
            }
            return text;
        }

        static int FindItem(String chosenItem, Item[] inventory)
        {
            foreach (Item item in inventory)
            {
                if (item.Type == chosenItem)
                {
                    return Array.IndexOf(inventory, item);
                }
            }

            return -1;
        }
        static Item[] AddItem(Item chosenItem, Item[] inventory, bool isSubtract = false)
        {
            int insertSpot = inventory.Length;

            if (isSubtract)
            {
                chosenItem.Amount = -chosenItem.Amount;
            }

            for (int i = 0; i < insertSpot; i++)
            {
                if (inventory[i].Type == chosenItem.Type)
                {
                    inventory[i].Amount = inventory[i].Amount + chosenItem.Amount;

                    return inventory;
                }
            }

            Array.Resize(ref inventory, insertSpot + 1);
            inventory[insertSpot] = chosenItem;

            return inventory;
        }
        static Item[] RemoveItem(String chosenItem, Item[] inventory)
        {
            Item[] updatedInventory = [];
            int index = FindItem(chosenItem, inventory);

            for (int i = 0; i < inventory.Length; i++)
            {
                if (i == index)
                {
                    // Skip it!
                }
                else
                {
                    Array.Resize(ref updatedInventory, updatedInventory.Length + 1);
                    updatedInventory[updatedInventory.Length - 1] = inventory[i];
                }
            }

            return updatedInventory;
        }

        static int FindRecipeName(String chosenRecipe, Recipe[] book)
        {
            foreach (Recipe recipe in book)
            {
                if (recipe.Name == chosenRecipe)
                {
                    return Array.IndexOf(book, recipe);
                }
            }

            return -1;
        }
        static Recipe[] AddRecipe(Recipe chosenRecipe, Recipe[] book)
        {
            int insertSpot = book.Length;

            for (int i = 0; i < insertSpot; i++)
            {
                if (book[i].Name == chosenRecipe.Name || book[i].MainOutput == chosenRecipe.MainOutput)
                {
                    book[i] = chosenRecipe;

                    return book;
                }
            }

            Array.Resize(ref book, insertSpot + 1);
            book[insertSpot] = chosenRecipe;

            return book;
        }
        static Recipe[] RemoveRecipe(String chosenRecipe, Recipe[] book)
        {
            Recipe[] updatedBook = [];
            int index = FindRecipeName(chosenRecipe, book);

            for (int i = 0; i < book.Length; i++)
            {
                if (i == index)
                {
                    // Skip it!
                }
                else
                {
                    Array.Resize(ref updatedBook, updatedBook.Length + 1);
                    updatedBook[updatedBook.Length - 1] = book[i];
                }
            }

            return updatedBook;
        }

        private void UpdateRecipeList()
        {
            recipeBookLst.Items.Clear();
            foreach (Recipe recipe in recipeBook)
            {
                recipeBookLst.Items.Add(recipe.Name);
            }
        }
        private void UpdateInputList()
        {
            recipeBuilderInLst.Items.Clear();
            foreach (Item item in builderIn)
            {
                recipeBuilderInLst.Items.Add(item.Stringify());
            }
        }
        private void UpdateOutputList()
        {
            recipeBuilderOutLst.Items.Clear();
            foreach (Item item in builderOut)
            {
                recipeBuilderOutLst.Items.Add(item.Stringify());
            }
        }

        private void importRecipeBtn_Click(object sender, EventArgs e)
        {
            recipeNameTxt.Text = ToTitle(recipeNameTxt.Text);
            recipeOutputTxt.Text = ToTitle(recipeOutputTxt.Text);

            if (addModeRad.Checked)
            {
                if (recipeNameTxt.Text == string.Empty)
                {
                    consoleLbl.Text = "(Fill in 'Recipe Name') What should your new recipe be called?";
                }
                else if (recipeOutputTxt.Text == string.Empty)
                {
                    consoleLbl.Text = "(Fill in 'Main Output') What do you want this reicpe to be used for?";
                }
                else if (builderIn.Length == 0)
                {
                    consoleLbl.Text = "(Create an input) Your recipe has no inputs!";
                }
                else if (builderOut.Length == 0)
                {
                    consoleLbl.Text = "(Create an output) Your recipe has no outputs!";
                }
                else if (!CheckItemExists(recipeOutputTxt.Text, builderOut))
                {
                    consoleLbl.Text = "(Main output missing) Your recipe doesn't output it's main output? How does that make sense!";
                }
                else
                {
                    consoleLbl.Text = "";

                    Recipe creation = new Recipe
                    {
                        Name = recipeNameTxt.Text,
                        MainOutput = recipeOutputTxt.Text,
                        Inputs = builderIn,
                        Outputs = builderOut
                    };
                    recipeBook = AddRecipe(creation, recipeBook);
                    builderIn = [];
                    builderOut = [];

                    UpdateRecipeList();
                    UpdateInputList();
                    UpdateOutputList();
                }
            }
            else if (recipeNameTxt.Text == string.Empty)
            {
                consoleLbl.Text = "(Fill 'Recipe Name' in) What recipe do you want to remove?";
            }
            else
            {
                recipeBook = RemoveRecipe(recipeNameTxt.Text, recipeBook);

                UpdateRecipeList();
            }
        }
        private void importInputBtn_Click(object sender, EventArgs e)
        {
            recipeTypeTxt.Text = ToTitle(recipeTypeTxt.Text);

            if (addModeRad.Checked)
            {
                bool isNumber = float.TryParse(recipeAmountTxt.Text, out _); // Check if recipeAmountTxt.Text is a number (For safety)

                if (recipeTypeTxt.Text == string.Empty)
                {
                    consoleLbl.Text = "(Fill in 'Item Type') What item do you need for this recipe?";
                }
                else if (recipeAmountTxt.Text == string.Empty)
                {
                    consoleLbl.Text = "(Fill in 'Item Amount') How much of the item do you need for this recipe?";
                }
                else if (!isNumber)
                {
                    consoleLbl.Text = "('Item Amount' must be a number) I can't store " + recipeAmountTxt.Text + " items in a chest!?";
                }
                else
                {
                    consoleLbl.Text = "";
                    Item creation = new Item
                    {
                        Type = recipeTypeTxt.Text,
                        Amount = float.Parse(recipeAmountTxt.Text)
                    };
                    builderIn = RemoveItem(creation.Type, builderIn);
                    builderIn = AddItem(creation, builderIn);

                    UpdateInputList();
                }
            }
            else if (recipeTypeTxt.Text == string.Empty)
            {
                consoleLbl.Text = "(Fill 'Item Type' in) What input do you want to remove?";
            }
            else
            {
                consoleLbl.Text = "";
                builderIn = RemoveItem(recipeTypeTxt.Text, builderIn);

                UpdateInputList();
            }
        }
        private void importOutputBtn_Click(object sender, EventArgs e)
        {
            recipeTypeTxt.Text = ToTitle(recipeTypeTxt.Text);

            if (addModeRad.Checked)
            {
                bool isNumber = float.TryParse(recipeAmountTxt.Text, out _); // Check if recipeAmountTxt.Text is a number (For safety)

                if (recipeTypeTxt.Text == string.Empty)
                {
                    consoleLbl.Text = "(Fill in 'Item Type') What item does this recipe make?";
                }
                else if (recipeAmountTxt.Text == string.Empty)
                {
                    consoleLbl.Text = "(Fill in 'Item Amount') How much of the item are made from this recipe?";
                }
                else if (!isNumber)
                {
                    consoleLbl.Text = "('Item Amount' must be a number) I can't store " + recipeAmountTxt.Text + " items in a chest!?";
                }
                else
                {
                    consoleLbl.Text = "";
                    Item creation = new Item
                    {
                        Type = recipeTypeTxt.Text,
                        Amount = float.Parse(recipeAmountTxt.Text)
                    };
                    builderOut = RemoveItem(creation.Type, builderOut);
                    builderOut = AddItem(creation, builderOut);

                    UpdateOutputList();
                }
            }
            else if (recipeTypeTxt.Text == string.Empty)
            {
                consoleLbl.Text = "(Fill 'Item Type' in) What output do you want to remove?";
            }
            else
            {
                consoleLbl.Text = "";
                builderOut = RemoveItem(recipeTypeTxt.Text, builderOut);

                UpdateOutputList();

            }
        }

        private void viewRecipeBtn_Click(object sender, EventArgs e)
        {
            recipeNameTxt.Text = ToTitle(recipeNameTxt.Text);

            if (recipeNameTxt.Text == string.Empty)
            {
                consoleLbl.Text = "(Fill in 'Recipe Name') What recipe are you looking for?";
            }
            else if (FindRecipeName(recipeNameTxt.Text, recipeBook) == -1)
            {
                consoleLbl.Text = "(Recipe missing) I don't seem to know that recipe...";
            }
            else
            {
                Recipe recipe = recipeBook[FindRecipeName(recipeNameTxt.Text, recipeBook)];

                recipeOutputTxt.Text = recipe.MainOutput;
                builderIn = recipe.Inputs;
                builderOut = recipe.Outputs;

                UpdateInputList();
                UpdateOutputList();
            }
        }

        // Calculate Tab

        Item[] workingInventory = [];
        Item[] wishList = [];

        static int FindRecipeItem(String requiredItem, Recipe[] book)
        {
            foreach (Recipe recipe in book)
            {
                if (recipe.MainOutput == requiredItem)
                {
                    return Array.IndexOf(book, recipe);
                }
            }

            return -1;
        }
        static bool CheckItemAmount(Item check, Item[] inventory)
        {
            foreach (Item item in inventory)
            {
                if (item.Type == check.Type && item.Amount >= check.Amount)
                {
                    return true;
                }
            }

            return false;
        }
        static bool CheckItemExists(string check, Item[] inventory)
        {
            foreach (Item item in inventory)
            {
                if (item.Type == check)
                {
                    return true;
                }
            }

            return false;
        }

        private void UseRecipe(Recipe recipe)
        {
            foreach (var item in recipe.Inputs)
            {
                Item temp = new Item // <-- Vodo magic
                {
                    Type = item.Type,
                    Amount = item.Amount
                };

                workingInventory = AddItem(temp, workingInventory, true);
            }

            foreach (var item in recipe.Outputs)
            {
                Item temp = new Item // <-- Vodo magic 2
                {
                    Type = item.Type,
                    Amount = item.Amount
                };

                wishList = AddItem(temp, wishList, true);

            } // FWI the "Vodo magic" here is trying to stop this method from editing "recipeBook" (Why is it doing that though? Shouldn't it just be changing "recipe" and not stalking the data home to edit it's origins!?)
        }
        private void CleanLists()
        {
            foreach (var item in workingInventory)
            {
                if (item.Amount < 0)
                {
                    workingInventory = RemoveItem(item.Type, workingInventory);

                    item.Amount *= -1;
                    wishList = AddItem(item, wishList);
                }
                else if (item.Amount == 0)
                {
                    workingInventory = RemoveItem(item.Type, workingInventory);
                }
            }

            foreach (var item in wishList)
            {
                if (item.Amount < 0)
                {
                    wishList = RemoveItem(item.Type, wishList);

                    item.Amount *= -1;
                    workingInventory = AddItem(item, workingInventory);
                }
                else if (item.Amount == 0)
                {
                    wishList = RemoveItem(item.Type, wishList);
                }
            }
        }

        private void UpdateRequiredList(Item[] inventory)
        {
            requiredLst.Items.Clear();
            foreach (Item item in inventory)
            {
                if (float.Round(item.Amount, 2) != 0)
                {
                    requiredLst.Items.Add(item.Stringify());
                }
            }
        }
        private void UpdateLeftoverList(Item[] inventory)
        {
            leftoverLst.Items.Clear();
            foreach (Item item in inventory)
            {
                if (float.Round(item.Amount, 2) != 0)
                {
                    leftoverLst.Items.Add(item.Stringify());
                }
            }
        }

        private void craftBtn_Click(object sender, EventArgs e)
        {
            requestTypeTxt.Text = ToTitle(requestTypeTxt.Text);
            bool isNumber = float.TryParse(requestAmountTxt.Text, out _); // Check if requestAmountTxt.Text is a number (For safety)

            if (requestTypeTxt.Text == string.Empty)
            {
                consoleLbl.Text = "(Fill 'Requested Item' in) What item do you want to craft?";
            }
            else if (requestAmountTxt.Text == string.Empty)
            {
                consoleLbl.Text = "(Fill 'Requested Amount' in) How many do you want to craft?";
            }
            else if (!isNumber)
            {
                consoleLbl.Text = "('Requested Amount' must be a number) I can't store " + requestAmountTxt.Text + " items in a chest!?";
            }
            else
            {
                Item creation = new Item
                {
                    Type = requestTypeTxt.Text,
                    Amount = float.Parse(requestAmountTxt.Text)
                };

                workingInventory = [];
                wishList = [];
                Array.Resize(ref wishList, 1);
                wishList[0] = creation;

                bool hasLooped = true;
                while (hasLooped)
                {
                    hasLooped = false;
                    foreach (var item in wishList)
                    {
                        int index = FindRecipeItem(item.Type, recipeBook);
                        if (index >= 0 && !CheckItemAmount(item, workingInventory))
                        {
                            UseRecipe(recipeBook[index]);
                            hasLooped = true;
                        }
                    }
                    CleanLists();
                }

                creation = new Item
                {
                    Type = requestTypeTxt.Text,
                    Amount = float.Parse(requestAmountTxt.Text)
                };

                // I have no clue how the these arrays ended up flipping meanings... but if it works, it works!
                // The comment above is a lie! It doesn't work!!! >:/ I just tried a recipe with a byproduct and it put the byproduct in the wrong list! Ugh... (It passed the double wooden axe test though, So it's doing better than the lua version in that regard? (The lua version didn't get tripped up with byproducts though so...))
                // Alright, It can now handle washing gravel but it can't handle pressing the nuggets from that into ingots...
                // There we go! I fixed it by moving the early exit from the last comment's fix from the "while" to the "if"
                workingInventory = AddItem(creation, workingInventory);
                UpdateRequiredList(wishList);
                UpdateLeftoverList(workingInventory);
            }
        }
    }
}