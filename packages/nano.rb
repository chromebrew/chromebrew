require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '3.1'
  source_url 'https://www.nano-editor.org/dist/v3/nano-3.1.tar.xz'
  source_sha256 '14c02ca40a5bc61c580ce2f9cb7f9fc72d5ccc9da17ad044f78f6fb3fdb7719e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b104f51c34448e5f20b6f0ab1a446ba85701464e40ed96484ecadeb2fb09c9cb',
     armv7l: 'b104f51c34448e5f20b6f0ab1a446ba85701464e40ed96484ecadeb2fb09c9cb',
       i686: 'd187d05f68885e4ce3afb3726d5ab684d4a97f2c67ea3d1b917893db64120fa8',
     x86_64: '492bc56f517c1c0c4cc52bdfc210b8b6cd1f072e3da5605f406c99d4be7e11ac',
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
