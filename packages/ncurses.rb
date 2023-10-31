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
    aarch64: '63fcd6b47db611bdce379882cfcedcba0daadb635bbd8166eab4bccabc76d462',
     armv7l: '63fcd6b47db611bdce379882cfcedcba0daadb635bbd8166eab4bccabc76d462',
       i686: 'a1e0b336f5bc605f087824253d55e889e2775b432c03d7a2dcd56d86038fcbcf',
     x86_64: 'bb2079373688f70f8c3f84f6a1ab6cec311a0ffb755830a20b1e3c2d3732403e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
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
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @curseslibs = %w[ncurses ncurses++ form panel menu]
    @curseslibs.each do |lib|
      File.write("#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so", "INPUT(-l#{lib}w)")
      FileUtils.install "misc/#{lib}w.pc", "#{CREW_LIB_PREFIX}/pkgconfig/#{lib}.pc", mode: 0o644
    end
    File.write("#{CREW_DEST_LIB_PREFIX}/libcursesw.so", 'INPUT(-lncursesw)')
    FileUtils.install 'lib/libncursesw.so', "#{CREW_LIB_PREFIX}/libcurses.so", mode: 0o755
    @ticlibs = %w[tic ticinfo]
    @ticlibs.each do |lib|
      File.write("#{CREW_DEST_LIB_PREFIX}/lib#{lib}.so", 'INPUT(libncursesw.so)')
      FileUtils.install 'lib/libncursesw.so', "#{CREW_LIB_PREFIX}/lib#{lib}.so", mode: 0o755
      FileUtils.install 'misc/ncursesw.pc', "#{CREW_LIB_PREFIX}/pkgconfig/#{lib}.pc", mode: 0o644
    end
    # Remove conflicts with dvtm package.
    Dir.chdir "#{CREW_DEST_PREFIX}/share/terminfo/d" do
      FileUtils.rm %w[dvtm dvtm-256color]
    end
  end
end
