using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project_Program
{
    internal class Recipe
    {
        public required string Name { get; set; }
        public required string MainOutput { get; set; }
        public required Item[] Inputs { get; set; }
        public required Item[] Outputs { get; set; }
        /*
        public Recipe(string name, string mainItem, Item[] consume, Item[] produce)
        {
            Name = name;
            MainOutput = mainItem;
            Inputs = consume;
            Outputs = produce;
        }
        */
    }
}
