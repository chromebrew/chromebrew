require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.9.5'
  source_url 'https://www.nano-editor.org/dist/v2.9/nano-2.9.5.tar.xz'
  source_sha256 '7b8d181cb57f42fa86a380bb9ad46abab859b60383607f731b65a9077f4b4e19'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.9.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.9.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.9.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.9.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '127c08b4f613b9beb34f73334b201345eaa6375951da4a9f672fa1f710a519a3',
     armv7l: '127c08b4f613b9beb34f73334b201345eaa6375951da4a9f672fa1f710a519a3',
       i686: 'fd5962055dffc82f039023f7f454873abe76bfa53f51ce87d2e648f813cb8862',
     x86_64: 'd8d56d3e5cc9e5db5ac312454231886dd327fecc122fb9d91231427eaa294cd8',
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
    system "mkdir -pv #{CREW_DEST_DIR}$HOME"
    system "touch #{CREW_DEST_DIR}$HOME/.nanorc"
  end

  def self.postinstall
    puts
    puts "Personal configuration file is located in $HOME/.nanorc".lightblue
    puts
    open("#{ENV['HOME']}/.nanorc", 'w') { |f|
      f << "set autoindent\n"
      f << "set constantshow\n"
      f << "set fill 72\n"
      f << "set historylog\n"
      f << "set multibuffer\n"
      f << "set nohelp\n"
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
