#!/usr/bin/ruby 
# -*- coding: utf-8 -*-
require "CaboCha"
include CaboCha

# sentenceを解析して配列を返す
module Dopeness
  def parse_chunks(sentence)
    parser = Parser.new;
    tree = parser.parse(sentence)
    tree.set_output_layer(OUTPUT_RAW_SENTENCE)
    chunks = []
    (0 ... tree.chunk_size).each do |i|
      chunk = tree.chunk(i)
      if (chunk.link >= 0) then
        x = (0 ... chunk.token_size).map do |j|
          tree.token(chunk.token_pos + j).normalized_surface.force_encoding("UTF-8")
        end.join("")
      else
        x = tree.token(chunk.token_pos).normalized_surface.force_encoding("UTF-8")
      end
      chunks.push(x)
    end
    return chunks
  end
  module_function :parse_chunks
end