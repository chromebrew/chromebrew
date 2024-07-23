require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.2.12'
  license 'GPL-2'
  compatibility 'all'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-2.2.12.tar.gz'
  source_sha256 '043af312f64b8e56f7fd0bf77f84a205d4c498030bd9586457665c47bb18ce38'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd896cb0d3a3735d12951ba29b6f98b8f3cc32c4a29f6c9e4a26186f0ace42b71',
     armv7l: 'd896cb0d3a3735d12951ba29b6f98b8f3cc32c4a29f6c9e4a26186f0ace42b71',
       i686: '6ca743089425ed3d40bac6e3267d04ba3916244010b8ad9be50a720b01a88e4f',
     x86_64: '1e877319f01ee8343036dfcd11bf4ba71a0f7ded74a6f3f9c585ae4dd5a1f5e8'
  })

  depends_on 'libcyrussasl'
  depends_on 'libxslt'

  configure_options "--with-mailpath=#{CREW_PREFIX}/etc/mail \
    --with-sasl=#{CREW_LIB_PREFIX}/sasl2 \
    --with-ssl \
    --enable-imap \
    --enable-smtp \
    --enable-hcache"

  run_tests

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/mail"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/mutt", <<~MUTTEOF
      # Mutt configuration
      SASL_PATH=#{CREW_LIB_PREFIX}/sasl2
    MUTTEOF
  end
end
