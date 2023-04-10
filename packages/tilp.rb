require 'package'
require_relative 'tilp2'

class Tilp < Package
  description Tilp2.description.to_s
  homepage Tilp2.homepage.to_s
  version Tilp2.version.to_s
  license Tilp2.license.to_s
  compatibility Tilp2.compatibility.to_s

  is_fake

  depends_on 'tilp2'
end
