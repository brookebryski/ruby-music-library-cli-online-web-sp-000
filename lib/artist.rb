=begin
class Artist
extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
  @name = name
  @songs = []
  save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    self.new(name)
  end
=begin
  def add_song(song)
    if song.artist == nil
     song.artist = self
  end

  if !@songs.include?(song)
    @songs << song
  end
end


  def add_song(song)

      song.artist = self unless song.artist
      songs << song unless songs.include?(song)
      # @songs.uniq!

  end
def genres
   @new_array = []
   @songs.each do |song|
     if @new_array.include?(song.genre)
       nil
     else
       @new_array << song.genre
     end
   end
   @new_array
 end

end
=end
class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    # self.save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def songs
    @songs
  end

  def add_song(song)

      song.artist = self unless song.artist
      songs << song unless songs.include?(song)
      # @songs.uniq!

  end

  def genres
    # self.songs.collect {|song| song.genre}
    songs.collect { |song| song.genre}.uniq
  end
end
