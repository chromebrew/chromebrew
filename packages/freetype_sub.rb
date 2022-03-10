require 'package'

class Freetype_sub < Package
  description 'Freetype_sub was a version w/o harfbuzz, now handled within harfbuzz'
  homepage 'https://www.freetype.org/'
  version '1.0'
  license 'FTL or GPL-2+'
  compatibility 'all'

  depends_on 'freetype'
  is_fake

end
