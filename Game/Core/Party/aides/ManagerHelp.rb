################################################################################
# File: ManagerHelp.rb                                                                #
# Project: Hashi                                                               #
# File Created: Friday, 27th march 2020 11:00:27 am                         #
# Author: Lemaitre Pierre                                                   #
# -----                                                                        #
# Last Modified: Sunday, 5th April 2020 3:48:12 pm                             #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################



require_relative "../Grid.rb"
require_relative "./IsleCellInfo.rb"
require_relative "./HelpOneNeighbour"
require_relative "./HelpMaxVal"
require_relative "./HelpPartMaxValue"
require_relative "./HelpPartMaxValueBis"
require_relative "./Help411"
require_relative "./Help61"

##
# ===== Presentation
#   ManagerHelp is a class that manage the differents helps and return an indication if it's possible
#
# ===== Methods
# * +static askHelp+ - Return an help ([[coordonates] : List,message : String]) if it's possible,else return an empty list
##
class ManagerHelp


    ##
    # Return an help ([[coordonates] : List,message : String]) if it's possible,else return an empty list
    #
    # ===== Return
    # return [[coordonates] : List,message : String] else return []
    # ---
    def ManagerHelp.askHelp(grille)
        lIlesInfo = []

        (0...grille.getRows).each do |x|
            (0...grille.getCols).each do |y|
                if(grille.getCell(x,y).getState == :isle)
                    lIlesInfo.append(IsleCellInfo.new(x,y,grille))
                end
            end
        end
        # for isle in lIlesInfo do
        #     grille.affGrid(1)
        #     puts isle
        # end
        # isle = lIlesInfo[0]
        # grille.affGrid(1)
        # puts isle

        if((aide = HelpOneNeighbour.aide(lIlesInfo))!=nil)
            return aide
        elsif((aide = HelpMaxVal.aide(lIlesInfo))!=nil)
            return aide
        elsif((aide = HelpPartMaxValue.aide(lIlesInfo))!=nil)
            return aide
        elsif((aide = HelpPartMaxValueBis.aide(lIlesInfo))!=nil)
            return aide
        elsif((aide = Help411.aide(lIlesInfo))!=nil)
            return aide
        elsif((aide = Help61.aide(lIlesInfo))!=nil)
            return aide
        else
            return [[],"Il n'y a plus d'aide disponible"]
        end
    end
end