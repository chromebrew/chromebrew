require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '8.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://nano-editor.org/dist/v8/nano-#{version}.tar.xz"
  source_sha256 '93b3e3e9155ae389fe9ccf9cb7ab380eac29602835ba3077b22f64d0f0cbe8cb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2486bc2e3e290458805a2c55eaf6649bd0e242ec699bbc424f3aae095b5da44d',
     armv7l: '2486bc2e3e290458805a2c55eaf6649bd0e242ec699bbc424f3aae095b5da44d',
       i686: 'd3acd202efabcd04785d3ad6e982bcaa8a2f372d5b1341818c27fa1412583912',
     x86_64: '7ecab2c4d4815ae73044fdf5c9375aad2c06fbee2fe0dcd56cab86d8435e60d2'
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
