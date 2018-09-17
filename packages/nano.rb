require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '3.0'
  source_url 'https://www.nano-editor.org/dist/v3/nano-3.0.tar.xz'
  source_sha256 'e0a5bca354514e64762c987c200a8758b05e7bcced3b00b3e48ea0a2d383c8a0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dfe6697ad765fb20a78d7a8e7fec8eb3b603ca94d08efb1542667067f91a7904',
     armv7l: 'dfe6697ad765fb20a78d7a8e7fec8eb3b603ca94d08efb1542667067f91a7904',
       i686: '63984d3fc80bbf58cdd46ef3fd183e3fd145a0ab50e931a99f789286a05791fa',
     x86_64: 'dc7d01d8bf910cb2a242687212bea0bedf520006a594ef92f038cc1a1f76cb2a',
  })

  depends_on 'filecmd'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--enable-utf8"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
    system "mkdir -pv #{CREW_DEST_HOME}"
    system "touch #{CREW_DEST_HOME}/.nanorc"
  end

  def self.postinstall
    puts
    puts "Personal configuration file is located in $HOME/.nanorc".lightblue
    puts
    open("#{ENV['HOME']}/.nanorc", 'w') { |f|
      f << "set constantshow\n"
      f << "set fill 72\n"
      f << "set historylog\n"
      f << "set multibuffer\n"
      f << "set nowrap\n"
      f << "set positionlog\n"
      f << "set historylog\n"
      f << "set quickblank\n"
      f << "set regexp\n"
      f << "set smooth\n"
      f << "set suspend\n"
    }
  end
end
