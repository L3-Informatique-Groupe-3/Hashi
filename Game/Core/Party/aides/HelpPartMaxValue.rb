################################################################################
# File: HelpPartMaxValue.rb                                                                #
# Project: Hashi                                                               #
# File Created: Friday, 27th march 2020 11:00:27 am                         #
# Author: Lemaitre Pierre                                                   #
# -----                                                                        #
# Last Modified: Friday, 27th march 2020 11:00:27 am                          #
# Modified By: Lemaitre Pierre                                              #
################################################################################

##
# ===== Presentation
#   Return the coordonate of the cell which can be help with the HelpPartMaxValue technique, else return nil
#
# ===== Methods
# * +static askHelp+ - Return an help ([[coordonates] : List,message : String]) if it's possible,else return an empty list
##
class HelpPartMaxValue

    ##
    # Verify if the help can be done and return informations if it can be
    #
    # ===== Return
    # return [[coordonates] : List,message : String] if it can apply the help, else return nil
    # ---
    def HelpPartMaxValue.aide(lIlesAide)
        for ile in lIlesAide
            if (   (ile.valIle == 3 && ile.nbVoisins == 2 && ile.nombreDeCotéRelié < 2)\
                || (ile.valIle == 5 && ile.nbVoisins == 3 && ile.nombreDeCotéRelié < 3)\
                || (ile.valIle == 7 && ile.nbVoisins == 4 && ile.nombreDeCotéRelié < 4))       
                return [[ile.x,ile.y],"Chaque île voisine peut être relié au moins une fois"]
            end
        end
        return nil
    end

end