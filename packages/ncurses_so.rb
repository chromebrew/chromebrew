require 'package'

class Ncurses_so < Package
  version '5.9'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz'
  source_sha1 '3e042e5f2c7223bffdaac9646a533b8c758b65b5'

  depends_on "ncurses"

  def self.build
    system "./configure --prefix=/usr/local \"CFLAGS= -fPIC\" --without-debug --without-normal --with-shared"
    system "make"
  end

  def self.install
    out = "#{CREW_DEST_DIR}/usr/local/lib"
    system "mkdir -p #{out}"
    ["form", "menu", "ncurses", "panel"].each do |lib|
      system "cp", "lib/lib#{lib}.so.5.9", out
      FileUtils.cd(out) do
        system "ln -s lib#{lib}.so.5.9 lib#{lib}.so"
        system "ln -s lib#{lib}.so.5.9 lib#{lib}.so.5"
      end
    end
    FileUtils.cd(out) do
      system "ln -s libncurses.so.5.9 libtinfo.so.5.9"
      system "ln -s libncurses.so.5 libtinfo.so.5"
      system "ln -s libncurses.so libtinfo.so"
    end
  end
end
