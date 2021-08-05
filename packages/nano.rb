require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  @_ver = '5.8'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://nano-editor.org/dist/v5/nano-#{@_ver}.tar.xz"
  source_sha256 'e43b63db2f78336e2aa123e8d015dbabc1720a15361714bfd4b1bb4e5e87768c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/5.8_armv7l/nano-5.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/5.8_armv7l/nano-5.8-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/5.8_i686/nano-5.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/5.8_x86_64/nano-5.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '23b77943e240929c4acf71ea4c0f40ef107524b6368bbcc35e8cc5f6bd751ee8',
     armv7l: '23b77943e240929c4acf71ea4c0f40ef107524b6368bbcc35e8cc5f6bd751ee8',
       i686: '0e21d468927c646e377e9aa848032b401eb7a6c160a564d45d4e809a7f20f8c7',
     x86_64: '00651b1b81c2479b9b924325e5308530e49dacaa925f67903893347e8f295628'
  })

  depends_on 'xdg_base'
  depends_on 'filecmd'

  def self.patch
    system "sed -i '/SIGWINCH/d' src/nano.c"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} \
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
