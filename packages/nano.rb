require 'buildsystems/autotools'

class Nano < Autotools
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '8.7.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.nano-editor.org/dist/v8/nano-#{version}.tar.xz"
  source_sha256 '76f0dcb248f2e2f1251d4ecd20fd30fb400a360a3a37c6c340e0a52c2d1cdedf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40dca9f30cf0d4ab22d5ed171343101f07cc0f9b23892c7b2d947455c6360dd6',
     armv7l: '40dca9f30cf0d4ab22d5ed171343101f07cc0f9b23892c7b2d947455c6360dd6',
       i686: '01efa2e719bd038a4fa8b346ff9fedda840d635940fb246574412beb14d51384',
     x86_64: '2e6b2cfff04f9e91b782dce8ea4a4295664f097aab8934908da3d668f7aa9dfb'
  })

  depends_on 'filecmd' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'zlib' # R

  autotools_configure_options '--enable-browser \
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
      --enable-threads=posix \
      --enable-utf8 \
      --enable-wordcomp \
      --enable-wrapping \
      --enable-year2038'

  autotools_build_extras do
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

  def self.prebuild
    am = `grep "\\[am__api_version=" aclocal.m4`.chomp.split('=')[1].gsub("'", '')
    unless am.nil?
      %w[aclocal automake].each { |f| FileUtils.ln_sf "#{CREW_PREFIX}/bin/#{f}", "#{CREW_PREFIX}/bin/#{f}-#{am}" }
    end
  end

  autotools_install_extras do
    FileUtils.install 'nanorc', "#{CREW_DEST_HOME}/.nanorc", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nPersonal configuration file is located in #{HOME}/.nanorc.\n".lightblue
  end
end
