require 'package'

class Musl_expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.4.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/expat/expat/2.4.8/expat-2.4.8.tar.xz'
  source_sha256 'f79b8f904b749e3e0d20afeadecf8249c55b2e32d4ebb089ae378df479dcaf25'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da829889bc002774679a8ac8373a662b75469cd4e1e0efcf003165e3b1083e19',
     armv7l: 'da829889bc002774679a8ac8373a662b75469cd4e1e0efcf003165e3b1083e19',
       i686: 'e737950ec7ed54a5fa04d923e4f42710c063d1d8dd580a4f887d6b40e28a596d',
     x86_64: '06bfcf25868d41925874458068e56155028d027be365db5989079a92bb3570b2'
  })

  depends_on 'musl_native_toolchain' => :build

  is_musl
  is_static
  patchelf

  def self.patch
    system 'filefix'
  end

  def self.build
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --enable-static \
        --with-pic"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
