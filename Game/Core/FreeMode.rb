################################################################################
# File: FreeMode.rb                                                            #
# Project: Hashi                                                                #
# File Created: Monday, 6th April 2020 2:16:35 pm                              #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Monday, 6th April 2020 6:16:52 pm                             #
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
class FreeMode
    @@mode = [:easy, :medium, :difficult]

    FileUtils.mkdir_p(File.expand_path('../../', File.dirname(__FILE__)) + "/Data/freeMode/")
    @@pathData = File.expand_path('../../Data/freeMode/', File.dirname(__FILE__))

    @@filePath = {
        @@mode[0] => @@pathData + "/easy",
        @@mode[1] => @@pathData + "/medium",
        @@mode[2] => @@pathData + "/difficult"
    }

    def FreeMode.hasSave(mode)
        if(@@filePath.has_key?(mode))
            return File.exist?(@@filePath[mode])
        end
        return false
    end

    def FreeMode.loadSave(mode)
        if(FreeMode.hasSave(mode))
            file_data = File.read(@@filePath[mode])
            
            return YAML.load(file_data)
        end

        return nil
    end

    def FreeMode.save(mode, party)
        if(@@filePath.has_key?(mode) && party != nil)
            File.open(@@filePath[mode], "w") { |f| f.write YAML.dump(party) }
            return true
        end
        return false
    end
end
