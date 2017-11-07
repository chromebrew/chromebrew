require 'package'

class Htop < Package
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://hisham.hm/htop/'
  version '2.0.2-1'
  source_url 'http://hisham.hm/htop/releases/2.0.2/htop-2.0.2.tar.gz'
  source_sha256 '179be9dccb80cee0c5e1a1f58c8f72ce7b2328ede30fb71dcdf336539be2f487'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'buildessential'  => :build
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --disable-unicode"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
