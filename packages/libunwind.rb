require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  @_ver = '1.5.0'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.5.0.tar.gz'
  source_sha256 '90337653d92d4a13de590781371c604f9031cdb50520366aa1e3a91e1efb1017'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '21a4912e68f2310216c3054ada90ab13886a11024402713520ea14c22d4c90a5',
     armv7l: '21a4912e68f2310216c3054ada90ab13886a11024402713520ea14c22d4c90a5',
       i686: '3f5e16bb0482bab2d8671b4f386b27c786b844398617ad2cead8f33f304322e3',
     x86_64: 'b7e31f468ce7114748f09cff66b6e8f04ad843db4c5a835d993b8ca80c0ff256'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
    ./configure #{CREW_OPTIONS} --enable-ptrace"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libunwind.so.8.0.1", "#{CREW_DEST_LIB_PREFIX}/libunwind.so.1"
  end
end
