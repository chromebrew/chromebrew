require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  @_ver = '5.6.1'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://nano-editor.org/dist/v5/nano-#{@_ver}.tar.xz"
  source_sha256 '760d7059e0881ca0ee7e2a33b09d999ec456ff7204df86bee58eb6f523ee8b09'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/5.6.1_armv7l/nano-5.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/5.6.1_armv7l/nano-5.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/5.6.1_i686/nano-5.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/5.6.1_x86_64/nano-5.6.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1a421406267c513aed8d65ec02d9b2e796e4ca1dcc044d00e5b1b8a5543796e4',
     armv7l: '1a421406267c513aed8d65ec02d9b2e796e4ca1dcc044d00e5b1b8a5543796e4',
       i686: '0b5f611c9cde46159191a255127761a04c4e1e6c865a41fff8d048ac596ed938',
     x86_64: 'da8530aac92bd6b84dd3b142baa4586db42e5c0880172a55d9fa7383f91fc408'
  })

  depends_on 'xdg_base'

  def self.patch
    system "sed -i '/SIGWINCH/d' src/nano.c"
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
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
  end
end
