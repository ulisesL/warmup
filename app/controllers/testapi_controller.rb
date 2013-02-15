class TestapiController < ApplicationController

  #ResetFixture starts here
  
  def ResetFixture
  	
  	User.delete_all
  	respond_to do |format| 
  			format.json {render json: {errCode: 1}} 
  	end

  end
  #ResetFixture ends here

  #UnitTest starts here
  def UnitTests

  	system("./test.sh")
  	myFile = File.new("./ulisestests.txt", "r+")

  	output_temp = ""
  	while file_line = myFile.gets 
  		
  		output_temp += file_line

      puts output_temp

  		string = /(\d+) examples, (\d+) failures/.match(file_line) 
  		if string 
  			totalTests_temp = Integer (string[1])
  			nrFailed_temp = Integer (string[2])
  		end

  	end 


  	respond_to do |format| 
  			format.json {render json: {totalTests: totalTests_temp, nrFailed: nrFailed_temp, output: output_temp}} 
  	end

  end
  #UnitTest ends here

end
