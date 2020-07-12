

class SearchResultsPage < BasePage
  include PageObject
  include PageObject::PageFactory
  include DataMagic

  attr_accessor :browser

  page_url "#{$BASE_URL}""#{$ENVIRONMENT['search']}"
  element :pg_text, xpath:"//section//vhm-result-narrative//h3//span"
  elements :prices, xpath:"//section//vhm-result-card//div[contains(@class,'price-container')]/div[contains(@class,'price')]"
  h4s :hotel_name, css: ".hotel-name"
  h3 :total_number_of_hotels, xpath: "//h3[contains(@class, 'hotel-count')]"

  element :sort_asc, xpath: "//div[contains(@class,'search-result-component')]//div[contains(@class,'form-group')]//select//option[contains(text(),'Price Low to High')]"
  select_list :select_sorting, xpath: "//div[contains(@class,'search-result-component')]//div[contains(@class,'form-group')]//select"


  def hotel_names
    wait_until(30){pg_text_element.visible?}
    hotel_name_elements.all?{ |hotel_name|hotel_name.visible? }
  end

  def hotel_prices
    wait_until(30){pg_text_element.visible?}
    prices_elements.all?{|price|price.text.include? '£'}
  end

  def sorting text
    wait_until(60){
      select_sorting_element.visible?
    }

    scroll_to_bottom

    sort_value=@browser.element(:xpath,"//div[contains(@class,'search-result-component')]//div[contains(@class,'form-group')]//select//option[contains(text(),'#{text}')]")
    manual_sorted_array=array_manual_sort_prices
    click_sort_value(sort_value)
    sorted_array=price_values_after_click
    manual_sorted_array==sorted_array
  end

  def price_values_after_click
    price_values_after_click=prices_elements.map{ |x| x.text.split(/\n/).first.gsub('£','').to_i}
    return price_values_after_click
  end

  def array_manual_sort_prices
    scroll_to_bottom
    actual_price_values=prices_elements.map{ |x| x.text.split(/\n/).first.gsub('£','').to_i}
    sorted_array=actual_price_values.sort
    return sorted_array
  end

  def click_sort_value(sort_value)
    wait_until(30){sort_value.visible?}
    sort_value.click
  end

  def scroll_to_bottom
  hotel_count=total_number_of_hotels.match(/\d+/).to_s.to_i
  hotel_count=hotel_count + 100
  no_of_hotel=prices_elements.length
    while no_of_hotel < hotel_count
      wait_until(60){@browser.scroll.to :bottom ;break}
      no_of_hotel+=4
    end
  end

end