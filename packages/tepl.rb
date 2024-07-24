require 'package'
Package.load_package("#{__dir__}/tepl_5.rb")
Package.load_package("#{__dir__}/tepl_6.rb")

class Tepl < Package
  description Tepl_5.description
  homepage Tepl_5.homepage
  version "#{Tepl_5.version}+#{Tepl_6.version}"
  license Tepl_5.license
  compatibility Tepl_5.compatibility

  is_fake

  depends_on 'tepl_5'
  depends_on 'tepl_6'
end
