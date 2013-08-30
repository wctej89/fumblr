require 'Mechanize'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def product(keyword)
    keyword_serial = keyword.gsub(/ /, '%20')
    agent = Mechanize.new
    page  = agent.get("http://www.amazon.com/s/ref=nb_sb_ss_i_0_8?url=search-alias%3Daps&field-keywords=#{keyword_serial}")
    results = []
    images = agent.page.parser.css('.productImage')
    5.times do |i| 
      item_image = images[i].children.children[1].attributes['src'].value
      if i < 3
        item = agent.page.parser.css("#atfResults #result_#{i.to_s}")
      else
        item = agent.page.parser.css("#centerBelow #result_#{i.to_s}")
      end
      puts "LOOK AT ME #{item.children.children.length}"
      price = item.css('span').children[0].text
      title = item.children.children[2].children.children.text.strip
      star_rating_link = item.children.children.css('a')[3].children[0].attributes['src'].value
      if item.children.children.length == 18
        item_page_link = item.children.children[1].attributes['href'].value
      else
        item_page_link = item.children.children[2].children[0].attributes['href'].value
      end

      results << Product.create(title: title, price: price, stars_link: star_rating_link, item_show_link: item_page_link, item_image: item_image)
      puts "Title:     #{title}"
      puts "Price:     #{price}"
      puts "Stars:     #{star_rating_link}"
      puts "More Info: #{item_page_link}"
      puts "Image:     #{item_image}"
      puts "XXXXXXXXXXXXXXX"
    end
    results
    # results = Product.all.limit(5)
  end
end
