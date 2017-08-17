require 'package'

class A2png < Package
  description 'Converts plain ASCII text into PNG bitmap images.'
  homepage 'https://sourceforge.net/projects/a2png/'
  version '0.1.5'
  source_url 'https://sourceforge.net/projects/a2png/files/a2png/0.1.5/a2png-0.1.5.tar.bz2'
  source_sha256 'd3ae1c771f5180d93f35cded76d9bb4c4cc2023dbe65613e78add3eeb43f736b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/a2png-0.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/a2png-0.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/a2png-0.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/a2png-0.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ab9734f65e6cf3dc414713d77c9f0347e6a5c6ba7c3bf7057739cb8e06ee301',
     armv7l: '5ab9734f65e6cf3dc414713d77c9f0347e6a5c6ba7c3bf7057739cb8e06ee301',
       i686: '03b5deb42bb5a699e797cb4c9735131a41bbb933ad332bfd5e787840184e0a59',
     x86_64: 'af075e42a66c48067db3a3f12dc771b407d0f7b4e5a1ab5d012b535098b015f2',
  })

  depends_on 'cairo'

  def self.build
    system './configure --enable-cairo \
            --with-cairo-lib=/usr/local/lib \
            --with-cairo-include=/usr/local/include/cairo'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

