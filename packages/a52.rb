require 'package'
require_relative 'liba52'

class A52 < Package
  description Liba52.description.to_s
  homepage Liba52.homepage.to_s
  version Liba52.version.to_s
  license Liba52.license.to_s
  compatibility Liba52.compatibility.to_s

  is_fake

  depends_on 'liba52'
end
