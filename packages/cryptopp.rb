require 'package'

class Cryptopp < Package
  description 'Crypto++ Library is a free C++ class library of cryptographic schemes.'
  homepage 'https://cryptopp.com/'
  version '8.7.0'
  license 'public domain'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://cryptopp.com/cryptopp870.zip'
  source_sha256 'd0d3a28fcb5a1f6ed66b3adf57ecfaed234a7e194e42be465c2ba70c744538dd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5cd4b39d67c76ab8a2b346e4ce6a4e48ee446ee6e72885c67b0880fb39c1fb5c',
     armv7l: '5cd4b39d67c76ab8a2b346e4ce6a4e48ee446ee6e72885c67b0880fb39c1fb5c',
     x86_64: '3d69dca37750d1ef729ea30ee9e115399eaf256b8c2343985df23fded7608968'
  })

  depends_on 'unzip' => :build

  def self.build
    system 'make dynamic'
  end

  def self.install
    system "PREFIX=#{CREW_PREFIX} \
            LIBDIR=#{CREW_LIB_PREFIX} \
            DESTDIR=#{CREW_DEST_DIR} \
            make install-lib"
    # License.txt required for binary distribution.
    FileUtils.install 'License.txt', "#{CREW_DEST_PREFIX}/include/cryptopp", mode: 0o644
  end
end
