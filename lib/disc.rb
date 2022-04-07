require_relative 'product'
class Disc < Product
  attr_accessor :title, :year, :performer, :genre

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8', chomp: true)

    self.new(
      title: lines[0],
      performer: lines[1],
      genre: lines[2],
      year: lines[3],
      price: lines[4],
      amount: lines[5])
  end

  def initialize(params)
    super

    @title = params[:title]
    @year = params[:year]
    @performer = params[:performer]
    @genre = params[:genre]
  end

  def to_s
    "Диск «#{@title}», #{@performer}, #{@year} #{@genre}, #{super}"
  end

  def update(params)
    super

    @title = params[:title] if params[:title]
    @year = params[:year] if params[:year]
    @performer = params[:performer] if params[:performer]
    @genre = params[:genre] if params[:genre]
  end
end
