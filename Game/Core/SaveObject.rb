################################################################################
# File: SaveObject.rb                                                          #
# Project: Hashi                                                                #
# File Created: Thursday, 9th April 2020 5:40:12 pm                            #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Thursday, 9th April 2020 6:34:20 pm                           #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require "yaml"
require 'fileutils'

##
# ===== Presentation
# 
# ===== Variables
# * +variableName+ - description
# ===== Methods
# * +myMethod+ - description
##
class SaveObject
    # Directory creation
    FileUtils.mkdir_p(File.expand_path('../../', File.dirname(__FILE__)) + "/Data/")

    # Absolute path to save datas
    @@pathData = File.expand_path('../../Data/', File.dirname(__FILE__)) + "/"

    def SaveObject.hasSave(file)
        return File.exist?(@@pathData + file)
    end

    def SaveObject.loadSave(file)
        if(SaveObject.hasSave(file))
            file_data = File.read(@@pathData + file)
            
            return YAML.load(file_data)
        end

        return nil
    end

    def SaveObject.save(file, object)
        if(object != nil)
            # Directory creation
            dir = file.split("/")
            dir.pop
            FileUtils.mkdir_p(@@pathData + dir.join("/"))

            File.open(@@pathData + file, "w") { |f| f.write YAML.dump(object) }
            return true
        end
        return false
    end

    def SaveObject.delete(file)
        File.delete(@@pathData + file) if File.exists?  @@pathData + file
    end
end
