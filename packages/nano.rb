require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '6.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://nano-editor.org/dist/v6/nano-6.1.tar.xz'
  source_sha256 '3d57ec893fbfded12665b7f0d563d74431fc43abeaccacedea23b66af704db40'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/6.1_armv7l/nano-6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/6.1_armv7l/nano-6.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/6.1_i686/nano-6.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/6.1_x86_64/nano-6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5e1c05739831b22109ff5b342e26b2a6060a4d7eedbf85429071717b0e68dc6e',
     armv7l: '5e1c05739831b22109ff5b342e26b2a6060a4d7eedbf85429071717b0e68dc6e',
       i686: '213937bceb48bdd1e96fcc7e658183ee835ea98218a279748a4479048d5a4a7c',
     x86_64: 'ef01d254db458f10046ad8ca64e90d486242ca737a32736d2656598c998a5c56'
  })

  depends_on 'xdg_base'
  no_env_options

  def self.patch
    system "sed -i '/SIGWINCH/d' src/nano.c"
  end

  def self.build
    system "CFLAGS=-flto=auto LDFLAGS=-static \
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
