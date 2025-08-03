using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project_Program
{
    internal class Item
    {
        public required string Type { get; set; }
        public required float Amount { get; set; } // It's a float insted of an int due to some recipes haveing chance based outputs
        /*
        public Item(string item, float amount)
        {
            Type = item;
            Amount = amount;
        }
        */

        public string Stringify()
        {
            return Type + " x" + float.Round(Amount, 2).ToString();
        }
    }
}
