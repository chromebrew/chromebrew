require 'package'

class Desktop_file_utilities < Package
  description 'A package file for legacy compatibility'
  homepage ''
  version '1.0'
  license 'GPL-3+'
  compatibility 'all'

  is_fake

  depends_on 'desktop_file_utils'
end
