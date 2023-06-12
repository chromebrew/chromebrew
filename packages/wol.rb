require 'package'

class Wol < Package
  description 'Wake up hardware that is Magic Packet compliant'
  homepage 'https://ahh.sourceforge.net/wol/'
  version '0.7.1-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/ahh/wol-0.7.1.tar.gz'
  source_sha256 'e0086c9b9811df2bdf763ec9016dfb1bcb7dba9fa6d7858725b0929069a12622'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wol/0.7.1-1_armv7l/wol-0.7.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wol/0.7.1-1_armv7l/wol-0.7.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wol/0.7.1-1_i686/wol-0.7.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wol/0.7.1-1_x86_64/wol-0.7.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b07eb72d647bbb6907b62196ea0d88c23d7564bc0335fd32f3bb1b2c9f1eab6a',
     armv7l: 'b07eb72d647bbb6907b62196ea0d88c23d7564bc0335fd32f3bb1b2c9f1eab6a',
       i686: '09bdc20009def407f64d45814deb7415381fd1f6b3ccebd83e67dabd3f809dbc',
     x86_64: '01b2449b8062b3d188d9caadbc327894f24af04942409e5a620eae28e20d106d'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "MANDIR=#{CREW_DEST_MAN_PREFIX}/man1", 'install'
  end
end
