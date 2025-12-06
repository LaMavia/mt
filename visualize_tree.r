library("treeio")
library("ggtree")

tree1 <- read.tree("sample.nwk")
tree2 <- read.tree("sample1.nwk")

pdf("./Tree.pdf")
par(mfrow = c(1, 2))

ggplot(tree1, branch.length='none') + 
  geom_tree() + 
  theme_tree() + 
  layout_circular() +
  geom_tiplab(size=3, color="purple")

ggplot(tree2, branch.length='none') + 
  geom_tree() + 
  theme_tree() + 
  layout_circular() +
  geom_tiplab(size=3, color="purple")

