##
# File: Popup.rb
# Project: UI
# File Created: Tuesday, 7th April 2020 2:39:33 pm
# Author: <CPietJa>Galbrun T.
# -----
# Last Modified: Tuesday, 7th April 2020 7:16:27 pm
# Modified By: <CPietJa>Galbrun T.
#
require 'gtk3'
=begin
     *=== Description
     Fenêtre popup éxécutant des actions en fonction
     de l'appui sur ses boutons.

=end
class Popup
    attr_reader :titre

    GRIS_BASE = Gdk::RGBA.new(0.94,0.94,0.94,1)
    MARRON = Gdk::RGBA.new(0.6,0.5,0.5,1)

    def initialize(titre:"Popup")
        w,h = 300,150
        @win = Gtk::Window.new(:popup)
        @win.set_default_size(w,h).set_resizable(false)
        @win.set_position('center_always')
        @win.override_background_color(:normal,GRIS_BASE)

        @boxP = Gtk::Box.new(:vertical)
        @boxP.set_homogeneous(true).set_margin(10)
        @win.add(@boxP)

        # Titre Popup
        creerTitre(titre:titre)
        # Zone contenant les boutons
        creerZoneBoutons()
    end

    # Titre Popup
    def creerTitre(titre:"Popup")
        box = Gtk::Box.new(:horizontal)
        box.set_homogeneous(true)
        @titre = Gtk::Label.new()
        @titre.set_markup("<span font_desc=\"15.0\" foreground='black'><b>#{titre}</b></span>")
        box.add(@titre)
        @boxP.add(box)
    end

    # Zone contenant les boutons
    def creerZoneBoutons()
        @zoneBtn = Gtk::Box.new(:horizontal)
        @zoneBtn.set_homogeneous(true)
        @boxP.add(@zoneBtn)
    end

    # Ajout d'un bouton à la zone de boutons
    def addBouton(titre:"",icon:nil)
        btn = Gtk::Button.new(:label => titre)
        btn.set_margin_top(15)
        btn.set_margin_bottom(15)
        btn.set_margin_left(5)
        btn.set_margin_right(5)
        if(icon != nil)
            btn.set_image(icon)
        end
        btn.signal_connect('button_release_event'){ |widget,event|
            yield(widget,event)
        }
        @zoneBtn.add(btn)
    end

    def set_titre(titre:"")
        @titre.set_markup("<span font_desc=\"15.0\" foreground='black'><b>#{titre}</b></span>")
    end

    def run()
        @win.show_all
    end

    def stop()
        @win.hide
    end

    def destroy()
        @win.destroy
    end
end
