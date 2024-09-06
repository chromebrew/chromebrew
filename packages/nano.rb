require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '8.2'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://nano-editor.org/dist/v8/nano-#{version}.tar.xz"
  source_sha256 'd5ad07dd862facae03051c54c6535e54c7ed7407318783fcad1ad2d7076fffeb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43d613cbea676bfdf6f93f228e0b918c2d95c57d01a6d980480ec52110bd7248',
     armv7l: '43d613cbea676bfdf6f93f228e0b918c2d95c57d01a6d980480ec52110bd7248',
       i686: '85e0c367128b8cd99ecadcb7418138e70fe900346ba728e37fc3a55672cbd972',
     x86_64: 'c0bdd0b69656ec2e8cc7dc613d3a05e6e9d026124b22c143c3240f4328056350'
  })

  depends_on 'filecmd' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'zlib' # R

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
    ExitMessage.add "\nPersonal configuration file is located in #{HOME}/.nanorc.\n".lightblue
  end
end
