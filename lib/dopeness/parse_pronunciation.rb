#!/usr/bin/ruby 
# -*- coding: utf-8 -*-
require "CaboCha"
include CaboCha

# sentenceを解析してchunkの配列を返す
module Dopeness
  def parse_pronunciation(sentence)
    parser = Parser.new;
    tree = parser.parse(sentence)
    tree.set_output_layer(OUTPUT_RAW_SENTENCE)
    chunks = []
    (0 ... tree.chunk_size).each do |i|
      chunk = tree.chunk(i)
      x = (0 ... chunk.token_size).map do |j|
        if tree.token(chunk.token_pos + j).feature_list(tree.token(chunk.token_pos + j).feature_list_size - 1).force_encoding("UTF-8") != "*" then
          tree.token(chunk.token_pos + j).feature_list(tree.token(chunk.token_pos + j).feature_list_size - 1).force_encoding("UTF-8")  
        else
          tree.token(chunk.token_pos).surface.force_encoding("UTF-8")
        end
      end.join("")
      chunks.push(x)
    end
    return chunks
  end
  module_function :parse_pronunciation
end