# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

#superclass of all models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
