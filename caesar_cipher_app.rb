require 'sinatra'
require 'sinatra/reloader'

def caesar_cipher string, shift
	if shift > 26
		shift%=26
	end

	punctuation = ["!","?","\,"," "]

	string.each_byte.with_index do |char,index|
		if punctuation.include? char.chr
			char.chr
		elsif (char>=97 && char+shift >122) || (char>=65 && char <=90 && char+shift > 90)
			string[index] = (char+shift-25).chr
		else 
			string[index] = (char+shift).chr
		end
	end
	return string
end

string = ""
get '/' do
	erb :index, :locals => {:string => string}
end

post '/' do 
	string = caesar_cipher(params['cipher'],params['shift'].to_i)
	erb :index, :locals =>{:string => string}
end
