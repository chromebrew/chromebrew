require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.9.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.9.2.tar.gz'
  source_sha256 'a2e152a352bbf02d222d54074199d9c53821c19f700c4cb85f78fa85faed7896'

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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Mutt configuration
      export SASL_PATH=#{CREW_PREFIX}/lib/sasl2
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/mutt", @env)
  end
end
