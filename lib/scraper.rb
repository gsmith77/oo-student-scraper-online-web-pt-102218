require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    students=[]
    doc = Nokogiri::HTML(open(index_url))
    
    doc.css("div.student-card a").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.attribute("href").value
      students << {name: name, location: location, profile_url: profile_url}
    end
    students
  end
  
  
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    profile = {}
    
    doc.css("div.social-icon-container a").each do |social|
      
      link = social.attr("href")
      
      if link.include?("twitter")
        profile[:twitter] = link
        elsif link.include?("github")
        profile[:github] = link
        elsif link.include?("linkedin")
        profile[:linkedin] = link
        else link.include?("blog")
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = doc.css("div.vitals-text-container").css("div.profile-quote").text
    profile[:bio] = doc.css("div.details-container p").text
    profile
  end
end