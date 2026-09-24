require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.9.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53c62eaa061f3c5bf84234d0b1191d385079ff8fc8b47d7aad4493a5815caa88',
     armv7l: '53c62eaa061f3c5bf84234d0b1191d385079ff8fc8b47d7aad4493a5815caa88',
       i686: 'f0c000b84aab95c480e21f8be248eed8838965455fa69b8e6d111122fa8aeaf7',
     x86_64: 'fdcab0c8ac0956068b922efef98a6b24216c20cf171db8a060b092327e6cfd18'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
