require 'package'
require_relative 'harfbuzz'

class Ragel < Package
  description 'Ragel compiles executable finite state machines from regular languages. Now bundled with harfbuzz.'
  homepage 'https://www.colm.net/open-source/ragel/'
  version Harfbuzz.version
  license 'MIT' # Previously was GPL-2
  compatibility 'x86_64 aarch64 armv7l'

  is_fake

  depends_on 'harfbuzz'
end
