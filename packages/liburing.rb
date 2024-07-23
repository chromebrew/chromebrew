require 'buildsystems/autotools'

class Liburing < Autotools
  description 'liburing provides helpers to setup and teardown io_uring instances.'
  homepage 'https://github.com/axboe/liburing/'
  version '2.6'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/axboe/liburing/archive/refs/tags/liburing-#{version}.tar.gz"
  source_sha256 '682f06733e6db6402c1f904cbbe12b94942a49effc872c9e01db3d7b180917cc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e2138ccaa2ff821f507991b73c549c7c55e55818641970cd5576de4f4be9216',
     armv7l: '2e2138ccaa2ff821f507991b73c549c7c55e55818641970cd5576de4f4be9216',
       i686: 'bc5f3ea29be3864de7e1a7c93b7f81744c39296b3513ea45d37b1e9a79581949',
     x86_64: '0ae8f0068aae43c33cb71cc7a8e3c7080979fd2b980e4a689a67b728317010e0'
  })

  depends_on 'glibc_lib' # R

  # liburing has a configure script that mimics an autotools one, but we can still treat it mostly like normal.
  # It doesn't have any other build system anyways, so this is the best we've got.
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --mandir=#{CREW_MAN_PREFIX}"
  end
end
