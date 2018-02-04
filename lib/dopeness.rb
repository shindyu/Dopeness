require "romaji"
require "romaji/core_ext/string"
require "trigram"
require "levenshtein"
require "dopeness/version"
require "dopeness/parse_chunks"
require_relative "dopeness/parse_pronunciation"
require_relative "dopeness/parse_vowels"

module Dopeness
	def self.dope(verse)
		threshold = 0.0     

        chunk_features = {}
        chunks = parse_chunks(verse)
        pronuncitaitons = parse_pronunciation(verse)          

        vowels = []        

        pronuncitaitons.each do |pronuncitaiton|
        	vowels.push(parse_vowels(pronuncitaiton.romaji))
        end          

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
                once_chunk_hash.store(j, matching_score)
        	end
            sorted_score = Hash[once_chunk_hash.sort_by{ |_, v| -v }]
            chunk_features.store(i, sorted_score)
        end        

        return chunks, chunk_features
	end
end
