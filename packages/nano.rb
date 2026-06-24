require 'buildsystems/autotools'

class Nano < Autotools
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '9.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.nano-editor.org/dist/v#{version.split('.').first}/nano-#{version}.tar.xz"
  source_sha256 '5f47764274cb7532349ce0aa20ec10f1e8e851a6e9fa3eb66812c43d196db042'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '530f1c10941d636d7cc1e121a411186bfcb440dfe98c89cd1a469ec349a6af61',
     armv7l: '530f1c10941d636d7cc1e121a411186bfcb440dfe98c89cd1a469ec349a6af61',
       i686: '816d0643a4f8b037c1fcc5f8c18295c0c06a8ee382ac6319c224df5440b74d7a',
     x86_64: 'ac1cf955b37fc1b1a235589e27a859d2aa45e2cff43e7ae38bb71a868c5e61e1'
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
