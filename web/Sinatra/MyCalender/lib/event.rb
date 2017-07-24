require 'yaml'

class Event
  attr_accessor :name, :type

  def initialize(name, type)
    @name = name
    @type = type
  end

  def self.day_events
    @day_events ||= YAML.load_file('./event.yml')
  end
end