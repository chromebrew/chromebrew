require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '4.4'
  compatibility 'all'
  source_url 'https://www.nano-editor.org/dist/v4/nano-4.4.tar.xz'
  source_sha256 '2af222e0354848ffaa3af31b5cd0a77917e9cb7742cd073d762f3c32f0f582c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-4.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-4.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd90750f2218b77a4ddaf02915c8d06ff4f32868273a2709eb2906949c9bea3c6',
     armv7l: 'd90750f2218b77a4ddaf02915c8d06ff4f32868273a2709eb2906949c9bea3c6',
       i686: '61e9a1790d99f2f8edcceea2bd10ae8a092166e4da9f648ff1a1083360f9bdda',
     x86_64: '29e8f79fa4e1d93a14373249036428859d7a2e80c319854bb2266f441634a1a6',
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
