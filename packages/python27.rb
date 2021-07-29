require 'package'

class Python27 < Package
  description 'A compatibility package for python2.'
  homepage 'https://www.python.org/'
  version '2.7.18-1'
  compatibility 'all'

  is_fake

  depends_on 'python2'
end
