require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.2.10'
  license 'GPL-2'
  compatibility 'all'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-2.2.10.tar.gz'
  source_sha256 '4d773f22422f79096f7b94b57bee45654ad9a25165dbb36463c58295b4cd3d88'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.2.10_armv7l/mutt-2.2.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.2.10_armv7l/mutt-2.2.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.2.10_i686/mutt-2.2.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutt/2.2.10_x86_64/mutt-2.2.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1d113f20e2ca2f4adde9a207e60978a20b1172b18b901be7837dd6122dcdaea0',
     armv7l: '1d113f20e2ca2f4adde9a207e60978a20b1172b18b901be7837dd6122dcdaea0',
       i686: '3a831a695aa4a276863cf43ca9f72c47942da7d299e0ae4c82c6310edddd8553',
     x86_64: '0e325a6a0e00e42b8b339b599c57641a28724fa2d3574b26112f8be9e2a4b785'
  })

  depends_on 'libcyrussasl'
  depends_on 'libxslt'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-mailpath=#{CREW_PREFIX}/etc/mail \
            --with-sasl=#{CREW_LIB_PREFIX}/sasl2 \
            --with-ssl \
            --enable-imap \
            --enable-smtp \
            --enable-hcache"
    system 'make'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @muttenv = <<~MUTTEOF
      # Mutt configuration
      SASL_PATH=#{CREW_LIB_PREFIX}/sasl2
    MUTTEOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/mail"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/mutt", @muttenv)
  end
end
