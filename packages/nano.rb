require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  @_ver = '5.6'
  version @_ver
  compatibility 'all'
  source_url "https://nano-editor.org/dist/v5/nano-#{@_ver}.tar.xz"
  source_sha256 'fce183e4a7034d07d219c79aa2f579005d1fd49f156db6e50f53543a87637a32'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-5.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-5.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-5.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-5.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '591c7d34de17429fe24e2c72b298c23791e6e87da58f914359d8152ec70b00ab',
     armv7l: '591c7d34de17429fe24e2c72b298c23791e6e87da58f914359d8152ec70b00ab',
       i686: '42c85d4a27d9c99a85661385dbbaacc95e09e7ab7878ca7665e17c7527582695',
     x86_64: 'cb60149f951bd3cbff70a5d097c6d422591cc48dabe40552e59404f48b4cc866'
  })

  depends_on 'xdg_base'

  def self.patch
    system "sed -i '/SIGWINCH/d' src/nano.c"
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
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
    open('nanorc', 'w') do |f|
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
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
    system "install -Dm644 nanorc #{CREW_DEST_HOME}/.nanorc"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.local/share"
    FileUtils.ln_sf("#{CREW_PREFIX}/share/nano", "#{CREW_DEST_HOME}/.local/share/")
  end

  def self.postinstall
    puts
    puts 'Personal configuration file is located in $HOME/.nanorc'.lightblue
    puts
    puts 'To make nano your default editor, execute the following:'.lightblue
    puts
    puts "echo 'EDITOR=#{CREW_PREFIX}/bin/nano' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
