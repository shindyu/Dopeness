require "romankana"
require "trigram"
require "levenshtein"
require "dopeness/version"
require_relative "dopeness/parse_surfaces"
require_relative "dopeness/parse_pronunciation"
require_relative "dopeness/parse_vowels"

module Dopeness
	def self.dope(verse)
		threshold = 0.0
        surfaces = parse_surfaces(verse)
        pronuncitaitons = parse_pronunciation(verse)
        vowels = []
        pronuncitaitons.each do |pronuncitaiton|
        	vowels.push(parse_vowels(pronuncitaiton.to_roman))
        end
        chunk_features = {}
        (0...vowels.size).each do |i|
        	once_chunk_hash = {}
            max = i + 10
            if vowels.size < max
                max = vowels.size

            end
        	(i...max).each do |j|
                # 母音の3-gram類似度
                # 母音のLevenshtein距離
                # 発音のLevenshtein距離
                # 対象までの物理的距離 からスコアを計算する
        		trigram_evaluation = Trigram.compare(vowels[i], vowels[j])
                if trigram_evaluation.nan?
                    trigram_evaluation = 0
                end
                vowels_distance = 1 - Levenshtein.normalized_distance(vowels[i], vowels[j])
                pronuncitaitons_distance = 1 - Levenshtein.normalized_distance(pronuncitaitons[i], pronuncitaitons[j])
                physical_distance = 1 - ((j - i) / 10)
                matching_score = trigram_evaluation + vowels_distance + pronuncitaitons_distance + physical_distance
                once_chunk_hash.store(j, matching_score)
        	end
            sorted_score = Hash[once_chunk_hash.sort_by{ |_, v| -v }]
            chunk_features.store(i, sorted_score)
        end
        return surfaces, chunk_features
	end
end
