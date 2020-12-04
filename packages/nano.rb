require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '5.3'
  compatibility 'all'
  source_url 'https://www.nano-editor.org/dist/v5/nano-5.3.tar.xz'
  source_sha256 'c5c1cbcf622d9a96b6030d66409ed12b204e8bc01ef5e6554ebbe6fb1d734352'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c088b2e58da273d13b81f811e29ea8947f53b1b35fc35247c65d238599e70e2f',
     armv7l: 'c088b2e58da273d13b81f811e29ea8947f53b1b35fc35247c65d238599e70e2f',
       i686: '6fcb71493680e38de8dfc0339203ef432599253a2a1f0f6d34cfbd6839c01eec',
     x86_64: 'd9a04eeb1624ccbcf1823a95b00ff6487a04cb49a749abf19a2014a00871e876',
  })

  depends_on 'xdg_base'

  def self.patch
    system "sed -i '/SIGWINCH/d' src/nano.c"
  end

  def self.build
    system './configure',
           '--enable-utf8',
           "--prefix=#{CREW_PREFIX}"
    system 'make'
    open('nanorc', 'w') { |f|
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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
    system "install -Dm644 nanorc #{CREW_DEST_HOME}/.nanorc"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.local/share"
    FileUtils.ln_sf("#{CREW_PREFIX}/share/nano", "#{CREW_DEST_HOME}/.local/share/")
  end

  def self.postinstall
    puts
    puts "Personal configuration file is located in $HOME/.nanorc".lightblue
    puts
    puts "To make nano your default editor, execute the following:".lightblue
    puts
    puts "echo 'EDITOR=#{CREW_PREFIX}/bin/nano' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
