require 'buildsystems/cmake'

class Geos < CMake
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://libgeos.org/'
  version '3.15.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/libgeos/geos.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a1ef15f80382b1fc219070c113befedf489adc754fc0961d3a2faf959d5e14a',
     armv7l: '0a1ef15f80382b1fc219070c113befedf489adc754fc0961d3a2faf959d5e14a',
       i686: '65c5e063057d6d16fe4598710a8479d7d2c880d431ee75aecbebd6d6aae1a223',
     x86_64: 'f64cae983257535e7303d6de18c18e1a826063a125b1c22d5c693179b93050d6'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
