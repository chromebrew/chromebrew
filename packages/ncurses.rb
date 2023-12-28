# Adapted from Arch Linux ncurses PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/ncurses/-/blob/main/PKGBUILD

require 'buildsystems/autotools'

class Ncurses < Autotools
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6_4_20231125'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ThomasDickey/ncurses-snapshots.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6_4_20231125_armv7l/ncurses-6_4_20231125-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6_4_20231125_armv7l/ncurses-6_4_20231125-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6_4_20231125_i686/ncurses-6_4_20231125-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6_4_20231125_x86_64/ncurses-6_4_20231125-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1677cddcbd0b682d045a493f80d68764aeb49c0351a50041b8fe3dd31868a07e',
     armv7l: '1677cddcbd0b682d045a493f80d68764aeb49c0351a50041b8fe3dd31868a07e',
       i686: 'c6d045c1f86918db6a2612dea383c9a95c955ce7a8129edeaa9872132c6af519',
     x86_64: '4c1470e9c3b4cb0dcdef0a40c76226a3d97850a4189da810b30aaf6c1cc04e46'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  configure_options "--program-prefix='' \
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
