{smcl}
{* 20jan2005}{...}
{cmd:help pwcorr_a} {right: A modified version of stata {cmd:pwcorr} command}
{hline}

{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{bf:pwcorr_a} {hline 2}} pairwise correlation coefficients {p_end}
{p2colreset}{...}


{title:Syntax}

{phang}Display all pairwise correlation coefficients

{p 8 18 2}
{cmd:pwcorr_a}
[{varlist}]
{ifin}
{weight}
[{cmd:,} {it:{help correlate##pwcorr_options:pwcorr_options}}]

{synoptset 19 tabbed}{...}
{marker pwcorr_options}{...}
{synopthdr :pwcorr_options}
{synoptline}
{syntab :Main}
{synopt :{opt o:bs}}print number of observations for each entry{p_end}
{synopt :{opt sig}}print significance level for each entry{p_end}
{synopt :{opt p:rint(#)}}significance level for displaying coefficients{p_end}
{synopt :{opt st:ar(#)}}significance level for displaying with a star{p_end}
{synopt :{opt st:ar1(#)}}1% significance level for displaying with three stars, newly added{p_end}
{synopt :{opt st:ar5(#)}}5% significance level for displaying with two stars, newly added{p_end}
{synopt :{opt st:ar10(#)}}10% significance level for displaying with one star, newly added{p_end}
{synopt :{opt b:onferroni}}use Bonferroni-adjusted significance level{p_end}
{synopt :{opt sid:ak}}use Sidak-adjusted significance level{p_end}
{synoptline}
{p2colreset}{...}

{p 4 6 2}
{it:varlist} may contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}
{opt by} may be used with the {opt correlate} and {opt pwcorr}; see 
{helpb by}.{p_end}
{p 4 6 2}
{opt aweight}s and {opt fweight}s are allowed; see {help weight}.


{title:Description}

{pstd}
{opt pwcorr_a} displays all the pairwise correlation coefficients between
the variables in {it:varlist} or, if
{it:varlist} is not specified, all the variables in the dataset.{break}
The main differecne between {cmd:pwcorr_a} and the stata old command {cmd:pwcorr} 
is that, this new one can display ***(1% significance level),
**(5% significance level), and *(10% significance level), say, at the same time,
while in the case of {cmd:pwcorr}, only one of these can be done.


{title:Options}

{dlgtab:Main}

{phang}
{opt obs} adds a line to each row of the matrix reporting the number of
observations used to calculate the correlation coefficient.

{phang}
{opt sig} adds a line to each row of the matrix reporting the
significance level of each correlation coefficient.

{phang}
{opt print(#)} specifies the significance level of
correlation coefficients to be printed.  Correlation coefficients with larger significance levels are left blank in the matrix. 
Typing {cmd:pwcorr, print(.10)} would list only correlation coefficients significant at the 10% level or better.

{phang}
{opt star(#)} specifies the significance level of
correlation coefficients to be starred.  Typing {cmd:pwcorr, star(.05)} would
star all correlation coefficients significant at the 5% level or better.

{phang}
{opt star1(#) star5(#) star10(#)} are newly added, which specify the significance level of
correlation coefficients more detailed.  
Typing {cmd:pwcorr, star1(.01) star5(.05) star10(.1)} would
star all correlation coefficients significant at the 1%, 5%, and 10% level, respectively.

{phang}
{opt bonferroni} makes the Bonferroni adjustment to calculated
significance levels.  This affects printed significance levels and the
{cmd:print()} and {cmd:star()} options.  Thus 
{bind:{cmd:pwcorr, print(.05) bonferroni}} prints coefficients with
Bonferroni-adjusted significance levels of .05 or less.

{phang}
{opt sidak} makes the Sidak adjustment to calculated significance levels.
This affects printed significance levels and the {cmd:print()} and
{cmd:star()} options.  Thus {bind:{cmd:pwcorr, print(.05) sidak}} prints
coefficients with Sidak-adjusted significance levels of .05 or less.


{title:Examples}

{pstd}

{pstd}Defult useage: same as stata command {cmd:pwcorr}{p_end}

{phang2}. {stata "sysuse auto, clear"}{p_end}
{phang2}. {stata "pwcorr_a mpg price wei len"}{p_end}

{pstd}Speicify 1%, 5%, 10% significant level asterisks{p_end}

{phang}{cmd:. pwcorr_a price weight mpg displ, star1(0.01) star5(0.05) star10(0.1)}{p_end}


{title:Author}

{phang}
{cmd:Yujun,Lian (Arlion)} Department of Finance, Lingnan College, Sun Yat-Sen University.{break}
E-mail: {browse "mailto:arlionn@163.com":arlionn@163.com}. {break}
Gitee: {browse "https://gitee.com/arlionn/pwcorr_a":https://gitee.com/arlionn/pwcorr_a}. {break}
{p_end}


{title:For problems and suggestions}

{phang}
Any problems or suggestions are welcome, please Email to 
{browse "mailto:arlionn@163.com":arlionn@163.com}. {break}
or, go to my
{browse "https://gitee.com/arlionn/pwcorr_a": Blog}{dup 2:-}>
{browse "https://gitee.com/arlionn/pwcorr_a"} {break}
for a further discussion.
{p_end}

{title:Also see}

{psee}
Manual:  {bf:[R] correlate}

{psee}
Online:  {helpb estat},
{helpb pcorr},
{helpb set matsize},
{helpb spearman},
{helpb summarize},
{helpb tetrachoric},
{helpb corr2docx} (if installed),
{p_end}
