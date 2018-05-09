require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.9.5'
  source_url 'https://www.nano-editor.org/dist/v2.9/nano-2.9.5.tar.xz'
  source_sha256 '7b8d181cb57f42fa86a380bb9ad46abab859b60383607f731b65a9077f4b4e19'

  depends_on 'ncurses'
  depends_on 'filecmd'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--enable-utf8"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
    
    system "mkdir -pv #{CREW_DEST_DIR}/home/chronos/user"
    system "touch #{CREW_DEST_DIR}/home/chronos/user/.nanorc"
  end
  
  def self.postinstall
    puts "Personal configuration file is located in /home/chronos/user/.nanorc".lightgreen
    open('/home/chronos/user/.nanorc', 'w') { |f|
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
