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
    aarch64: '3835d468d96412d0641f317c15856269d01a2cc9bc92704d014e418f2de35dc7',
     armv7l: '3835d468d96412d0641f317c15856269d01a2cc9bc92704d014e418f2de35dc7',
       i686: 'eec49654265f5e37a95f7f252f8b8dc73b40834935e6f212de30d1cdab63ce6d',
     x86_64: 'ec3b1a804dd73c7177e649712cf3932ffadc993d92f191db47ec1e67a1ac7284'
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
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/ncursesw6-config", "#{CREW_DEST_PREFIX}/bin/ncurses6-config"
    FileUtils.ln_sf "#{CREW_PREFIX}/include/ncursesw", "#{CREW_DEST_PREFIX}/include/ncurses"
    # Remove conflicts with dvtm package.
    Dir.chdir "#{CREW_DEST_PREFIX}/share/terminfo/d" do
      FileUtils.rm %w[dvtm dvtm-256color]
    end
  end
end
