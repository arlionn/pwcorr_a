*! version 3.0.9  26Jan2025
* V1, 2005.7.12
* To add star at 1% , 5% , 10% significant levels

cap program drop pwcorr_a
program define pwcorr_a, byable(recall)
	version 6
	*syntax [varlist(min=2)] [if] [in] [aw fw] [, /* 
	*	*/ Bonferroni Obs Print(real -1) SIDak SIG star1(real 0.01) star5(real 0.05) star10(real 0.1) ]
		
	syntax [varlist(min=2 ts)] [if] [in] [aw fw] [, ///
		Bonferroni Obs Print(real -1) SIDak SIG ///
		STar(real -1) LISTwise CASEwise ///
        star1(real 0.01) star5(real 0.05) star10(real 0.1) ///
		Format(string)]
		
	tempvar touse
	mark `touse' `if' `in' 		/* but do not markout varlist */ 
	tokenize `varlist'

	local i 1
	while "``i''" != "" { 
		capture confirm str var ``i''
		if _rc==0 { 
			di in gr "(``i'' ignored because string variable)"
			local `i' " "
		}
		local i = `i' + 1
	}
	local varlist `*'
	tokenize `varlist'
	local nvar : word count `varlist'
	if `nvar' < 2 { error 102 } 

	local weight "[`weight'`exp']"
	local nvar : word count `varlist'
	local adj 1
	if "`bonferr'"!="" | "`sidak'"!="" {
		if "`bonferr'"!="" & "`sidak'"!="" { error 198 }
		local nrho=(`nvar'*(`nvar'-1))/2
		if "`bonferr'"!="" { local adj `nrho' }
	}

	
*----------Arlion new added --------begin---20130622--
    if `"`format'"' != "" {
       capt local tmp : display `format' 1
       if _rc {
          di as err `"invalid %fmt in format(): `format2'"'
          exit 120
       }
    }
	else{
	   local format %7.3f
	}	
*----------Arlion new added --------over--------------

	if (`print'>=1) {
		local print = `print'/100
		if `print'>=1 {
			di in red "print() out of range"
			exit 198
		}

	}
		
	local j0 1
	while (`j0'<=`nvar') {
		di
		local j1=min(`j0'+6,`nvar')
		local j `j0'
		di in smcl in gr _skip(13) "{c |}" _c
		while (`j'<=`j1') {
		   *di in gr %9s abbrev("``j''",8) _c
			di in gr %~9s abbrev("``j''",8) _c  // Arlion 2013-06-22
			local j=`j'+1
		}
		local l=9*(`j1'-`j0'+1)
		di in smcl in gr _n "{hline 13}{c +}{hline `l'}"

		local i `j0'
		while `i'<=`nvar' {
		   *di in smcl in gr %12s abbrev("``i''",12) " {c |} " _c
			di in smcl in gr %~12s abbrev("``i''",12) " {c |} " _c   // Arlion 2013-06-22
			local j `j0'
			while (`j'<=min(`j1',`i')) {
				cap corr ``i'' ``j'' if `touse' `weight'
				if _rc == 2000 {
					local c`j' = .
				}
				else { 
					local c`j'=r(rho)
				}	       
				local n`j'=r(N)
				local p`j'=min(`adj'*tprob(r(N)-2,/*
				*/ r(rho)*sqrt(r(N)-2)/ /*
				*/ sqrt(1-r(rho)^2)),1)
				if "`sidak'"!="" {
					local p`j'=min(1,1-(1-`p`j'')^`nrho')
				}
				local j=`j'+1
			}
			local j `j0'
*************************************************
//Modifying begin ,by Arlion
			while (`j'<=min(`j1',`i')) {
                        if (`p`j''<=`star1'&`i'!=`j'){
                                local ast "***"   
                        }
                        else if (`p`j''>`star1'&`p`j''<=`star5'&`i'!=`j'){
                                local ast "** "   
                        }
                        else if (`p`j''>`star5'&`p`j''<=`star10'&`i'!=`j'){
                                local ast "*  "   
                        }
                    
				else local ast "   "
				if `p`j''<=`print' | `print'==-1 |`i'==`j' {
//					di " " %7.4f `c`j'' "`ast'" _c
                   * di _col(1) %7.3f `c`j'' "`ast'" _col(2) _c  // Arlion 20050503
				   *di " " %7.4f `c`j'' "`ast'" _c               // Arlion modify
					di " " `format' `c`j'' "`ast'"  _c	 // Arlion 20130622						 
				}
				else 	di _skip(9) _c
				local j=`j'+1
			}
// Modifying end, by Arlion
***************************************************
			di
			if "`sig'"!="" {
				di in smcl in gr _skip(13) "{c |}" _c
				local j `j0'
				while (`j'<=min(`j1',`i'-1)) {
					if `p`j''<=`print' | `print'==-1 {
						* di "   " %7.4f `p`j'' _c  
						di " " `format' `c`j'' "`ast'"  _c  // Arlion 20130622	
					}
					else	di _skip(9) _c
					local j=`j'+1
				}
				di
			}
			if "`obs'"!="" {
				di in smcl in gr _skip(13) "{c |}" _c
				local j `j0'
				while (`j'<=min(`j1',`i')) {
					if `p`j''<=`print' | `print'==-1 /*
					*/ |`i'==`j' {
						*di "  " %7.0g `n`j'' _c
						di " " `format' `c`j'' "`ast'"  _c // Arlion 20130622	
					}
					else	di _skip(9) _c
					local j=`j'+1
				}
				di
			}
			if "`obs'"!="" | "`sig'"!="" {
				di in smcl in gr _skip(13) "{c |}" 
			}
			local i=`i'+1
		}
		local j0=`j0'+7
	}
end
