class Movie < ActiveRecord::Base

	has_many :reviews 

	validates :title,
	presence: true

	validates :director,
	presence: true

	validates :runtime_in_minutes,
	numericality: { only_integer: true }

	validates :description,
	presence: true

	validates :poster_image_url,
	presence: true

	validates :release_date,
	presence: true

	#custom validation 
	validate :release_date_is_in_the_past


	def review_average 
    if !reviews.empty?
		  reviews.sum(:rating_out_of_ten)/reviews.size
    end
	end

	def self.search_title_director(search_term)
    if search_term.blank?
      self.all
    elsif search_term
      self.where('title LIKE ? or director LIKE ?', "%#{search_term}%", "%#{search_term}%")
    else
      self.all
    end
  end

  def self.search_runtime(runtime)
    case runtime 
    when "under90" then self.runtime_under(90)
    when "between90_120" then self.runtime_over(90).runtime_under(120)
    when "over120" then self.runtime_over(120) 
    else
      self.all 
    end
  end

  def self.runtime_under(value)
    self.where('runtime_in_minutes < ?', value)
  end

  def self.runtime_over(value)
    self.where('runtime_in_minutes > ?', value)
  end

  def self.search(search_term, runtime)
    self.search_title_director(search_term).search_runtime(runtime)
  end



	protected

	def release_date_is_in_the_past
		if release_date.present?
			errors.add(:release_date, "should be in the past") if release_date > Date.today
		end
	end
end
