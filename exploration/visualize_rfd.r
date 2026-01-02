library(TreeDist)

own_tree <- ape::read.tree("sample.nwk")
tt_tree <- ape::read.tree("sample1.nwk")

pdf("./RFD.pdf", width = 12, height = 6)
matching <- VisualizeMatching(
                  RobinsonFouldsMatching,
                  own_tree,
                  tt_tree
)
title("Sample vs Sample1", line = 3)
sprintf("RF dist: %f", RobinsonFoulds(
                     own_tree,
                     tt_tree,
                     normalize = FALSE
                     ))

