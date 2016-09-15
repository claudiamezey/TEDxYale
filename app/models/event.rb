class Event < ActiveRecord::Base
  require 'aws-sdk-v1'
  require 'aws-sdk'

  attr_accessible :name, :location, :location_url, :image, :location_address,
                  :location_city, :location_state, :location_zipcode,
                  :published, :datetime, :sort, :paralink, :description, :header,
                  :thumbnail

  has_many :attendees
  has_many :users, :through => :attendees
  has_many :speakers
  has_many :sponsorships
  has_many :sponsors, :through => :sponsorships

  has_attached_file :header,
    :styles => { :large => "660x" },
    :storage => :s3,
        :s3_credentials => {
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
          :bucket => ENV['S3_BUCKET_NAME']
        }
  has_attached_file :thumbnail,
    :styles => { :medium => "300x200#", :small => "150x100#"},
    :storage => :s3,
        :s3_credentials => {
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
          :bucket => ENV['S3_BUCKET_NAME']
        }

  validates_attachment_content_type :thumbnail, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :header, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
