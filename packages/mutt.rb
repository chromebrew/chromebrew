require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.0.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-2.0.6.tar.gz'
  source_sha256 '81e31c45895fd624747f19106aa2697d2aa135049ff2e9e9db0a6ed876bcb598'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.0.6_armv7l/mutt-2.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.0.6_armv7l/mutt-2.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.0.6_i686/mutt-2.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.0.6_x86_64/mutt-2.0.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2f3f18827cb8a2c0a5a48e04397c4c4bf811cad82a8a235081a9f54ba227308f',
     armv7l: '2f3f18827cb8a2c0a5a48e04397c4c4bf811cad82a8a235081a9f54ba227308f',
       i686: 'd43f6599f9c83c487a2302015e1be9c8d28702fe8d8feab092cbc5b37a54e4a4',
     x86_64: '3dedfd9092e58cba771c3af7079bf608b11960df2d30989254187501befccecc'
  })

  depends_on 'libxslt'

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
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @muttenv = <<~MUTTEOF
      # Mutt configuration
      export SASL_PATH=#{CREW_PREFIX}/lib/sasl2
    MUTTEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/mutt", @muttenv)
  end
end
