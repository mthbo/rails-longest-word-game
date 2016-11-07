class PagesController < ApplicationController

  def home
  end

  def game
    @grid = Array.new(9) { ('A'..'Z').to_a[rand(26)] }
    @start_time = Time.now
  end

  def score
    time = Time.now - Time.parse(params[:start_time])
    attempt = params[:attempt]
    grid = params[:grid].split("")
    translation = translate(attempt)
    score = (attempt.length.fdiv(time) * 10).round(2)

    @results = {
      attempt: attempt.upcase,
      time: time.round(2),
      translation: translation.nil? ? "" : translation.upcase,
      score: score,
      message: "well done"
    }

    @results[:message] = "not an english word" if translation.nil?
    @results[:message] = "not in the grid" unless in_grid?(attempt, grid)
    @results[:score] = 0 unless @results[:message] == "well done"
    session[:scores] << @results[:score]
    @results[:scores] = session[:scores]
    @results[:average_score] = session[:scores].reduce(:+).fdiv(session[:scores].length).round(2)
  end


  def in_grid?(word, grid)
    guess = word.upcase.split("")
    guess.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def translate(word)
    url = "https://api-platform.systran.net/translation/text/translate?"\
    "source=en&target=fr&key=1321380f-cc5a-41fd-bf0a-1ae5ceb29b54&input=#{word}"
    json_translation = open(url).read
    hash_translation = JSON.parse(json_translation)
    translation = hash_translation["outputs"][0]["output"]
    translation == word ? nil : translation
  rescue
    rescue_dictionary = File.read('/usr/share/dict/words').upcase.split("\n")
    rescue_dictionary.include?(word.upcase) ? word : nil
  end

end
