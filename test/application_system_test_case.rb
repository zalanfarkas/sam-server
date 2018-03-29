# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
