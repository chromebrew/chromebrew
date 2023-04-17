require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '7.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://nano-editor.org/dist/v7/nano-7.2.tar.xz'
  source_sha256 '86f3442768bd2873cec693f83cdf80b4b444ad3cc14760b74361474fc87a4526'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/7.2_armv7l/nano-7.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/7.2_armv7l/nano-7.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/7.2_i686/nano-7.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nano/7.2_x86_64/nano-7.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8e2fb30ca3fb61a64aae2e93d7320e07feb3b38838e39e3a2b5ffa5462034002',
     armv7l: '8e2fb30ca3fb61a64aae2e93d7320e07feb3b38838e39e3a2b5ffa5462034002',
       i686: '32aee8fa703ffe9b01e53f2ba1c839bef2b7cefdeacf3471475afa27b7d5003d',
     x86_64: 'fddc8a4be84f736f549bf480c84ee8259e4b00e2a88913ca1fe36c404d613a3e'
  })

  depends_on 'filecmd' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "mold -run \
      ./configure #{CREW_OPTIONS} \
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
      --enable-nls \
      --enable-operatingdir \
      --enable-rpath \
      --enable-speller \
      --enable-tabcomp \
      --enable-threads=posix \
      --enable-utf8 \
      --enable-wordcomp \
      --enable-wrapping \
      --enable-year2038"
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
    FileUtils.install 'nanorc', "#{CREW_DEST_HOME}/.nanorc", mode: 0o644
  end

  def self.postinstall
    puts
    puts 'Personal configuration file is located in $HOME/.nanorc'.lightblue
    puts
  end
end
