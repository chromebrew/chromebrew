require 'package'
require_relative 'liba52'

class A52 < Package
  description Liba52.description
  homepage Liba52.homepage
  version Liba52.version
  license Liba52.license
  compatibility Liba52.compatibility

  is_fake

  depends_on 'liba52'
end
