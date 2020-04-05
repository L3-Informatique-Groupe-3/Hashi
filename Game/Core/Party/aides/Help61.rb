################################################################################
# File: Help61.rb                                                                #
# Project: Hashi                                                               #
# File Created: Friday, 27th march 2020 11:00:27 am                         #
# Author: Lemaitre Pierre                                                   #
# -----                                                                        #
# Last Modified: Friday, 27th march 2020 11:00:27 am                          #
# Modified By: Lemaitre Pierre                                              #
################################################################################

##
# ===== Presentation
#   Return the coordonate of the cell which can be help with the 61 technique, else return nil
# ===== Methods
# * +static askHelp+ - Return an help ([[coordonates] : List,message : String]) if it's possible,else return an empty list
##
class Help61


    ##
    # Verify if the help can be done and return informations if it can be
    #
    # ===== Return
    # return [[coordonates] : List,message : String] if it can apply the help, else return nil
    # ---
    def Help61.aide(lIlesAide)
        for ile in lIlesAide
            if (ile.valIle == 6 && ile.nbVoisins == 4 && ile.nbPontCumul < 6 && conditionVerif(ile))
                return [[ile.x,ile.y],"Vous pouvez relier les cellules qui ne sont pas le 1"]
            end
        end
        return nil
    end

    ##
    # Verify if the condition of the help is verified
    #
    # ===== Return
    # return true if it's verifie, else return false
    # ---
    def conditionVerif(ile)
        if(   (ile.ileHaut.bridgeNumber == 1 && ile.nbPontBas < 1 && ile.nbPontGauche < 1 && ile.nbPontDroite < 1)\
            ||(ile.ileBas.bridgeNumber == 1 && ile.nbPontHaut < 1 && ile.nbPontGauche < 1 && ile.nbPontDroite < 1)\
            ||(ile.ileGauche.bridgeNumber == 1 && ile.nbPontBas < 1 && ile.nbPontHaut < 1 && ile.nbPontDroite < 1)\
            ||(ile.ileDroite.bridgeNumber == 1 && ile.nbPontBas < 1 && ile.nbPontGauche < 1 && ile.nbPontHaut < 1))
            return true
        end
        return false
    end

end