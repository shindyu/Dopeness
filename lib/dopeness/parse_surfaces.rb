#!/usr/bin/ruby 
# -*- coding: utf-8 -*-
require "CaboCha"
include CaboCha

# sentenceを解析して配列を返す
module Dopeness
  def parse_surfaces(sentence)
    parser = Parser.new;
    tree = parser.parse(sentence)
    tree.set_output_layer(OUTPUT_RAW_SENTENCE)
    surfaces = []
    (0 ... tree.chunk_size).each do |i|
      chunk = tree.chunk(i)
      if (chunk.link >= 0) then
        x = (0 ... chunk.token_size).map do |j|
          tree.token(chunk.token_pos + j).normalized_surface.force_encoding("UTF-8")
        end.join("")
      else
        x = tree.token(chunk.token_pos).normalized_surface.force_encoding("UTF-8")
      end
      surfaces.push(x)
    end
    return surfaces
  end
  module_function :parse_surfaces
end