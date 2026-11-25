require 'buildsystems/cmake'

class Geos < CMake
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://libgeos.org/'
  version '3.15.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/libgeos/geos.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a73f15ff9c63a0cd55051ef716a820c29107961ce97794c7797265efc2e791b0',
     armv7l: 'a73f15ff9c63a0cd55051ef716a820c29107961ce97794c7797265efc2e791b0',
       i686: 'a6e832645f0d644d89d3fa856f5fbb901cb70437e46d65f3f7c93affa262b117',
     x86_64: 'a5f56ccbd6cd8bcc9ad1d7ca1335f23138a1c3b728a101fb709cea99a0e72de9'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
