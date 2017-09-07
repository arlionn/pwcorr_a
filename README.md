# Arlion's stata
stata packages written by Yujun Lian (Arlionn)

## pwcorr_a

`pwcorr_a` displays all the pairwise correlation coefficients between the variables in varlist or, if varlist
is not specified, all the variables in the dataset.

The main differecne between `pwcorr_a` and the stata's official command `pwcorr` is that, `pwcorr_a` can display
`***` (1% significance level), `**` (5% significance level), and `*` (10% significance level), say, at the same
time, while in the case of `pwcorr`, only one of these can be done.
