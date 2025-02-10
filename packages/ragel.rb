require 'package'
Package.load_package("#{__dir__}/harfbuzz.rb")

class Ragel < Package
  description 'Ragel compiles executable finite state machines from regular languages. Now bundled with harfbuzz.'
  homepage 'https://www.colm.net/open-source/ragel/'
  version Harfbuzz.version
  license 'MIT' # Previously was GPL-2
  compatibility 'aarch64 armv7l x86_64'

  is_fake

  depends_on 'harfbuzz'
end
