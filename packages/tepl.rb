require 'package'
require_relative 'tepl_5'
require_relative 'tepl_6'

class Tepl < Package
  description Tepl_5.description.to_s
  homepage Tepl_5.homepage.to_s
  version "#{Tepl_5.version}+#{Tepl_6.version}"
  license Tepl_5.license.to_s
  compatibility Tepl_5.compatibility.to_s

  is_fake

  depends_on 'tepl_5'
  depends_on 'tepl_6'
end
