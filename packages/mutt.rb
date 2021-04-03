require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.0.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-2.0.6.tar.gz'
  source_sha256 '81e31c45895fd624747f19106aa2697d2aa135049ff2e9e9db0a6ed876bcb598'

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
