require 'package'

class Trousers < Package
  description 'The open-source TCG Software Stack.'
  homepage 'http://trousers.sourceforge.net/'
  @_ver = '0.3.15'
  version @_ver
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/trousers/trousers/#{@_ver}/trousers-#{@_ver}.tar.gz"
  source_sha256 '1e5be93e518372acf1d92d2f567d01a46fdb0b730487e544e6fb896c59cac77f'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.15-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.15-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.15-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'd9f1c2a10973b25b26576c8c7c913b4ff898417a6f425732a81b22b4c8daa566',
      armv7l: 'd9f1c2a10973b25b26576c8c7c913b4ff898417a6f425732a81b22b4c8daa566',
        i686: 'bc2f18fada6ff3dc0203aa87d7a2e3b001d18db59aae3d094f2341bffa530c24',
      x86_64: '40601f6366e0d308ece858293e0cc61fcc31ce568b796ea37beb3c3e34ab370f',
  })

  depends_on 'openssl'
  depends_on 'libtool'
  depends_on 'pkgconfig'

  def self.build
    system "./bootstrap.sh"
    system "CFLAGS='-fcommon -flto -pipe' ./configure \
      #{CREW_OPTIONS} \
      --with-gui=none"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
