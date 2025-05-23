# Adapted from Arch Linux ncurses PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/ncurses/-/blob/main/PKGBUILD

require 'buildsystems/autotools'

class Ncurses < Autotools
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6_5_20250517'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ThomasDickey/ncurses-snapshots.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd746c8432ec7a9a84e7592447825ce2e2e2603a0d1880ac4997f6514f0b9c52d',
     armv7l: 'd746c8432ec7a9a84e7592447825ce2e2e2603a0d1880ac4997f6514f0b9c52d',
       i686: 'dc0a6b3301f836d239cc3d1c44c391dbff2c51849e52a96a38d77ff16481daee',
     x86_64: 'c801d534cbe8b93e91217d0cc9234e5ead2e9488ffaa22329eac8e3441390314'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  autotools_configure_options "--program-prefix='' \
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
          --without-ada \
          --enable-termcap"

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @curseslibs = %w[ncurses ncurses++ form panel menu]
    @curseslibs.each do |lib|
      File.write("#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so", "INPUT(-l#{lib}w)")
      Dir["#{CREW_DEST_LIB_PREFIX}/lib#{lib}*.so.*"].each do |so|
        baselib = File.basename(so)
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/#{baselib}", "#{CREW_DEST_LIB_PREFIX}/#{baselib.gsub('w.so', '.so')}"
      end
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/pkgconfig/#{lib}w.pc", "#{CREW_DEST_LIB_PREFIX}/pkgconfig/#{lib}.pc"
    end
    File.write("#{CREW_DEST_LIB_PREFIX}/libcursesw.so", 'INPUT(-lncursesw)')
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libncursesw.so", "#{CREW_DEST_LIB_PREFIX}/libcurses.so"
    @ticlibs = %w[tic ticinfo tinfo]
    @ticlibs.each do |lib|
      File.write("#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so", 'INPUT(libncursesw.so)')
      Dir["#{CREW_DEST_LIB_PREFIX}/lib#{lib}*.so.*"].each do |so|
        baselib = File.basename(so)
        FileUtils.ln_s "#{CREW_LIB_PREFIX}/#{baselib}", "#{CREW_DEST_LIB_PREFIX}/#{baselib.gsub('w.so', '.so')}" unless File.file?("#{CREW_DEST_LIB_PREFIX}/#{baselib.gsub('w.so', '.so')}")
      end
      Dir["#{CREW_DEST_LIB_PREFIX}/libncursesw.so.*"].each do |so|
        baselibsuffix = File.basename(so).gsub('libncursesw.so', '')
        FileUtils.ln_s "#{CREW_LIB_PREFIX}/libncursesw.so", "#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so" unless File.file?("#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so")
        FileUtils.ln_s "#{CREW_LIB_PREFIX}/libncursesw.so", "#{CREW_DEST_LIB_PREFIX}/lib#{lib}w.so" unless File.file?("#{CREW_DEST_LIB_PREFIX}/lib#{lib}w.so")
        FileUtils.ln_s "#{CREW_LIB_PREFIX}/libncursesw.so", "#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so#{baselibsuffix}" unless File.file?("#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so#{baselibsuffix}")
        FileUtils.ln_s "#{CREW_LIB_PREFIX}/libncursesw.so", "#{CREW_DEST_LIB_PREFIX}/lib#{lib}w.so#{baselibsuffix}" unless File.file?("#{CREW_DEST_LIB_PREFIX}/lib#{lib}w.so#{baselibsuffix}")
      end
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/pkgconfig/ncursesw.pc", "#{CREW_DEST_LIB_PREFIX}/pkgconfig/#{lib}.pc"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/pkgconfig/ncursesw.pc", "#{CREW_DEST_LIB_PREFIX}/pkgconfig/#{lib}w.pc"
    end
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/ncursesw6-config", "#{CREW_DEST_PREFIX}/bin/ncurses6-config"
    FileUtils.ln_sf "#{CREW_PREFIX}/include/ncursesw", "#{CREW_DEST_PREFIX}/include/ncurses"
    # Remove conflicts with dvtm package.
    Dir.chdir "#{CREW_DEST_PREFIX}/share/terminfo/d" do
      FileUtils.rm %w[dvtm dvtm-256color]
    end
  end
end
