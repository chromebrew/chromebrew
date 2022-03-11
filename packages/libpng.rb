require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library. Now bundled with harfbuzz.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version "1.0"
  license 'libpng2'
  compatibility 'all'

  depends_on 'harfbuzz'
  is_fake

end
