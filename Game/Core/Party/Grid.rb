################################################################################
# File: Grid.rb                                                                #
# Project: Hashi                                                               #
# File Created: Monday, 24th February 2020 11:00:27 am                         #
# Author: <jashbin>Galbrun J                                                   #
# -----                                                                        #
# Last Modified: Tuesday, 25th February 2020 3:03:08 pm                        #
# Modified By: <jashbin>Galbrun J                                              #
################################################################################

require "./ObstacleCell"
require "./IsleCell"
require "./BridgeCell"
require "yaml"

##
# ===== Presentation
# This class represents a hashi grid.
# 
# ===== Variables
# * +current+ - the grid that the user modifies
# * +answer+ - the answer grid
#
# ===== Methods
# * +getCurrentGrid+ - Return a copy of +current+ grid
# * +loadCurrentGrid+ - Load an existent +current+ grid
# * +createBridge+ - Create a bridge if it's possible
# * +changeBridge+ - Change the type of a bridge
# * +reset+ - Reset +current+ grid
# * +freeze+ - Freeze all bridges
# * +unfreeze+ - Unfreeze all bridges
##
class Grid
    @current
    @answer

    ##
    # The class' constructor.
    # Format of of the string : example -> "10x10:1a 2ac8b"...
    #
    # ===== Attributes
    # * +answerGrid+ - The string which represent the answer
    # ---
    def initialize(answerGrid)
        @answer = strToGrid(answerGrid)
        @current = answerToCurrent(@answer)
    end

    ##
    # Reset +current+ grid
    # ---
    def reset
        @current = answerToCurrent(@answer)
        self
    end

    ##
    # Return a copy of +current+ grid.
    #
    # ===== Return
    # Return a copy of +current+ grid. 
    # ---
    def getCurrentGrid
        return YAML.load(YAML.dump(@current))
    end

    ##
    # Load an existent +current+ grid
    #
    # ===== Attributes
    # * +currentGrid+ - New current grid
    # ---
    def loadCurrentGrid(currentGrid)
        @current = currentGrid
        self
    end

    ##
    # Create a bridge between 2 isles
    #
    # ===== Attributes
    # * +x1+ - X coord of the first isle
    # * +y1+ - Y coord of the first isle
    # * +x2+ - X coord of the second isle
    # * +y2+ - Y coord of the second isle
    #
    # ===== Return
    # Return true if the creation is successful 
    # ---
    def createBridge(x1, y1, x2, y2)
        # Check if the coord are valid
        if(x1 >= @current.size || x1 < 0 || x2 >= @current.size || x2 < 0 || y1 >= @current[0].size || y1 < 0 || y2 >= @current[0].size || y2 < 0)
            return false
        end
        if((x1 == x2 && y1 == y2) || (x1 != x2 && y1 != y2))
            return false
        end

        # Check if the 2 points are isles
        if(@current[x1][y1].state != :isle || @current[x2][y2].state != :isle)
            return false
        end

        direction = nil
        coordsX = []
        coordsY = []
        if(x1 == x2)
            direction = :horizontal
            if(y1 < y2)
                coordsY = (y1+1..y2-1).to_a
            else
                coordsY = (y2+1..y1-1).to_a
            end
            coordsX = Array.new(coordsY.size, x1)
        else
            direction = :vertical
            if(x1 < x2)
                coordsX = (x1+1..x2-1).to_a
            else
                coordsX = (x2+1..x1-1).to_a
            end
            coordsY = Array.new(coordsX.size, y1)
        end
        puts("X : " + coordsX.to_s)
        puts("Y : " + coordsY.to_s)

        # Check if there is an isle or an obstacle or a bridge between them
        for i in 0..coordsX.size-1 do
            if(@current[coordsX[i]][coordsY[i]].state == :isle)
                return false
            end
            if(@current[coordsX[i]][coordsY[i]].state == :obstacle)
                return false
            end
            if(@current[coordsX[i]][coordsY[i]].state == :bridge)
                if(@current[coordsX[i]][coordsY[i]].type != :empty)
                    return false
                end
            end
        end

        # Update Cell
        for i in 0..coordsX.size-1 do
            @current[coordsX[i]][coordsY[i]].setType(:simple)
            @current[coordsX[i]][coordsY[i]].setDirection(direction)
        end
        
        return true
    end

    ##
    # Change the type of the bridge to the next type if the bridge exists
    #
    # ===== Attributes
    # * +x+ - X coord of the bridge
    # * +y+ - Y coord of the bridge
    #
    # ===== Return
    # Return true if the change is successful 
    # ---
    def changeBridge(x, y)
        # Check if the coord are valid
        if(x >= @current.size || x < 0 || y >= @current[0].size || y < 0)
            return false
        end

        if(@current[x][y].state != :bridge)
            return false
        end
        if(@current[x][y].type == :empty)
            return false
        end
        
        # Update bridge
        if(@current[x][y].direction == :vertical)
            # get coord isle
            i = x
            while(@current[i][y].state == :bridge) do
                i -= 1
            end

            i += 1
            while(@current[i][y].state == :bridge) do
                @current[i][y].nextType()
                i += 1
            end
        else
            # get coord isle
            i = x
            while(@current[x][i].state == :bridge) do
                i -= 1
            end

            i += 1
            while(@current[x][i].state == :bridge) do
                @current[x][i].nextType()
                i += 1
            end
        end

        return true
    end

    ##
    # Freeze all bridges
    # ---
    def freeze
        @current.each do |x|
            x.each do |cell|
                if(cell.state == :bridge)
                    cell.freeze()
                end
            end
        end
        self
    end

    ##
    # Unfreeze all bridges
    # ---
    def unfreeze
        @current.each do |x|
            x.each do |cell|
                if(cell.state == :bridge)
                    cell.unfreeze()
                end
            end
        end
        self
    end

    # Display Method for test
    def affGrid(gridToAff)
        gridAff = nil
        if(gridToAff == 0)
            gridAff = @answer
        else
            gridAff = @current
        end

        puts("Taille : " + gridAff.size().to_s + "x" + gridAff[0].size().to_s)
        gridAff.each do |x|
            x.each do |y|
                case y.state
                    when :bridge
                        case y.type
                            when :empty
                                print("   ")
                            when :simple
                                if(y.direction == :vertical)
                                    print(" | ")
                                else
                                    print("---")
                                end
                            when :double
                                if(y.direction == :vertical)
                                    print("| |")
                                else
                                    print("===")
                                end
                        end
                    when :isle
                        print(" " + y.getBridgeNumber().to_s() + " ")
                    when :obstacle
                        print(" x ")
                end
            end
            puts()
        end
        self
    end

    private

    ##
    # Convert a string grid to an array grid
    # (test : 9x9:2c3-1-1c3a-b-a3d3b4d4-aa-a3a3dd5a-2a3a--b1-a3b3cc6dd4b3a--a-1a3a2c1a-a1a2c2c3c3c2)
    # ===== Attributes
    # * +strGrid+ - The string which represent the answer
    #
    # ===== Return
    # Return an array grid
    # --- 
    def strToGrid(strGrid)
        # Format of bridge
        #bridgeCh = /[a-d]/
        bridgeCh = ['a', 'b', 'c', 'd']
        # Format of isle
        digit = /[[:digit:]]/
        # Format of an obstacle
        obstacleCh = /o/
        # Format of empty cell
        emptyCh = /-/
        # Format of size and grid separator
        separator = ":"
        # Format of strGrid
        # ex : 07x07: (bridgeCh | digit | obstacleCh | emptyCh)+

        args = strGrid.split(separator)
        size = args[0].split("x")
        row = size[0].to_i()
        col = size[1].to_i()
        
        grid = Array.new(row){Array.new()}
        
        i = 0
        j = 0
        args[1].split(//).each do |x|
            if(bridgeCh.include?(x))
                if(x == bridgeCh[0])
                    grid[i].push(BridgeCell.new(:vertical, :simple))
                elsif(x == bridgeCh[1])
                    grid[i].push(BridgeCell.new(:vertical, :double))
                elsif(x == bridgeCh[2])
                    grid[i].push(BridgeCell.new(:horizontal, :simple))
                else
                    grid[i].push(BridgeCell.new(:horizontal, :double))
                end
            elsif(x =~ digit)
                grid[i].push(IsleCell.new(x.to_i()))
            elsif(x =~ obstacleCh)
                grid[i].push(ObstacleCell.new())
            else #empty cell
                grid[i].push(BridgeCell.new())
            end
            
            j += 1
            if(j >= col)
                j = 0
                i += 1
                if(i >= row)
                    break
                end
            end
        end
        
        return grid
    end

    ##
    # Convert an answer grid to a current grid
    #
    # ===== Attributes
    # * +strGrid+ - The string which represent the answer
    #
    # ===== Return
    # Return a current array grid
    # --- 
    def answerToCurrent(answerGrid)
        grid = YAML.load(YAML.dump(answerGrid))
        
        grid.each do |x|
            x.each do |y|
                if(y.state == :bridge)
                    y.setType(:empty)
                end
            end
        end

        return grid
    end
end
