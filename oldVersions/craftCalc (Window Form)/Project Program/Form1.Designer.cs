namespace Project_Program
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            tabControl1 = new TabControl();
            editPge = new TabPage();
            viewRecipeBtn = new Button();
            recipeBuilderOutLbl = new Label();
            recipeBuilderOutLst = new ListBox();
            removeModeRad = new RadioButton();
            addModeRad = new RadioButton();
            recipeOutputTxt = new TextBox();
            recipeOutputLbl = new Label();
            importOutputBtn = new Button();
            importRecipeBtn = new Button();
            importInputBtn = new Button();
            recipeAmountLbl = new Label();
            recipeTypeTxt = new TextBox();
            recipeTypeLbl = new Label();
            recipeNameLbl = new Label();
            recipeBuilderInLbl = new Label();
            recipeBuilderInLst = new ListBox();
            recipeAmountTxt = new TextBox();
            recipeNameTxt = new TextBox();
            recipeBookLbl = new Label();
            recipeBookLst = new ListBox();
            craftPge = new TabPage();
            craftBtn = new Button();
            label1 = new Label();
            requiredLbl = new Label();
            leftoverLst = new ListBox();
            requiredLst = new ListBox();
            requestAmountLbl = new Label();
            requestTypeTxt = new TextBox();
            requestTypeLbl = new Label();
            requestAmountTxt = new TextBox();
            consoleLbl = new Label();
            tabControl1.SuspendLayout();
            editPge.SuspendLayout();
            craftPge.SuspendLayout();
            SuspendLayout();
            // 
            // tabControl1
            // 
            tabControl1.Controls.Add(editPge);
            tabControl1.Controls.Add(craftPge);
            tabControl1.Location = new Point(12, 12);
            tabControl1.Name = "tabControl1";
            tabControl1.SelectedIndex = 0;
            tabControl1.Size = new Size(776, 418);
            tabControl1.TabIndex = 0;
            // 
            // editPge
            // 
            editPge.Controls.Add(viewRecipeBtn);
            editPge.Controls.Add(recipeBuilderOutLbl);
            editPge.Controls.Add(recipeBuilderOutLst);
            editPge.Controls.Add(removeModeRad);
            editPge.Controls.Add(addModeRad);
            editPge.Controls.Add(recipeOutputTxt);
            editPge.Controls.Add(recipeOutputLbl);
            editPge.Controls.Add(importOutputBtn);
            editPge.Controls.Add(importRecipeBtn);
            editPge.Controls.Add(importInputBtn);
            editPge.Controls.Add(recipeAmountLbl);
            editPge.Controls.Add(recipeTypeTxt);
            editPge.Controls.Add(recipeTypeLbl);
            editPge.Controls.Add(recipeNameLbl);
            editPge.Controls.Add(recipeBuilderInLbl);
            editPge.Controls.Add(recipeBuilderInLst);
            editPge.Controls.Add(recipeAmountTxt);
            editPge.Controls.Add(recipeNameTxt);
            editPge.Controls.Add(recipeBookLbl);
            editPge.Controls.Add(recipeBookLst);
            editPge.Location = new Point(4, 29);
            editPge.Name = "editPge";
            editPge.Padding = new Padding(3);
            editPge.Size = new Size(768, 385);
            editPge.TabIndex = 0;
            editPge.Text = "Edit Recipes";
            editPge.UseVisualStyleBackColor = true;
            // 
            // viewRecipeBtn
            // 
            viewRecipeBtn.Location = new Point(6, 347);
            viewRecipeBtn.Name = "viewRecipeBtn";
            viewRecipeBtn.Size = new Size(225, 29);
            viewRecipeBtn.TabIndex = 21;
            viewRecipeBtn.Text = "View Recipe";
            viewRecipeBtn.UseVisualStyleBackColor = true;
            viewRecipeBtn.Click += viewRecipeBtn_Click;
            // 
            // recipeBuilderOutLbl
            // 
            recipeBuilderOutLbl.AutoSize = true;
            recipeBuilderOutLbl.Location = new Point(237, 249);
            recipeBuilderOutLbl.Name = "recipeBuilderOutLbl";
            recipeBuilderOutLbl.Size = new Size(61, 20);
            recipeBuilderOutLbl.TabIndex = 20;
            recipeBuilderOutLbl.Text = "Outputs";
            // 
            // recipeBuilderOutLst
            // 
            recipeBuilderOutLst.FormattingEnabled = true;
            recipeBuilderOutLst.Location = new Point(237, 272);
            recipeBuilderOutLst.Name = "recipeBuilderOutLst";
            recipeBuilderOutLst.Size = new Size(225, 104);
            recipeBuilderOutLst.Sorted = true;
            recipeBuilderOutLst.TabIndex = 19;
            // 
            // removeModeRad
            // 
            removeModeRad.AutoSize = true;
            removeModeRad.Location = new Point(669, 281);
            removeModeRad.Name = "removeModeRad";
            removeModeRad.RightToLeft = RightToLeft.Yes;
            removeModeRad.Size = new Size(93, 24);
            removeModeRad.TabIndex = 17;
            removeModeRad.Text = "...Remove";
            removeModeRad.UseVisualStyleBackColor = true;
            // 
            // addModeRad
            // 
            addModeRad.AutoSize = true;
            addModeRad.Checked = true;
            addModeRad.Location = new Point(468, 281);
            addModeRad.Name = "addModeRad";
            addModeRad.RightToLeft = RightToLeft.No;
            addModeRad.Size = new Size(82, 24);
            addModeRad.TabIndex = 16;
            addModeRad.TabStop = true;
            addModeRad.Text = "Create...";
            addModeRad.UseVisualStyleBackColor = true;
            // 
            // recipeOutputTxt
            // 
            recipeOutputTxt.Location = new Point(468, 85);
            recipeOutputTxt.Name = "recipeOutputTxt";
            recipeOutputTxt.Size = new Size(294, 27);
            recipeOutputTxt.TabIndex = 15;
            // 
            // recipeOutputLbl
            // 
            recipeOutputLbl.AutoSize = true;
            recipeOutputLbl.Location = new Point(468, 62);
            recipeOutputLbl.Name = "recipeOutputLbl";
            recipeOutputLbl.Size = new Size(92, 20);
            recipeOutputLbl.TabIndex = 14;
            recipeOutputLbl.Text = "Main Output";
            // 
            // importOutputBtn
            // 
            importOutputBtn.Location = new Point(618, 347);
            importOutputBtn.Name = "importOutputBtn";
            importOutputBtn.Size = new Size(144, 29);
            importOutputBtn.TabIndex = 13;
            importOutputBtn.Text = "...Output";
            importOutputBtn.UseVisualStyleBackColor = true;
            importOutputBtn.Click += importOutputBtn_Click;
            // 
            // importRecipeBtn
            // 
            importRecipeBtn.Location = new Point(468, 311);
            importRecipeBtn.Name = "importRecipeBtn";
            importRecipeBtn.Size = new Size(294, 29);
            importRecipeBtn.TabIndex = 12;
            importRecipeBtn.Text = "...Recipe";
            importRecipeBtn.UseVisualStyleBackColor = true;
            importRecipeBtn.Click += importRecipeBtn_Click;
            // 
            // importInputBtn
            // 
            importInputBtn.Location = new Point(468, 347);
            importInputBtn.Name = "importInputBtn";
            importInputBtn.Size = new Size(144, 29);
            importInputBtn.TabIndex = 11;
            importInputBtn.Text = "...Input";
            importInputBtn.UseVisualStyleBackColor = true;
            importInputBtn.Click += importInputBtn_Click;
            // 
            // recipeAmountLbl
            // 
            recipeAmountLbl.AutoSize = true;
            recipeAmountLbl.Location = new Point(468, 168);
            recipeAmountLbl.Name = "recipeAmountLbl";
            recipeAmountLbl.Size = new Size(96, 20);
            recipeAmountLbl.TabIndex = 10;
            recipeAmountLbl.Text = "Item Amount";
            // 
            // recipeTypeTxt
            // 
            recipeTypeTxt.Location = new Point(468, 138);
            recipeTypeTxt.Name = "recipeTypeTxt";
            recipeTypeTxt.Size = new Size(294, 27);
            recipeTypeTxt.TabIndex = 9;
            // 
            // recipeTypeLbl
            // 
            recipeTypeLbl.AutoSize = true;
            recipeTypeLbl.Location = new Point(468, 115);
            recipeTypeLbl.Name = "recipeTypeLbl";
            recipeTypeLbl.Size = new Size(74, 20);
            recipeTypeLbl.TabIndex = 8;
            recipeTypeLbl.Text = "Item Type";
            // 
            // recipeNameLbl
            // 
            recipeNameLbl.AutoSize = true;
            recipeNameLbl.Location = new Point(468, 9);
            recipeNameLbl.Name = "recipeNameLbl";
            recipeNameLbl.Size = new Size(98, 20);
            recipeNameLbl.TabIndex = 7;
            recipeNameLbl.Text = "Recipe Name";
            // 
            // recipeBuilderInLbl
            // 
            recipeBuilderInLbl.AutoSize = true;
            recipeBuilderInLbl.Location = new Point(237, 9);
            recipeBuilderInLbl.Name = "recipeBuilderInLbl";
            recipeBuilderInLbl.Size = new Size(49, 20);
            recipeBuilderInLbl.TabIndex = 6;
            recipeBuilderInLbl.Text = "Inputs";
            // 
            // recipeBuilderInLst
            // 
            recipeBuilderInLst.FormattingEnabled = true;
            recipeBuilderInLst.Location = new Point(237, 32);
            recipeBuilderInLst.Name = "recipeBuilderInLst";
            recipeBuilderInLst.Size = new Size(225, 204);
            recipeBuilderInLst.Sorted = true;
            recipeBuilderInLst.TabIndex = 5;
            // 
            // recipeAmountTxt
            // 
            recipeAmountTxt.Location = new Point(468, 191);
            recipeAmountTxt.Name = "recipeAmountTxt";
            recipeAmountTxt.Size = new Size(294, 27);
            recipeAmountTxt.TabIndex = 4;
            // 
            // recipeNameTxt
            // 
            recipeNameTxt.Location = new Point(468, 32);
            recipeNameTxt.Name = "recipeNameTxt";
            recipeNameTxt.Size = new Size(294, 27);
            recipeNameTxt.TabIndex = 3;
            // 
            // recipeBookLbl
            // 
            recipeBookLbl.AutoSize = true;
            recipeBookLbl.Location = new Point(6, 9);
            recipeBookLbl.Name = "recipeBookLbl";
            recipeBookLbl.Size = new Size(109, 20);
            recipeBookLbl.TabIndex = 2;
            recipeBookLbl.Text = "Known Recipes";
            // 
            // recipeBookLst
            // 
            recipeBookLst.FormattingEnabled = true;
            recipeBookLst.Location = new Point(6, 32);
            recipeBookLst.Name = "recipeBookLst";
            recipeBookLst.Size = new Size(225, 304);
            recipeBookLst.Sorted = true;
            recipeBookLst.TabIndex = 1;
            // 
            // craftPge
            // 
            craftPge.Controls.Add(craftBtn);
            craftPge.Controls.Add(label1);
            craftPge.Controls.Add(requiredLbl);
            craftPge.Controls.Add(leftoverLst);
            craftPge.Controls.Add(requiredLst);
            craftPge.Controls.Add(requestAmountLbl);
            craftPge.Controls.Add(requestTypeTxt);
            craftPge.Controls.Add(requestTypeLbl);
            craftPge.Controls.Add(requestAmountTxt);
            craftPge.Location = new Point(4, 29);
            craftPge.Name = "craftPge";
            craftPge.Padding = new Padding(3);
            craftPge.Size = new Size(768, 385);
            craftPge.TabIndex = 1;
            craftPge.Text = "Craft Items";
            craftPge.UseVisualStyleBackColor = true;
            // 
            // craftBtn
            // 
            craftBtn.Location = new Point(6, 347);
            craftBtn.Name = "craftBtn";
            craftBtn.Size = new Size(294, 29);
            craftBtn.TabIndex = 19;
            craftBtn.Text = "CRAFT!";
            craftBtn.UseVisualStyleBackColor = true;
            craftBtn.Click += craftBtn_Click;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(537, 9);
            label1.Name = "label1";
            label1.Size = new Size(112, 20);
            label1.TabIndex = 18;
            label1.Text = "Produced Items";
            // 
            // requiredLbl
            // 
            requiredLbl.AutoSize = true;
            requiredLbl.Location = new Point(306, 9);
            requiredLbl.Name = "requiredLbl";
            requiredLbl.Size = new Size(109, 20);
            requiredLbl.TabIndex = 17;
            requiredLbl.Text = "Required Items";
            // 
            // leftoverLst
            // 
            leftoverLst.FormattingEnabled = true;
            leftoverLst.Location = new Point(537, 32);
            leftoverLst.Name = "leftoverLst";
            leftoverLst.Size = new Size(225, 344);
            leftoverLst.Sorted = true;
            leftoverLst.TabIndex = 16;
            // 
            // requiredLst
            // 
            requiredLst.FormattingEnabled = true;
            requiredLst.Location = new Point(306, 32);
            requiredLst.Name = "requiredLst";
            requiredLst.Size = new Size(225, 344);
            requiredLst.Sorted = true;
            requiredLst.TabIndex = 15;
            // 
            // requestAmountLbl
            // 
            requestAmountLbl.AutoSize = true;
            requestAmountLbl.Location = new Point(5, 62);
            requestAmountLbl.Name = "requestAmountLbl";
            requestAmountLbl.Size = new Size(136, 20);
            requestAmountLbl.TabIndex = 14;
            requestAmountLbl.Text = "Requested Amount";
            // 
            // requestTypeTxt
            // 
            requestTypeTxt.Location = new Point(6, 32);
            requestTypeTxt.Name = "requestTypeTxt";
            requestTypeTxt.Size = new Size(294, 27);
            requestTypeTxt.TabIndex = 13;
            // 
            // requestTypeLbl
            // 
            requestTypeLbl.AutoSize = true;
            requestTypeLbl.Location = new Point(6, 9);
            requestTypeLbl.Name = "requestTypeLbl";
            requestTypeLbl.Size = new Size(113, 20);
            requestTypeLbl.TabIndex = 12;
            requestTypeLbl.Text = "Requested Item";
            // 
            // requestAmountTxt
            // 
            requestAmountTxt.Location = new Point(6, 85);
            requestAmountTxt.Name = "requestAmountTxt";
            requestAmountTxt.Size = new Size(294, 27);
            requestAmountTxt.TabIndex = 11;
            // 
            // consoleLbl
            // 
            consoleLbl.AutoSize = true;
            consoleLbl.Location = new Point(16, 428);
            consoleLbl.Name = "consoleLbl";
            consoleLbl.Size = new Size(204, 20);
            consoleLbl.TabIndex = 1;
            consoleLbl.Text = "Info may show up down here!";
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(consoleLbl);
            Controls.Add(tabControl1);
            Name = "Form1";
            Text = "Crafting Calculator";
            tabControl1.ResumeLayout(false);
            editPge.ResumeLayout(false);
            editPge.PerformLayout();
            craftPge.ResumeLayout(false);
            craftPge.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private TabControl tabControl1;
        private TabPage editPge;
        private ListBox recipeBookLst;
        private TabPage craftPge;
        private Label recipeBookLbl;
        private TextBox recipeAmountTxt;
        private TextBox recipeNameTxt;
        private ListBox recipeBuilderInLst;
        private Label recipeBuilderInLbl;
        private Label recipeNameLbl;
        private Label recipeAmountLbl;
        private TextBox recipeTypeTxt;
        private Label recipeTypeLbl;
        private Button importOutputBtn;
        private Button importRecipeBtn;
        private Button importInputBtn;
        private TextBox recipeOutputTxt;
        private Label recipeOutputLbl;
        private Label consoleLbl;
        private ListBox leftoverLst;
        private ListBox requiredLst;
        private Label requestAmountLbl;
        private TextBox requestTypeTxt;
        private Label requestTypeLbl;
        private TextBox requestAmountTxt;
        private Label requiredLbl;
        private Button craftBtn;
        private Label label1;
        private RadioButton addModeRad;
        private RadioButton removeModeRad;
        private ListBox recipeBuilderOutLst;
        private Label recipeBuilderOutLbl;
        private Button viewRecipeBtn;
    }
}
