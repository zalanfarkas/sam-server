# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# configuration file for the CarrierWave library 
# responsible for handling student ID picture field of the
# student table in the database

# it uploads images to Amazon Web Services' S3 file storage in production
if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      :region                => ENV['S3_REGION']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  end
end