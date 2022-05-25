require 'package'

class Libsigcplusplus3 < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'https://github.com/libsigcplusplus/libsigcplusplus/'
  version '3.4.0'
  license 'LGPL-3'
  compatibility 'all'
  source_url "https://github.com/libsigcplusplus/libsigcplusplus/releases/download/#{version}/libsigc++-#{version}.tar.xz"
  source_sha256 '02e2630ffb5ce93cd52c38423521dfe7063328863a6e96d41d765a6116b8707e'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus3/3.4.0_armv7l/libsigcplusplus3-3.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus3/3.4.0_armv7l/libsigcplusplus3-3.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus3/3.4.0_i686/libsigcplusplus3-3.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus3/3.4.0_x86_64/libsigcplusplus3-3.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '02918d29c105c7b91fc1f6aeb9cb88f2ae16d00f95f8415af45f92069124d93a',
     armv7l: '02918d29c105c7b91fc1f6aeb9cb88f2ae16d00f95f8415af45f92069124d93a',
       i686: '6b0b875ec492e9ae495faaf20fab5395f473f9bbe59419991414e6bba517972a',
     x86_64: 'c5c4e1f5421277150a78f7405eb62722da36a5c182a3e38c8b9a56c07aee3a60'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-examples=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
