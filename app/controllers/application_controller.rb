require 'mechanize'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def product_scrape(keyword)
   #  keyword_serial = keyword.gsub(/ /, '%20')
   #  agent = Mechanize.new
   #  page  = agent.get("http://www.amazon.com/s/ref=nb_sb_ss_i_0_8?url=search-alias%3Daps&field-keywords=#{keyword_serial}")
   #  results = []
   #  images = agent.page.parser.css('.productImage')

   #  5.times do |i|

   #    if i < 3
   #      item = agent.page.parser.css("#atfResults #result_#{i.to_s}")
   #    else
   #      item = agent.page.parser.css("#centerBelow #result_#{i.to_s}")
   #    end

   #    puts "LOOK AT ME #{item.children.children.length}"
   #    item_div_length = item.children.children.length
   #    if item.children.children.css('a')[3].children[0].text != "" 
   #      item_div_length -= 1 
   #    else
   #      star_rating_link = item.children.children.css('a')[3].children[0].attributes['src'].value
   #    end
      
   #    if item_div_length >= 18 
   #      title          = item.children.children[3].children.children.text.strip
   #      item_page_link = item.children.children[1].attributes['href'].value
   #      price          = get_price(item)
   #    elsif item_div_length == 16
   #      title          = item.children[5].children[1].children[0].children.text.strip
   #      item_page_link = item.children.children[1].attributes['href'].value
   #      price          = get_price(item)
   #    else
   #      title          = item.children.children[2].children.children.text.strip
   #      item_page_link = item.children.children[2].children[0].attributes['href'].value
   #      price          = item.css('span').children[0].text
   #    end

   #    if title.length > 60
   #     title[61..-1]=''
   #     title[-3..-1]='...'
   #   end

   #   item_image = images[i].children.children[1].attributes['src'].value
     

   #   product = Product.new(title: title, price: price, stars_link: star_rating_link, item_show_link: item_page_link, item_image: item_image)
   #   results << product

   #   puts "Title:     #{title}"
   #   puts "Price:     #{price}"
   #   puts "Stars:     #{star_rating_link}"
   #   puts "More Info: #{item_page_link}"
   #   puts "Image:     #{item_image}"
   #   puts "XXXXXXXXXXXXXXX"
   # end
   # results
    results = Product.limit(5)
  end

  def user_review_scrape(link)
    agent = Mechanize.new
    page  = agent.get(link)

    star_number_class = agent.page.parser.css('.acrStars')[0].children[0].attributes['class'].value
    number_of_reviews = agent.page.parser.css('.acrCount')[0].children.children.text
  #user quotes
    quote_length = agent.page.parser.css('#quotesContainer > div > div').length
    3.times do |i|
      quote = agent.page.parser.css("#advice-quote-#{i.to_s} > span")  #advice-quote-0 is what changes
      link_to_quote = quote.css('a')[0].attributes['href'].value 
      first_half = quote.css('a > span')[0].children.text
      second_half = quote.css('span > span > a')[0].children.text.strip
      quote_text = first_half + second_half
      quote_author = quote[1].css('span > span')[0].children.text
      quote_similar = quote[1].css('span > span')[2].children.text

      #user helpful reviews
      title_area = agent.page.parser.css('#revMH > .mb30 > div')[i] #change 0 to get others
      user_star = title_area.css('.ttl').children[0].attributes['class'].value
      user_title = title_area.css('.ttl > a > strong')[0].text
      review_text = title_area.css('.MHRHead').to_html
      puts "Review: #{review_text}"
    end
  end

  def get_price(item)
    if item.css('span').children[1].text.include?('$')
      price = item.css('span').children[1].text
    else
      price = item.css('span').children[2].text
    end
    price
  end
end



# #customerReviews


# product title
# stars big
# review count

# each indiv quotes 
#   quote_Text and authors and quote_similar

# each user review 
#   title
#   user_star
#   user_title
#   review_text















