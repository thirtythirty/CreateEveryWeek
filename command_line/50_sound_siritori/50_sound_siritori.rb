

class SoundSiritori
  def initialize()
    @said_words = []
    @next_word_top = 'り'
    @used_50_sound = []
    @dakuon="がぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽ"
    @seion ="かきくけこさしすせそたちつてとはひふへほはひふへほ"
    puts "しりとりスタート 'り'から"
  end
  def judge_useable(word)
    word = word.tr('ァ-ン', 'ぁ-ん')
    word_top = word[0].tr(@dakuon, @seion)
    if(word_top != @next_word_top)
      puts "始める言葉が間違ってます！"
      return false
    end
    word_end = word[-1].tr(@dakuon, @seion)
    if(@used_50_sound.include?(word_end))
      puts "すでに使用された先頭時です"
      return false
    end
    if(@said_words.include?(word))
      puts "「#{word}」はすでに使われています！"
      return false
    end
    if(word_end == "ん")
      puts "「ん」で終わってます！"
      return false
    end

    @used_50_sound << @next_word_top.tr(@dakuon, @seion)
    @said_words << word
    @next_word_top = word_end
    puts "次の言葉は「#{@next_word_top}」です"
    # p @used_50_sound
    return true
  end
  
  def check_metaword(word)
    if(word == 'show')
      p @used_50_sound
      return true
    end
    return false
  end
end

sound_siritori = SoundSiritori.new
loop do
  word = gets.chomp!
  next if(sound_siritori.check_metaword(word))
  if sound_siritori.judge_useable(word)
    puts "==============="
  else
    puts "終了です"
  end
end
