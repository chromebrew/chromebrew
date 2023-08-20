require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.2.11'
  license 'GPL-2'
  compatibility 'all'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-2.2.11.tar.gz'
  source_sha256 '12325cf66d5ff8ac4bd87fac8db52c869de52dd278fc301cfd57d5a1f9f465cc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.2.11_armv7l/mutt-2.2.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.2.11_armv7l/mutt-2.2.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.2.11_i686/mutt-2.2.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.2.11_x86_64/mutt-2.2.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '98bc06c612dcc678fc32265f832e749660413a316b1f8c319ade106cef04011e',
     armv7l: '98bc06c612dcc678fc32265f832e749660413a316b1f8c319ade106cef04011e',
       i686: 'ae547bc244cbd265563341f9a93dc221ffc552ec6538544167be22b2e842f105',
     x86_64: '31e4c665796270c5a24bc6697ce01e71f5fd8f355ad4fb66eb27c200573b9377'
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
