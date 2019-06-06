require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    i_page = Nokogiri::HTML(open(index_url))
    students = []
    i_page.css("div.roster-cards-container").each{|c|
        c.css(".student-card a").each{|s|
            student_profile_link = "#{s.attr('href')}"
            student_location = s.css('.student-location').text
            student_name = s.css('.student-name').text
            students << {name: student_name, location: student_location, profile_url: student_profile_link}
        }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    p_page = Nokogiri::HTML(open(profile_slug))
    l = p_page.css(".social-icon-container").children.css("a").collect{|el|
        el.attribute('href').value
    }
    l.each{|li|
        if li.include?("linkedin")
            student[:linkedin] = li
        elsif li.include?("github")
            student[:github] = li
        elsif li.include?("twitter")
            student[:twitter] = li
        else
            student[:blog] = li
        end
    }

      student[:profile_quote] = p_page.css(".profile-quote").text if p_page.css(".profile-quote")
      student[:bio] = p_page.css("div.bio-content.content-holder div.description-holder p").text if p_page.css("div.bio-content.content-holder div.description-holder p")

      student

  end


end
