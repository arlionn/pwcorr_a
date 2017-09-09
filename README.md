## pwcorr_a

`pwcorr_a` displays all the pairwise correlation coefficients between the variables in varlist or, if varlist
is not specified, all the variables in the dataset.

The main differecne between `pwcorr_a` and the stata's official command `pwcorr` is that, `pwcorr_a` can display
`***` (1% significance level), `**` (5% significance level), and `*` (10% significance level), say, at the same
time, while in the case of `pwcorr`, only one of these can be done.

## How to use
download `pwcorr_a.ado` and `pwcorr_a.hlp` and put them in `..\stata15\ado\plus\p`. Then, type `help pwcorr_a` in `stata` command line. 

## What is the difference between `pwcorr` and `pwcorr_a` ?
```

.   sysuse auto, clear
(1978 Automobile Data)

.   pwcorr price wei len mpg

             |    price   weight   length      mpg
-------------+------------------------------------
       price |   1.0000 
      weight |   0.5386   1.0000 
      length |   0.4318   0.9460   1.0000 
         mpg |  -0.4686  -0.8072  -0.7958   1.0000 

.   pwcorr_a price wei len mpg

             |  price   weight   length     mpg   
-------------+------------------------------------
   price     |    1.000   
   weight    |    0.539***   1.000   
   length    |    0.432***   0.946***   1.000   
    mpg      |   -0.469***  -0.807***  -0.796***   1.000  
```
