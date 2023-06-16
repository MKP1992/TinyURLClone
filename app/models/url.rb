class Url < ApplicationRecord
	
	before_validation :generate_slug

	validates_presence_of :original_url
	validates :original_url, format: URI::regexp(%w[http https])
	validates_uniqueness_of :slug
	validates_length_of :original_url, within: 3..255, on: :create, message: "too long"
	validates_length_of :slug, within: 3..100, on: :create, message: "too long"
	
	has_many :visits, dependent: :destroy

	
	def generate_slug
	  self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
	  true
	end

end
