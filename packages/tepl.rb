require 'package'
Package.load_package("#{__dir__}/tepl_6.rb")

class Tepl < Package
  description Tepl_6.description
  homepage Tepl_6.homepage
  version Tepl_6.version
  license Tepl_6.license
  compatibility Tepl_6.compatibility

  is_fake

  depends_on 'tepl_6'
end
