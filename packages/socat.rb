require 'package'

class Socat < Package
  description 'SOcket CAT is a multipurpose relay \'netcat++\' (extended design, new implementation).'
  homepage 'http://www.dest-unreach.org/socat/'
  version '1.7.3.1'
  source_url 'http://www.dest-unreach.org/socat/download/socat-1.7.3.1.tar.gz'
  source_sha256 'a8cb07b12bcd04c98f4ffc1c68b79547f5dd4e23ddccb132940f6d55565c7f79'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/socat-1.7.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/socat-1.7.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/socat-1.7.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/socat-1.7.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '13c8f28d19634fbc78628b1e8025623ecb44911a953e5eb8c24a30cd7827f85d',
     armv7l: '13c8f28d19634fbc78628b1e8025623ecb44911a953e5eb8c24a30cd7827f85d',
       i686: '70b206c33915b8b8a1116b557f584749ba5c1305ce6dab56d3aac6bbaacbcfc4',
     x86_64: 'f2ba3f81bf1af864f61c5737f02a5dc9e67bb563911af28b1d6585298b0b54a9',
  })

  depends_on 'readline'
  depends_on 'openssl'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
