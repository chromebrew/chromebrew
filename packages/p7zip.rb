require 'package'

class P7zip < Package
  description 'Dummy package that points to the official 7-zip package.'
  homepage 'http://p7zip.sourceforge.net/'
  version '21.07'
  license 'LGPL-2.1 and unRAR'
  compatibility 'all'

  is_fake

  depends_on 'pkg_7_zip'
end
