require 'package'

class Libtinfo < Package
  description 'Missing ncurses library reference.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-1'
  license 'MIT' # Ncurses license
  compatibility 'all'
  source_url 'SKIP'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.install
    # See https://forums.opensuse.org/showthread.php/446927-missing-library-libtinfo-so-5.
    # See also http://www.linuxforums.org/forum/installation/6251-libtinfo-so-5-a.html.
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libncurses.so.6", "#{CREW_DEST_LIB_PREFIX}/libtinfo.so.5"
  end
end
