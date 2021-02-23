require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '5.5'
  compatibility 'all'
  source_url 'https://www.nano-editor.org/dist/v5/nano-5.5.tar.xz'
  source_sha256 '390b81bf9b41ff736db997aede4d1f60b4453fbd75a519a4ddb645f6fd687e4a'

  depends_on 'xdg_base'

  def self.patch
    system "sed -i '/SIGWINCH/d' src/nano.c"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-threads=posix \
            --enable-nls \
            --enable-rpath \
            --enable-browser \
            --enable-color \
            --enable-comment \
            --enable-extra \
            --enable-help \
            --enable-histories \
            --enable-justify \
            --enable-libmagic \
            --enable-linenumbers \
            --enable-mouse \
            --enable-multibuffer \
            --enable-nanorc \
            --enable-operatingdir \
            --enable-speller \
            --enable-tabcomp \
            --enable-wordcomp \
            --enable-wrapping \
            --enable-utf8"
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
