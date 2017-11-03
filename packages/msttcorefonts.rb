require 'package'

class Msttcorefonts < Package
  description "An easy way to install Microsoft's TrueType core fonts on Linux"
  homepage 'http://corefonts.sourceforge.net/'
  version '3.6'
  source_url 'http://http.debian.net/debian/pool/contrib/m/msttcorefonts/msttcorefonts_3.6.tar.gz'
  source_sha256 'c23a2c519acad44fb65dfdd5b6f7de7b351ec15394df52cc744e3c6deb51d42f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cabextract'

  def self.build
    # Since there is no configure script available, some modifications to prevent a 'file not found'
    # message and writes to read-only directories were necessary in the update-ms-fonts script.
    system "sed -i '61icp cabfiles.sha256sums \$SCRATCHDIR/' update-ms-fonts"
    system "sed -i 's,/var/lib/msttcorefonts/,,g' update-ms-fonts"
    system "sed -i 's,/usr/share,#{CREW_DEST_PREFIX}/share,g' update-ms-fonts"
  end

  def self.install
    system "./update-ms-fonts"
  end

  def self.postinstall
    puts
    puts "Fonts are installed in #{CREW_PREFIX}/share/fonts/truetype/msttcorefonts.".lightblue
    puts
  end
end
