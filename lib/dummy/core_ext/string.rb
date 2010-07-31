class String
  def numerify(number_string)
    number_string.gsub(/#/) { rand(10).to_s }
  end
end
