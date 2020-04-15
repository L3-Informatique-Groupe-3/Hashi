################################################################################
# File: HelpOneNeighbour.rb                                                                #
# Project: Hashi                                                               #
# File Created: Friday, 27th march 2020 11:00:27 am                         #
# Author: Lemaitre Pierre                                                   #
# -----                                                                        #
# Last Modified: Friday, 27th march 2020 11:00:27 am                          #
# Modified By: Lemaitre Pierre                                              #
################################################################################

##
# ===== Presentation
#   Return the coordonate of the cell which can be help with the One Neighbour technique, else return nil
#
# ===== Methods
# * +static askHelp+ - Return an help ([[coordonates] : List,message : String]) if it's possible,else return an empty list
##
class HelpOneNeighbour

    
    ##
    # Verify if the help can be done and return informations if it can be
    #
    # ===== Return
    # return [[coordonates] : List,message : String] if it can apply the help, else return nil
    # ---
    def HelpOneNeighbour.aide(lIlesAide)
        for ile in lIlesAide
            if (ile.nbVoisins == 1 && (ile.nbPontCumul != ile.valIle))
                return [[ile.x,ile.y],"La cellule à un seul voisin"]
            end
        end
        return nil
    end
end