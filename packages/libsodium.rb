require 'package'

class Libsodium < Package
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  version '1.0.18-RELEASE'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/jedisct1/libsodium/archive/refs/tags/1.0.18-RELEASE.tar.gz'
  source_sha256 'b7292dd1da67a049c8e78415cd498ec138d194cfdb302e716b08d26b80fecc10'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e87f51f0f58dfd46cd547bbe8548c9dd8fc18260c022c6440c2e2d64673de0f1',
     armv7l: 'e87f51f0f58dfd46cd547bbe8548c9dd8fc18260c022c6440c2e2d64673de0f1',
       i686: 'd1a7c85be6511c084b6830e9e0786e07efbc79a415e9bddc8961486bf355a41f',
     x86_64: '46856f8d0724b7c52dc8c2b657e9f49da97bd2eaee423c3055eb426b29a200a5'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
