################################################################################
# File: SaveObject.rb                                                          #
# Project: Hashi                                                                #
# File Created: Thursday, 9th April 2020 5:40:12 pm                            #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 14th April 2020 5:20:21 pm                           #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require "yaml"
require 'fileutils'

##
# ===== Presentation
# This class saves objects.
#
# ===== Variables
# * +pathData+ - Directory path of the save
#
# ===== Methods
# * +SaveObject.hasSave+ - Return true if the save exists
# * +SaveObject.loadSave+ - Return the save if it exists, nil if not
# * +SaveObject.save+ - Save the object in the specified file
# * +SaveObject.delete+ - Delete the save if it exists
##
class SaveObject
    # Directory creation
    FileUtils.mkdir_p(File.expand_path('../../', File.dirname(__FILE__)) + "/Data/")

    # Absolute path to save datas
    @@pathData = File.expand_path('../../Data/', File.dirname(__FILE__)) + "/"

    ##
    # Return true if the save exists
    #
    # ===== Attributes
    # * +file+ - the file
    #
    # ===== Return
    # Return true if the save exists
    # ---
    def SaveObject.hasSave(file)
        return File.exist?(@@pathData + file)
    end

    ##
    # Return the save if it exists, nil if not
    #
    # ===== Attributes
    # * +file+ - the file
    #
    # ===== Return
    # Return the save if it exists, nil if not
    # ---
    def SaveObject.loadSave(file)
        if(SaveObject.hasSave(file))
            file_data = File.read(@@pathData + file)
            
            return YAML.load(file_data)
        end

        return nil
    end

    ##
    # Save the object in the specified file
    #
    # ===== Attributes
    # * +file+ - the file
    # * +object+ - The object to save
    #
    # ===== Return
    # Return true if no error
    # ---
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

    ##
    # Delete the save if it exists
    #
    # ===== Attributes
    # * +file+ - the file to delete
    # ---
    def SaveObject.delete(file)
        File.delete(@@pathData + file) if File.exists?  @@pathData + file
    end
end
