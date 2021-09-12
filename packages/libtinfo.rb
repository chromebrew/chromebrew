require 'package'

class Libtinfo < Package
  description 'Missing ncurses library reference.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '5.9'
  license 'MIT' # Ncurses license
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses.git'
  git_hashtag "v#{version}"

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtinfo/5.9_armv7l/libtinfo-5.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtinfo/5.9_armv7l/libtinfo-5.9-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtinfo/5.9_i686/libtinfo-5.9-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtinfo/5.9_x86_64/libtinfo-5.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2e94b9a42682306f5c05eae9a9b28fb797a79b7f782ed4e291c66224fb2a09b4',
     armv7l: '2e94b9a42682306f5c05eae9a9b28fb797a79b7f782ed4e291c66224fb2a09b4',
       i686: 'c884149bf8c6dea3fc3d16ba1ac316c811d318fbfa18ef35171e2bf2c81f4bd9',
     x86_64: '6ff14ec1bdcdbf55e145b4a8c450b09526803c1450fb3a06fc233a9e85e4ea3e',
  })

  def self.build
    # Fix ncurses error: expected ')' before 'int'.
    # See https://lists.gnu.org/archive/html/bug-ncurses/2015-01/msg00016.html.
    ENV['CPPFLAGS'] = '-P'
    # build libncurses
    Dir.mkdir 'ncurses_build'
    Dir.chdir 'ncurses_build' do
      #system "#{CREW_ENV_OPTIONS} ../configure #{CREW_OPTIONS} \
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
      #system "#{CREW_ENV_OPTIONS} ../configure #{CREW_OPTIONS} \
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
    FileUtils.mv Dir["ncurses_build/#{ARCH_LIB}/libtinfo.so.5*"], CREW_DEST_DIR
    FileUtils.mv Dir["ncursesw_build/#{ARCH_LIB}/libtinfow.so.5*"], CREW_DEST_DIR
    FileUtils.rm_rf CREW_DEST_PREFIX
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mv Dir["#{CREW_DEST_DIR}/libtinfo*.so.5*"], CREW_DEST_LIB_PREFIX
  end
end
