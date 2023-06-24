require 'package'

class Libsigcplusplus < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'https://github.com/libsigcplusplus/libsigcplusplus/'
  version '2.10.8'
  license 'LGPL-3'
  compatibility 'all'
  source_url "https://github.com/libsigcplusplus/libsigcplusplus/archive/#{version}.tar.gz"
  source_sha256 '3a66dfb699cf5301f5e141895c9db728006c2e09f006af62d847e3808609e418'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus/2.10.8_armv7l/libsigcplusplus-2.10.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus/2.10.8_armv7l/libsigcplusplus-2.10.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus/2.10.8_i686/libsigcplusplus-2.10.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus/2.10.8_x86_64/libsigcplusplus-2.10.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6263e9ad88da5830a36c59513aa77f7f8d72e1b5fe4ea45a2da9d94debc50475',
     armv7l: '6263e9ad88da5830a36c59513aa77f7f8d72e1b5fe4ea45a2da9d94debc50475',
       i686: 'a97d4d50525a1f371650e08bc298882065fbd679eb81fe6d646953043045d46a',
     x86_64: 'c658c6682a62e95b18b67dcacdad51b7a724f7a69143271e03a8f82852fb904f'
  })

  depends_on 'mm_common'
  depends_on 'graphviz' => :build # needed for dot
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dmaintainer-mode=true \
    -Dbuild-deprecated-api=true \
    -Dbuild-examples=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
