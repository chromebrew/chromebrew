require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.9.2'
  compatibility 'all'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.9.2.tar.gz'
  source_sha256 'a2e152a352bbf02d222d54074199d9c53821c19f700c4cb85f78fa85faed7896'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0acaa6fa2863afa8da56a61ba99d365e2bdd73dc56e9801ee9b6e9338d33e2a2',
     armv7l: '0acaa6fa2863afa8da56a61ba99d365e2bdd73dc56e9801ee9b6e9338d33e2a2',
       i686: '97e12bc88aff256ea46c6389c69a5cf2623908c423ca43f08d6a905c0cb50391',
     x86_64: 'e8ca9e36db89e76471118d9620df06e9f6eac43c20eefd01810a98ca80149583',
  })

  depends_on 'gdbm'
  depends_on 'libcyrussasl'
  depends_on 'libxslt'
  depends_on 'openssl'
  depends_on 'perl'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --with-mailpath=#{CREW_PREFIX}/mail \
            --with-sasl=#{CREW_PREFIX}/lib/sasl2 \
            --with-ssl \
            --enable-imap \
            --enable-smtp \
            --enable-hcache"
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/mail"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export SASL_PATH=#{CREW_PREFIX}/lib/sasl2' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
