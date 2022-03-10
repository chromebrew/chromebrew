require 'package'

class Ragel < Package
  description 'Ragel compiles executable finite state machines from regular languages. Now built inside harfbuzz'
  homepage 'https://www.colm.net/open-source/ragel/'
  version '1.0'
  license 'MIT' # Previously was GPL-2
  compatibility 'all'

  depends_on 'harfbuzz'
  is_fake

end
