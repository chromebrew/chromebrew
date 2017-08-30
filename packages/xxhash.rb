require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'http://cyan4973.github.io/xxHash/'
  version '0.6.2'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.6.2.tar.gz'
  source_sha256 'e4da793acbe411e7572124f958fa53b280e5f1821a8bf78d79ace972950b8f82'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80ff36655817a72e925863db7408ab312b5c4eb6f98f5d820db5d41c3a8336ec',
     armv7l: '80ff36655817a72e925863db7408ab312b5c4eb6f98f5d820db5d41c3a8336ec',
       i686: 'd9cad0c7b9f2d84b6c2805a53e5444bea8e8bf75470373d32811ca931bf9ff53',
     x86_64: '28d9f2b452bc40df319ceb319a9360866228ba0f5fa7ede59805f3165c720e95',
  })

  def self.build
    system "make"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_DIR}/usr/local/bin", "#{CREW_DEST_DIR}/usr/local/man/man1"]
    FileUtils.cp "xxhsum", "#{CREW_DEST_DIR}/usr/local/bin/"
    FileUtils.cp "xxhsum.1", "#{CREW_DEST_DIR}/usr/local/man/man1/"
  end
end
