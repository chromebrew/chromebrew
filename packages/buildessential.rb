require 'package'

class Buildessential < Package
  version '1.0'
  
  is_fake
  
  depends_on 'gcc'
  depends_on 'make'
  depends_on 'linuxheaders'
  depends_on 'pkgconfig'
end
