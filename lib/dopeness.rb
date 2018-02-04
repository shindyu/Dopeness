require "romaji"
require "romaji/core_ext/string"
require "trigram"
require "levenshtein"
require "dopeness/version"
require "dopeness/parse_chunks"
require_relative "dopeness/parse_pronunciation"
require_relative "dopeness/parse_vowels"

module Dopeness
	def self.dope(verses)
		threshold = 0.0

        verses.each do |verse|
        	puts "------------\n\n"
        	puts verse
        	puts "------------\n\n"        

            chunks = parse_chunks(verse)
            pronuncitaitons = parse_pronunciation(verse)          

            vowels = []        

            pronuncitaitons.each do |pronuncitaiton|
            	vowels.push(parse_vowels(pronuncitaiton.romaji))
            end          

            chunk_features = {}
            (0 ... vowels.size).each do |i|
            	once_chunk_hash = {}
            	(i  ... vowels.size).each do |j|
                    # 母音の3-gram類似度 母音のLevenshtein距離 発音のLevenshtein距離からスコアを計算する
            		evaluation = Trigram.compare(vowels[i], vowels[j])
                    if evaluation.nan?
                        evaluation = 0
                    end
                    vowels_distance = Levenshtein.normalized_distance(vowels[i], vowels[j])
                    pronuncitaitons_distance = Levenshtein.normalized_distance(pronuncitaitons[i], pronuncitaitons[j])
                    
                    matching_score = evaluation + (1 - vowels_distance) + (1 - pronuncitaitons_distance)        

                    # if matching_score > 0
                        once_chunk_hash.store(j, matching_score)
                    # end
                    # puts matching_score
                    # puts "#{vowels[i]}, #{vowels[j]} : ev:#{evaluation}, vds:#{vowels_distance}, pds:#{pronuncitaitons_distance}"
            	end
                chunk_features.store(i, once_chunk_hash)  	
            end        

            chunk_features.each do |feature|
                print "\e[33m"
                puts "[#{feature[0]}] #{chunks[feature[0]]} : #{vowels[feature[0]]}"
                print "\e[0m"        

                # 関連度でソート
                # sorted_scores = Hash[feature[1].sort_by{ |_, v| -v }]
                if feature[1].empty? then
                    # puts "\tnone"
                else
                    sorted_scores = Hash[feature[1].sort_by{ |_, v| -v }]
                    loop_count = 0
                    sorted_scores.each { |pos, score|
                        if loop_count > 3 
                            break
                        end
                        loop_count += 1
                        if 0 < score && score < 3
                            if 1 < score then
                                print "\e[32m"
                                puts "\t[#{pos}] #{chunks[pos]} : #{score}" 
                                print "\e[0m"
                            else
                                puts "\t[#{pos}] #{chunks[pos]} : #{score}" 
                            end
                        end
                    }
                end
                puts "\n"
            end

            return chunk_features
        end
	end
end
