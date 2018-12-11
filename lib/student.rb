class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 
  
  @@all = []

  def initialize(student_hash)
    student_hash.each {|k,v| self.send(("#{k}="),v)}
    @@all << self
  end
  
  def self.create_from_collection(student_array)
    student_array.each do |student_hash|
      Student.new(student_hash)
    end
  end
  
  def add_student_attributes(student_hash)
    student_hash.each {|k,v| self.send(("#{k}="),v)}
  end
  
  def self.all
    @@all
  end
  
  
end

