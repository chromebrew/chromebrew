require 'package'
Package.load_package("#{__dir__}/sdl2.rb")

class Libsdl2 < Package
  description Sdl2.description
  homepage Sdl2.homepage
  version Sdl2.version
  license Sdl2.license
  compatibility Sdl2.compatibility

  is_fake

  depends_on 'sdl2'
end
