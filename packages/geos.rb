require 'buildsystems/cmake'

class Geos < CMake
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://libgeos.org/'
  version '3.14.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/libgeos/geos.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8218f82c8e8005a4d52b2a0c539800b0d5945f98627daf3e7e53c32703ced5c',
     armv7l: 'd8218f82c8e8005a4d52b2a0c539800b0d5945f98627daf3e7e53c32703ced5c',
       i686: '6a50e6407976132d15a4e015b37ea88acfa9eea37ad643b7ce1ece3a7b7afe30',
     x86_64: 'f9987bd69f636cb17867c7a9b3a298b67ca1c2ab6032f98061e6b16d1338826b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
