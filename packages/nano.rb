require 'buildsystems/autotools'

class Nano < Autotools
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '8.4'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://nano-editor.org/dist/v8/nano-#{version}.tar.xz"
  source_sha256 '551b717b2e28f7e90f749323686a1b5bbbd84cfa1390604d854a3ca3778f111e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05f552ef37e31db78a85fa7fa67e5f1163798baed534f5ea18eb49b1dd7e3225',
     armv7l: '05f552ef37e31db78a85fa7fa67e5f1163798baed534f5ea18eb49b1dd7e3225',
       i686: 'e8de44caf4f82ddf66b8b54e547c542ea16b9b36f11d81458f0dd3882f9f4601',
     x86_64: '4335734d6c70c77a1844e2a5f5e3b02e739560d67368bd620c79eb1115b5b341'
  })

  depends_on 'filecmd' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'zlib' # R

  configure_options '--enable-browser \
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
      --enable-year2038'

  configure_build_extras do
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

  configure_install_extras do
    FileUtils.install 'nanorc', "#{CREW_DEST_HOME}/.nanorc", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nPersonal configuration file is located in #{HOME}/.nanorc.\n".lightblue
  end
end
