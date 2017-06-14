require 'package'

class Buildessential < Package
  description 'A collection of tools essential to compile and build software.'
  homepage ''
  version '1.0'
  
  is_fake
  
  depends_on 'gcc'
  depends_on 'linuxheaders'
  depends_on 'make'
  depends_on 'pkgconfig'
end
