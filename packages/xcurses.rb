require 'package'

class Xcurses < Package
  description 'A curses library for X11 environments that don\'t fit the termcap/terminfo model.'
  homepage 'https://pdcurses.org/'
  version '3.9'
  license 'Public domain'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/wmcbrine/PDCurses/archive/3.9.tar.gz'
  source_sha256 '590dbe0f5835f66992df096d3602d0271103f90cf8557a5d124f693c2b40d7ec'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c09ec4f427b95042e003527c3381251813ca2f8b75b4c4ded7996b3d0060c4d7',
     armv7l: 'c09ec4f427b95042e003527c3381251813ca2f8b75b4c4ded7996b3d0060c4d7',
     x86_64: '34036322be08da20e27039c83f62b804529f4a7ef5a327242715fca2dce7cfef'
  })

  depends_on 'libx11'
  depends_on 'libxaw'
  depends_on 'libxt'

  def self.patch
    system "sed -i 's,/usr/#{ARCH_LIB},#{CREW_LIB_PREFIX},g' x11/configure"
  end

  def self.build
    Dir.chdir 'x11' do
      system "./configure --prefix=#{CREW_DEST_PREFIX} --libdir=#{CREW_DEST_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'x11' do
      system 'make', 'install'
    end
  end
end
