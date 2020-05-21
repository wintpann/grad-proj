class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  @@bad_page=false
  @@current_page=0
  @@links_count=9
  @@items_for_page=2

  def self.items_for_page
    @@items_for_page
  end

  def self.total_pages
    (self.all.count.to_f/@@items_for_page).ceil
  end

  def self.links_half
    @@links_count/2
  end

  def self.links_count
    @@links_count
  end

  def self.bad_page?
    @@bad_page
  end

  def self.valid_page?(num)
    return true if num>=1 && num<=total_pages
    return false
  end

  def self.current_page
    @@current_page
  end

  def self.get_offset(page)
    page=page.to_i
    if page<1 || page>total_pages
      page=0
      @@bad_page=true
    else
      @@bad_page=false
      page=page-1
    end
    @@current_page=page+1
    offset={}
    offset[:first]=page*items_for_page
    offset[:last]=page*items_for_page+items_for_page
    return offset
  end

  def self.paginate(page)
    offset=get_offset(page)
    self.all[offset[:first]...offset[:last]]
  end
end
