require 'package'

class Libtinfo < Package
  description 'Missing ncurses library reference.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-1'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

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
