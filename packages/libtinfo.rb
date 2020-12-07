require 'package'

class Libtinfo < Package
  description 'Missing ncurses library reference.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '0.22-1'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/karthas/files/release/0.22/libtinfo.so.5/download?use_mirror=deac-riga&download=&failedmirror=kumisystems.dl.sourceforge.net#'
  source_sha256 'e503d6c9fd549bbcac64645d3e4491401f906bd7f10d36bc32390e058066a520'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.install
    # See https://forums.opensuse.org/showthread.php/446927-missing-library-libtinfo-so-5.
    # See also http://www.linuxforums.org/forum/installation/6251-libtinfo-so-5-a.html.
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libncurses.so.6 #{CREW_DEST_LIB_PREFIX}/libtinfo.so.5"
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libncurses.so.6 #{CREW_DEST_LIB_PREFIX}/libtinfo.so.6"
  end
end
