################################################################################
# File: Help411.rb                                                                #
# Project: Hashi                                                               #
# File Created: Friday, 27th march 2020 11:00:27 am                         #
# Author: Lemaitre Pierre                                                   #
# -----                                                                        #
# Last Modified: Friday, 27th march 2020 11:00:27 am                          #
# Modified By: Lemaitre Pierre                                              #
################################################################################

##
# ===== Presentation
#   Return the coordonate of the cell which can be help with the 411 technique, else return nil
#
# ===== Methods
# * +static askHelp+ - Return an help ([[coordonates] : List,message : String]) if it's possible,else return an empty list
##
class Help411

    ##
    # Verify if the help can be done and return informations if it can be
    #
    # ===== Return
    # return [[coordonates] : List,message : String] if it can apply the help, else return nil
    # ---
    def Help411.aide(lIlesAide)
        for ile in lIlesAide
            if (ile.valIle == 4 && ile.nbVoisins == 3 && ile.nbPontCumul < 4 && ile.nombreDeVoisinUn == 2)
                return [[ile.x,ile.y],"L'ile peut être totalement relié"]
            end
        end
        return nil
    end

end