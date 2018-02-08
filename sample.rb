#!/usr/bin/ruby 
# -*- coding: utf-8 -*-
require "dopeness"
require 'net/http'
require 'uri'

# utamap cralwer
def crawler(target_url)
    # uri = URI.parse('http://www.utamap.com/phpflash/flashfalsephp.php?unum=k-111208-003')
    uri = URI.parse(target_url)
    res = Net::HTTP.get_response(uri)
    return res.body.split("test2=")[1]
end

def show_features(chunks, chunk_features)
	features_index = 0
	puts (chunk_features)
		chunk_features.each do |feature|
            print "\e[33m"
            puts "[#{feature[0]}] #{chunks[feature[0]]}"
            print "\e[0m"        

            if feature[1].empty? then
                # puts "\tnone"
            else
                loop_count = 0
                feature[1].each { |pos, score|
                    # if loop_count > 3 
                    #     break
                    # end
                    if features_index != pos 
                    	if 0 < score && score < 3
                        	if 1 < score then
                            	print "\e[32m"
                            	puts "\t[#{pos}] #{chunks[pos]} : #{score}" 
                            	print "\e[0m"
                        	else
                            	puts "\t[#{pos}] #{chunks[pos]} : #{score}" 
                        	end
                        	loop_count += 1
                    	end
                    end
                    
                }
            end
            puts "\n"
            features_index += 1
        end
end


lyric = crawler('http://www.utamap.com/phpflash/flashfalsephp.php?unum=k-160302-083')
lyric = "
 舌で巻いたライムがマイブラント。 チェックしろこれがライムガード。
"
verses = lyric.split("\n\n")
verses.each do |verse|
	puts verse
	chunks, chunk_features = Dopeness.dope(verse)
	# puts chunks
	# puts chunk_features
	show_features(chunks, chunk_features)
	
	# puts dope
end
