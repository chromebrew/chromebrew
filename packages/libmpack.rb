# Adapted from Arch Linux libmpack PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libmpack/trunk/PKGBUILD

require 'package'

class Libmpack < Package
  description 'Simple implementation of msgpack in C'
  homepage 'https://github.com/libmpack/libmpack'
  version '1.0.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libmpack/libmpack/archive/1.0.5.tar.gz'
  source_sha256 '4ce91395d81ccea97d3ad4cb962f8540d166e59d3e2ddce8a22979b49f108956'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b657165f886604233c07ce4c441c3d10cf6452ae736de3bb9d137c39fda5526',
     armv7l: '9b657165f886604233c07ce4c441c3d10cf6452ae736de3bb9d137c39fda5526',
       i686: '2e56cc0bb40917c96f0458535e3c91d41e03f2495359e8549593fd5385c22de6',
     x86_64: '03342ec096b7cd7c2d3651b0f0f339f2f254ca3b06c8f3b2336968087dcb3ecd'
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX}"
  end
end
