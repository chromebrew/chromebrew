require 'package'
Package.load_package("#{__dir__}/python2.rb")

class Python27 < Package
  description 'A compatibility package for python2.'
  homepage Python2.homepage
  version Python2.version
  license Python2.license
  compatibility Python2.compatibility

  is_fake

  depends_on 'python2'
end
