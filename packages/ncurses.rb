# Adapted from Arch Linux ncurses PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/ncurses/-/blob/main/PKGBUILD

require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6_4_20231028'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ThomasDickey/ncurses-snapshots.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6_4_20231028_armv7l/ncurses-6_4_20231028-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6_4_20231028_armv7l/ncurses-6_4_20231028-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6_4_20231028_i686/ncurses-6_4_20231028-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6_4_20231028_x86_64/ncurses-6_4_20231028-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '56e665459d09ab3cb87d301d81e6d3f3909fc5e3b4b2963bae513cc25bcdd2f4',
     armv7l: '56e665459d09ab3cb87d301d81e6d3f3909fc5e3b4b2963bae513cc25bcdd2f4',
       i686: 'de430fd09e0b7567f9a45524dd9b461cce4d92f9916047501278b9c1be4b79ba',
     x86_64: '943d53afd17826534d2447c7a52c1dd8a1b30afcfbe3613a7689a5775d457b39'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    unless File.file?('Makefile')
      system "./configure #{CREW_OPTIONS} \
          --program-prefix='' \
          --program-suffix='' \
          --disable-root-access \
          --disable-root-environ \
          --disable-setuid-environ \
          --with-shared \
          --with-cxx-binding \
          --with-cxx-shared \
          --with-manpage-format=normal \
          --without-debug \
          --enable-pc-files \
          --with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig \
          --enable-widec \
          --without-tests \
          --with-termlib \
          --without-ada \
          --enable-termcap"
    end
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @curseslibs = %w[ncurses ncurses++ form panel menu]
    @curseslibs.each do |lib|
      File.write("#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so", "INPUT(-l#{lib}w)")
      Dir["#{CREW_DEST_LIB_PREFIX}/lib#{lib}*.so.*"].each do |so|
        baselib = File.basename(so)
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/#{baselib}", "#{CREW_DEST_LIB_PREFIX}/#{baselib.gsub('w.so', '.so')}"
      end
      FileUtils.install "misc/#{lib}w.pc", "#{CREW_DEST_LIB_PREFIX}/pkgconfig/#{lib}.pc", mode: 0o644
    end
    File.write("#{CREW_DEST_LIB_PREFIX}/libcursesw.so", 'INPUT(-lncursesw)')
    FileUtils.install 'lib/libncursesw.so', "#{CREW_DEST_LIB_PREFIX}/libcurses.so", mode: 0o755
    @ticlibs = %w[tic ticinfo tinfo]
    @ticlibs.each do |lib|
      File.write("#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so", 'INPUT(libncursesw.so)')
      Dir["#{CREW_DEST_LIB_PREFIX}/lib#{lib}*.so.*"].each do |so|
        baselib = File.basename(so)
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/#{baselib}", "#{CREW_DEST_LIB_PREFIX}/#{baselib.gsub('w.so', '.so')}"
      end
      FileUtils.install 'lib/libncursesw.so', "#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so", mode: 0o755
      FileUtils.install 'misc/ncursesw.pc', "#{CREW_DEST_LIB_PREFIX}/pkgconfig/#{lib}.pc", mode: 0o644
    end
    # Remove conflicts with dvtm package.
    Dir.chdir "#{CREW_DEST_PREFIX}/share/terminfo/d" do
      FileUtils.rm %w[dvtm dvtm-256color]
    end
  end
end
