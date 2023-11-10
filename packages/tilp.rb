require 'package'
require_relative 'tilp2'

class Tilp < Package
  description Tilp2.description
  homepage Tilp2.homepage
  version Tilp2.version
  license Tilp2.license
  compatibility Tilp2.compatibility

  is_fake

  depends_on 'tilp2'
end
