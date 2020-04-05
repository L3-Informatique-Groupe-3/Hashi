require_relative "../Grid.rb"


################################################################################
# File: IsleCellInfo.rb                                                                #
# Project: Hashi                                                               #
# File Created: Friday, 27th march 2020 11:00:27 am                         #
# Author: Lemaitre Pierre                                                   #
# -----                                                                        #
# Last Modified: Sunday, 5th April 2020 3:45:41 pm                             #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

##
# ===== Presentation
#   This class give more info about an island, these info can be used by other class
# 
# ===== Variables
# * +x+ - x coordonate of the cell
# * +y+ - y coordonate of the cell
# * +ile+ - The island analysed
# * +ileHaut+ -  The island on the top of the island analysed
# * +ileBas+ - The island on the bottom of the island analysed
# * +ileGauche+ - The island on the left of the island analysed
# * +ileDroite+ - The island on the right of the island analysed
# * +estCoin+ - boolean which is true if the island is at a coin of the grid
# * +estBord+ - boolean which is true if the island is at a border of the grid
# * +nbVoisins+ - The number of neighboor of the island
# * +nbPontBas+ - The number of bridge linked to the island at the bottom (0,1 or 2)
# * +nbPontHaut+ - The number of bridge linked to the island at the top (0,1 or 2)
# * +nbPontGauche+ - The number of bridge linked to the island at the left (0,1 or 2)
# * +nbPontDroite+ - The number of bridge linked to the island at the right (0,1 or 2)
# * +nbPontCumul+ - The total number of bridge that is linked to the island
# * +valIle+ - The value of the island
# 
#  ===== Methods
# * +to_s+ - Return the display of the info form the island
# * +nombreDeVoisinUn+ - Return the number of neighboor with a value of 1
# * +nombreDeCotéRelié+ - Return the number of side linked with at least one bridge
# * +static retrouveInfosListe+ - Return the IsleCellInfo of an island from an IsleCellInfo array from a specific island
##
class IsleCellInfo
    @x
    @y
    @ile
    @ileHaut
    @ileBas
    @ileGauche
    @ileDroite
    @estCoin
    @estBord
    @nbVoisins
    @nbPontBas
    @nbPontHaut
    @nbPontGauche
    @nbPontDroite
    @nbPontCumul
    @valIle
    attr_reader :valIle,:x,:y,:ile,:ileHaut,:ileBas,:ileGauche,:ileDroite,:estCoin,:estBord,:nbVoisins,:nbPontBas,:nbPontHaut,:nbPontGauche,:nbPontDroite,:nbPontCumul#:nodoc:


    ##
    # The class' constructor.
    #
    # ===== Attributes
    # * +x+ - The x coordonate of the island
    # * +y+ - The y coordonate of the island
    # * +grille+ - The Grid
    # ---
    def initialize(x,y,grille)
        @x = x
        @y = y
        @ile = grille.getCell(x,y)
        @valIle = @ile.getBridgeNumber()
        @ileHaut = nil
        @ileBas = nil
        @ileGauche = nil
        @ileDroite = nil
        
        @estCoin = false
        @estBord = false
        
        @nbVoisins = 0
        
        @nbPontBas = 0
        @nbPontHaut = 0
        @nbPontGauche = 0
        @nbPontDroite = 0
        
        if( (x == 0 || x == (grille.getRows - 1)) && ( y==0 || y == (grille.getCols - 1)))
            @estCoin = true
        elsif (x == 0 || x == (grille.getRows - 1 ) || y==0 || y == (grille.getCols - 1))
            @estBord = true
        end


        #Localisation ile haut
        i=1
        while((x-i)>=0 && grille.getCell(x-i,y).getState != :isle)
            i+=1
        end
        if((x-i)>=0)
            @ileHaut = grille.getCell(x-i,y)
            @nbVoisins += 1
            @nbPontHaut += grille.getCell(x-1,y).getBridgeNumber if (grille.getCell(x-1,y).getState == :bridge && grille.getCell(x-1,y).getDirection == :vertical)
        end

        #Localisation ile bas
        i=1
        while((x+i)<grille.getRows && grille.getCell(x+i,y).getState != :isle)
            i+=1
        end
        if((x+i)<grille.getRows)
            @ileBas = grille.getCell(x+i,y)
            @nbVoisins += 1
            @nbPontBas += grille.getCell(x+1,y).getBridgeNumber if (grille.getCell(x+1,y).getState == :bridge && grille.getCell(x+1,y).getDirection == :vertical)
        end

        #Localisation ile gauche
        i=1
        while((y-i)>=0 && grille.getCell(x,y-i).getState != :isle)
            i+=1
        end
        if((y-i)>=0)
            @ileGauche = grille.getCell(x,y-i)
            @nbVoisins += 1
            @nbPontGauche += grille.getCell(x,y-1).getBridgeNumber if (grille.getCell(x,y-1).getState == :bridge && grille.getCell(x,y-1).getDirection == :horizontal)
        end

        #Localisation ile droite
        i=1
        while((y+i)<grille.getCols && grille.getCell(x,y+i).getState != :isle)
            i+=1
        end
        if((y+i)<grille.getCols)
            @ileDroite = grille.getCell(x,y+i)
            @nbVoisins += 1
            @nbPontDroite += grille.getCell(x,y+1).getBridgeNumber if (grille.getCell(x,y+1).getState == :bridge && grille.getCell(x,y+1).getDirection == :horizontal)
        end

        @nbPontCumul = @nbPontBas + @nbPontDroite + @nbPontGauche + @nbPontHaut

    end


    ##
    # Return a string with the display of the infos of the cell
    #
    # ===== Return
    # Return a string with the display
    # ---
    def to_s()
        infos = "Ile de coordonées [" + @x.to_s + "," + @y.to_s + "] avec pour valeur : " + @ile.getBridgeNumber().to_s + "\n"
        infos += "C'est un coin\n" if @estCoin
        infos += "C'est un bord\n" if @estBord
        infos += "Elle à une ile au dessus de valeur : " + @ileHaut.getBridgeNumber().to_s + " et "+ @nbPontHaut.to_s + " ponts\n" if @ileHaut != nil 
        infos += "Elle à une ile au dessous de valeur : " + @ileBas.getBridgeNumber().to_s + " et "+ @nbPontBas.to_s + " ponts\n" if @ileBas != nil 
        infos += "Elle à une ile à gauche de valeur : " + @ileGauche.getBridgeNumber().to_s + " et "+ @nbPontGauche.to_s + " ponts\n" if @ileGauche != nil 
        infos += "Elle à une ile à droite de valeur : " + @ileDroite.getBridgeNumber().to_s + " et "+ @nbPontDroite.to_s + " ponts\n" if @ileDroite != nil 
        return infos;
    end


    ##
    # Static method to locate a isleinfo on a array from the isle
    #
    # ===== Attributes
    # * +isle+ - The specific isle
    # * +lIleInfos+ - The list of IsleCellInfo
    # ===== Return
    # Return the IsleCellInfo of the island if it exist, else retrun nil
    # ---
    def IsleCellInfo.retrouveInfosListe(ile,lIleInfos)
        (0...lIleInfos.size).each do |x|
            if(lIleInfos[x].ile == ile)
                return lIleInfos[x]
            end
        end
        return nil
    end


    ##
    # Return the number of neighboor with a value of 1
    #
    # ===== Return
    # Return a int value
    # ---
    def nombreDeVoisinUn
        nombre = 0
        nombre += (@ileHaut != nil && @ileHaut.getBridgeNumber == 1) ? 1 : 0
        nombre += (@ileBas != nil && @ileBas.getBridgeNumber == 1) ? 1 : 0
        nombre += (@ileGauche != nil && @ileGauche.getBridgeNumber == 1) ? 1 : 0
        nombre += (@ileDroite != nil && @ileDroite.getBridgeNumber == 1) ? 1 : 0
        return nombre

    end


    ##
    # Return the number of side linked with at least one bridge
    #
    # ===== Return
    # Return a int value
    # ---
    def nombreDeCotéRelié
        nombre = 0
        nombre += (@nbPontBas > 0 ) ? 1 : 0
        nombre += (@nbPontHaut > 0 ) ? 1 : 0
        nombre += (@nbPontGauche > 0 ) ? 1 : 0
        nombre += (@nbPontDroite > 0 ) ? 1 : 0
        return nombre
    end

end