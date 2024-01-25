require 'package'

class Libtinfo < Package
  description 'Missing ncurses library reference.'
  homepage 'https://www.gnu.org/software/ncurses/'
  @_ver = 5.9
  version "#{@_ver}-1"
  license 'MIT' # Ncurses license
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4cd214446b4d34eb7c00166986e746c8cc84b123d8cb3bbff61d486384c746f2',
     armv7l: '4cd214446b4d34eb7c00166986e746c8cc84b123d8cb3bbff61d486384c746f2',
       i686: '1391890981de5c9b70cc86e8ac3e0b87076ea6cdf7a73c89e3b5aa3c8500a67d',
     x86_64: '9527bba23a9c551e0865996aeedf0d13a87572b8049125cbff24bf2d137e5e23'
  })

  def self.build
    # Fix ncurses error: expected ')' before 'int'.
    # See https://lists.gnu.org/archive/html/bug-ncurses/2015-01/msg00016.html.
    ENV['CPPFLAGS'] = '-P'
    # build libncurses
    Dir.mkdir 'ncurses_build'
    Dir.chdir 'ncurses_build' do
      # system "#{CREW_ENV_OPTIONS} ../configure #{CREW_OPTIONS} \
      system "../configure #{CREW_OPTIONS} \
          --program-prefix='' \
          --program-suffix='' \
          --with-shared \
          --with-cxx-shared \
          --without-debug \
          --without-normal \
          --without-cxx-binding \
          --disable-widec \
          --without-tests \
          --with-termlib \
          --enable-termcap"
      system 'make'
    end
    # build libncursesw
    Dir.mkdir 'ncursesw_build'
    Dir.chdir 'ncursesw_build' do
      # system "#{CREW_ENV_OPTIONS} ../configure #{CREW_OPTIONS} \
      system "../configure #{CREW_OPTIONS} \
          --program-prefix='' \
          --program-suffix='' \
          --with-shared \
          --with-cxx-shared \
          --without-debug \
          --without-normal \
          --without-cxx-binding \
          --enable-widec \
          --without-tests \
          --with-termlib \
          --enable-termcap"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'ncurses_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install.libs'
    end
    Dir.chdir 'ncursesw_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install.libs'
    end
    # Save only the libtinfo libraries.
    FileUtils.rm_rf CREW_DEST_PREFIX
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mv Dir['ncurses_build/lib/libtinfo.so.5*'], CREW_DEST_LIB_PREFIX
    FileUtils.mv Dir['ncursesw_build/lib/libtinfow.so.5*'], CREW_DEST_LIB_PREFIX
  end
end
