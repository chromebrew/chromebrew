require 'buildsystems/autotools'

class Nano < Autotools
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '9.3'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.nano-editor.org/dist/v#{version.split('.').first}/nano-#{version}.tar.xz"
  source_sha256 'a9affc52c9596ee0682bcdd4ceb3c0b235eb221d83d733dfd9b0dff45897cb0d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5fe4302456c2954cb67de20a7d901c975f4017ea5b22fa656b86956329d7f44',
     armv7l: 'c5fe4302456c2954cb67de20a7d901c975f4017ea5b22fa656b86956329d7f44',
       i686: '360f73d7a805d3a845383a0975e6ec5d6307bfa4cdfcc35f40cd4154f3625699',
     x86_64: '33fd5a2bc3b92af300e37ce0d8f2abadcc202816c3b3c70bbd823ad7c898c6c4'
  })

  depends_on 'filecmd' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'zlib' => :executable

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
