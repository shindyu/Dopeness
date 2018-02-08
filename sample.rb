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
    return res.body.split("test2=")[1].force_encoding("UTF-8")
end

def show_features(surfaces, chunk_features)
	features_index = 0
		chunk_features.each do |feature|
            print "\e[33m"
            puts "[#{feature[0]}] #{surfaces[feature[0]]}"
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
                    	if 0 < score && score < 4
                        	if 2 < score then
                            	print "\e[32m"
                            	puts "\t[#{pos}] #{surfaces[pos]} : #{score}" 
                            	print "\e[0m"
                        	else
                            	puts "\t[#{pos}] #{surfaces[pos]} : #{score}" 
                        	end
                        	loop_count += 1
                    	end
                    end
                    
                }
            end
            # puts "\n"
            features_index += 1
        end
end


lyric = crawler('http://www.utamap.com/phpflash/flashfalsephp.php?unum=k-160302-083')
lyric = "この氷河期じゃ　能書きじゃなく
ひねる脳がｷｰ　要するに猛吹雪を
毛布抜きで越えてく　肉弾戦でﾃｸﾆｯｸ
出せん奴は脱落だ　辛くても立つ
ラクダみたいに　前進する 
飾らない　依然シースルーで
見せてくのみ内面　まるで伸びない麺
あったかさﾊﾟｯｹｰｼﾞ　音と言葉が合併し

冬の街中で　ﾏｼﾞな賭けしなきゃ
始まらね～　 母ちゃん曰く
麻雀みたく あんたちゃんと
がんばらんと　ｻﾝﾀｻﾝも来ないよ
だから常夏まで　言葉つなげ"

# 前処理
verses = lyric.split("\n\n")

verses.each do |verse|
	verse = verse.gsub(/(\s)/,"。")
	puts verse
	surfaces, chunk_features = Dopeness.dope(verse)
	show_features(surfaces, chunk_features)
end
