require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.0.7-1'
  compatibility 'all'
  source_url 'http://sourceforge.net/projects/zsh/files/zsh/5.0.7/zsh-5.0.7.tar.gz/download'
  source_sha256 '43f0a4c179ef79bb8c9153575685f7f45f28a3615c8cf96345f503d5b9e7b919'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zsh-5.0.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zsh-5.0.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zsh-5.0.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zsh-5.0.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'daaecbc646bada9365f22f26ba7de4a835079fd10a5353f3fa1c67beb27d5881',
     armv7l: 'daaecbc646bada9365f22f26ba7de4a835079fd10a5353f3fa1c67beb27d5881',
       i686: '2e138f7ddfc2252c81a379e379837ebd69f19e001184729180b9c43b979301aa',
     x86_64: '132f36ade3c10430d8f702112f82065fab8449ebd8dc409542930de5cc95e3c2',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
