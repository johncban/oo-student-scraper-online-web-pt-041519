require 'open-uri'
require 'pry'

class Scraper
  # binding.pry
  def self.scrape_index_page(index_url)
    in_page = Nokogiri::HTML(open(index_url))
    students = []
    in_page.css("div.roster-cards-container").each { |c|
        c.css(".student-card").each { |s|
            student_profile_link = "#{s.attr('href')}"
            student_location = s.css('.student-location').text
            student_name = s.css('.student-name').text
            students << {name: student_name, location: student_location, profile_url: student_profile_link}
        }
    }
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
