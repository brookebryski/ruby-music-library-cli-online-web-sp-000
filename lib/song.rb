=begin
class Song
  attr_accessor :name, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
  @name = name
  if artist != nil
    self.artist = artist
  end
   self.genre=(genre) if genre != nil
  save
  end

  def artist
    @artist
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre
    @genre
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
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

  def self.find_by_name(name)
    @@all.detect do |song|
      song.name == name
  end
end

def self.find_or_create_by_name(name)
  self.find_by_name(name) || self.create(name)
end


def self.new_from_filename(filename)
    info = filename.split(" - ")
    artist, name, genre = info[0], info[1], info[2].gsub( ".mp3" , "")


    genre = Genre.find_or_create_by_name(genre)
    artist = Artist.find_or_create_by_name(artist)

    new(name,artist,genre)
  end

  def self.create_from_filename(name)
    self.new_from_filename(name).save
  end
end
=end
class Song
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=artist if artist
    # self.artist.songs.push(self)
    self.genre=genre if genre
    # @artist = artist
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
    song = self.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
    # Artist.all.push(artist)
  end

  def genre=(genre)
    @genre = genre
    if !(genre.songs.include?(self))
      genre.songs << self
      # Genre.all.push(genre)
    # binding.pry
    end
  end

  def self.find_by_name(name)
    all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    # if self.find_by_name(name)
    #   self.find_by_name(name)
    # else
    # song = self.create(name)
    # end
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    info = filename.split(" - ")
    artist, name, genre = info[0], info[1], info[2].gsub( ".mp3" , "")

    # song = self.find_or_create_by_name(name)
    genre = Genre.find_or_create_by_name(genre)
    artist = Artist.find_or_create_by_name(artist)

    new(name,artist,genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save}

  end
end
