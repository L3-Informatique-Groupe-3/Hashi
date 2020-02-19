# fichier pour l'ecran de victoire
# possede 3 boutons : menuPrincipal, recommencer, suivant (pas toujours du texte, ca peut etre des images)
# on doit afficher le chrono dans un champs delimité
# devant on doit mettre un texte
# au dessus on doit mettre un texte 

# menuPrincipal => image sur la gauche et texte sur la droite
# recommencer => image
# suivant => image 

# @Author: Noemie Farizon <NoemieFarizon>
# @Date:   11-Feb-2020
# @Email:  noemie.farizon.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   s174383


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class VictoryScreen < Screen
    
    def initialize(manager)
        super(manager.win)
        
        #creation du texte avant la zone d'affichage du chrono
        textChrono=Text.new("Votre temps :")

        #creation de la zone d'affichage du chrono
        

        #creation du bouton menuPrincipal
        boutonMenu=Text.new("menu principal")
        boutonMenu.onClick(){
            #aller au menu principal
        }

        #creation du bouton recommencer
        boutonRefaire=Text.new("recommencer")
        boutonRefaire.onClick(){
            #recharger le niveau sur lequel on etait
            @niveau.courant
        }

        #creation du bouton suivant
        boutonSuivant=Text.new("suivant")
        boutonSuivant.onClick(){
            #aller au prochain niveau
            @niveau.suivant
        }
    end

  def applyOn(widget,sScore,isWon, associatedTimer =0)
      # TO DO
    super(widget)
  end

end