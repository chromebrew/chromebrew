require 'buildsystems/autotools'

class Nano < Autotools
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '9.0'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.nano-editor.org/dist/v#{version.split('.').first}/nano-#{version}.tar.xz"
  source_sha256 '9f384374b496110a25b73ad5a5febb384783c6e3188b37063f677ac908013fde'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b77bd21b3d13314b479c5c3dde79e80adf0f150f829f2a9441cc77a8ad71f7f3',
     armv7l: 'b77bd21b3d13314b479c5c3dde79e80adf0f150f829f2a9441cc77a8ad71f7f3',
       i686: '6fe3e4b93f80ea64babde96c4ba7a3485bd29ceb6e8468e03ec6d005195d6614',
     x86_64: '146bab1540de95d986b4f993d793eb61e7e0b4fc50cac40cc8d13dc2ad4853b6'
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
    %w[aclocal automake].each { |f| FileUtils.ln_sf "#{CREW_PREFIX}/bin/#{f}", "#{CREW_PREFIX}/bin/#{f}-#{am}" } unless am.nil?
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
  end

  autotools_install_extras do
    FileUtils.install 'nanorc', "#{CREW_DEST_HOME}/.nanorc", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nPersonal configuration file is located in #{HOME}/.nanorc.\n".lightblue
  end
end
