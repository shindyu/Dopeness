#!/usr/bin/ruby 
# -*- coding: utf-8 -*-
module Dopeness
  def parse_vowels(str)
    vowel = ["a", "i", "u", "e", "o"]
    rhyme = ""
    str.each_char do |ch|
      if vowel.include?(ch)
        rhyme += ch
      end
    end
    return rhyme
  end
  module_function :parse_vowels
end