require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '8.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://nano-editor.org/dist/v8/nano-8.0.tar.xz'
  source_sha256 'c17f43fc0e37336b33ee50a209c701d5beb808adc2d9f089ca831b40539c9ac4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a5e21ec14fa0151f56d95c341390887b003d4cf7e1ddd5eb4a739e62206e2ab',
     armv7l: '2a5e21ec14fa0151f56d95c341390887b003d4cf7e1ddd5eb4a739e62206e2ab',
       i686: '0a4b528065e6883276502a76a7e7302af72a2067883883d78f927f9cbf7e1a5b',
     x86_64: '45833a83b98bddd0a8831fb9d4a5d6ae90d94d1e0c170d6acd3b57fd4cf55d5e'
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
    ExitMessage.add "\nPersonal configuration file is located in #{HOME}/.nanorc.\n".lightblue
  end
end
