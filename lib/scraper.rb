require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    
    students = []
    
    doc.css(".student-card a").each do |student|
      name = student.css(".student-name").first.text
      location = student.css("p.student-location").text
      profile_url = student.attribute("href").value
      students << {name: name, profile_url: profile_url, location: location}
    end
    students
  end

  
   def self.scrape_profile_page(profile_url)
    
    profile = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |social|
  
      link = social.attr("href")
      if link.include?("facebook")
        profile[:facebook] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("twitter")
        profile[:twitter] = link
      else
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".bio-content p").text
    profile
  end
end
  

