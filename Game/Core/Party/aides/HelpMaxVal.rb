################################################################################
# File: HelpMaxVal.rb                                                                #
# Project: Hashi                                                               #
# File Created: Friday, 27th march 2020 11:00:27 am                         #
# Author: Lemaitre Pierre                                                   #
# -----                                                                        #
# Last Modified: Friday, 27th march 2020 11:00:27 am                          #
# Modified By: Lemaitre Pierre                                              #
################################################################################

##
# ===== Presentation
#   Return the coordonate of the cell which can be help with the Max Value technique, else return nil
#
# ===== Methods
# * +static askHelp+ - Return an help ([[coordonates] : List,message : String]) if it's possible,else return an empty list
##
class HelpMaxVal

    ##
    # Verify if the help can be done and return informations if it can be
    #
    # ===== Return
    # return [[coordonates] : List,message : String] if it can apply the help, else return nil
    # ---
    def HelpMaxVal.aide(lIlesAide)
        for ile in lIlesAide
            if (ile.valIle == 4 && ile.nbVoisins == 2 && ile.nbPontCumul != 4|| ile.valIle == 6 && ile.nbVoisins == 3 && ile.nbPontCumul != 6|| ile.valIle == 8 && ile.nbVoisins == 4 && ile.nbPontCumul != 8)
                return [[ile.x,ile.y],"L'île à le nombre maximum qu'elle peut avoir par rapport à son nombre de voisin"]
            end
        end
        return nil
    end

end