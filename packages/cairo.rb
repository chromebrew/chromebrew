require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.5-ec54603'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'

  depends_on 'harfbuzz'
  is_fake

end
