## pwcorr_a

`pwcorr_a` displays all the pairwise correlation coefficients between the variables in varlist or, if varlist
is not specified, all the variables in the dataset.

The main differecne between `pwcorr_a` and the stata's official command `pwcorr` is that, `pwcorr_a` can display
`***` (1% significance level), `**` (5% significance level), and `*` (10% significance level), say, at the same
time, while in the case of `pwcorr`, only one of these can be done.

## How to use
download `pwcorr_a.ado` and `pwcorr_a.hlp` and put them in `..\stata15\ado\plus\p`. Then, type `help pwcorr_a` in `stata` command line. 
