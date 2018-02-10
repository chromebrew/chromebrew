require 'package'

class Buildessential < Package
  description 'A collection of tools essential to compile and build software.'
  homepage ''
  version '1.0-1'

  is_fake

  depends_on 'gcc'
  depends_on 'linuxheaders'
  depends_on 'make'
  depends_on 'pkgconfig'
  
  # typically required library to compile source code using "./autogen.sh"
  depends_on 'automake' 
  depends_on 'libtool'  
  depends_on 'intltool' 
  depends_on 'patch'
  
end
