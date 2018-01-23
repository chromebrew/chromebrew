require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.9.1'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.9.1.tar.gz'
  source_sha256 '749b83a96373c6e2101ebe8c4b9a651735e02c478edb750750a5146a15d91bb1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7d0ecbe964f7c76e8206297c29dfabf40e725ed0677a5cdd6ba89c6591c57c63',
     armv7l: '7d0ecbe964f7c76e8206297c29dfabf40e725ed0677a5cdd6ba89c6591c57c63',
       i686: 'c755e1e814a1f7660316308b86b53e8cf11db72c83c1223c84f63abc61f00230',
     x86_64: 'fec90a3d7928479772c0b285ccc44f4746c4f1de86e96d7aa7598edf24218da2',
  })

  depends_on 'perl'
  depends_on 'libxslt'
  depends_on 'openssl'
  depends_on 'libcyrussasl' => :build
  depends_on 'gdbm'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --with-mailpath=#{CREW_PREFIX}/mail
            --enable-imap 
            --with-ssl 
            --enable-smtp 
            --with-sasl=/usr/local/lib/sasl2 
            --enable-hcache"
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/mail"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "echo 'export SASL_PATH=/usr/local/lib/sasl2' >> ~/.bashrc"
  end
end
