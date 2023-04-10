require 'package'
require_relative 'python2'

class Python27 < Package
  description 'A compatibility package for python2.'
  homepage Python2.homepage.to_s
  version Python2.version.to_s
  compatibility Python2.compatibility.to_s

  is_fake

  depends_on 'python2'
end
