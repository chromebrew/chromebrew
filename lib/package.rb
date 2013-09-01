require './lib/package_helpers'

class Package
  property :version, :binary_url, :binary_sha1, :source_url
  
  class << self
    attr_reader :dependencies
  end
  def self.depends_on (dependency = nil)
    @dependencies = [] unless @dependencies
    if dependency
      @dependencies << dependency
    end
    @dependencies
  end
end
