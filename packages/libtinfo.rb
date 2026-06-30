require 'package'

class Libtinfo < Package
  description 'Missing ncurses library reference.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.6'
  license 'MIT' # Ncurses license
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/ncurses/ncurses-#{version}.tar.gz"
  source_sha256 '355b4cbbed880b0381a04c46617b7656e362585d52e9cf84a67e2009b749ff11'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e2c0b2caea812593a51bb84b85aeeaee086fd13683c283a24929801bff8f27e',
     armv7l: '2e2c0b2caea812593a51bb84b85aeeaee086fd13683c283a24929801bff8f27e',
       i686: '2e27aef81975804ffae62b2703d1ee1da1b5333739ae6d50548c07d90aedfb1e',
     x86_64: '4d448cd26184abfcf7288da1529ebb517000ea9f4bcfee9c18613d32b02ea356'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  conflicts_ok # Has the same files as in ncurses.

  def self.build
    # build libncurses
    Dir.mkdir 'ncurses_build'
    Dir.chdir 'ncurses_build' do
      system "../configure #{CREW_CONFIGURE_OPTIONS} \
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
      system "../configure #{CREW_CONFIGURE_OPTIONS} \
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
    FileUtils.mv Dir["ncurses_build/lib/libtinfo.so.#{version.split('.').first}*"], CREW_DEST_LIB_PREFIX
    FileUtils.mv Dir["ncursesw_build/lib/libtinfow.so.#{version.split('.').first}*"], CREW_DEST_LIB_PREFIX
  end
end
