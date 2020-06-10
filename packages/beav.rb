require 'package'

class Beav < Package
  description 'BEAV (Binary Editor And Viewer), is a full featured binary file editor.'
  homepage 'https://packages.debian.org/sid/beav'
  version '1.40-18-b3'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/beav-1.40-18-b3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/beav-1.40-18-b3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/beav-1.40-18-b3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/beav-1.40-18-b3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '61938e9152aa32344551454cc276a46241a83ed1e3332b401b0e950e59963f31',
     armv7l: '61938e9152aa32344551454cc276a46241a83ed1e3332b401b0e950e59963f31',
       i686: '703c90a7dcc8a88d731b3d0133b97110c77b96fb05a972bac71774cfac34cdef',
     x86_64: 'f9f3068e5ac536949578aab4e5009e08cb81e1a0da31a2f51fd65eb37761bf62',
  })

  depends_on 'alien' => :build
  depends_on 'libtinfo'

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'armhf'
      sha256 = '98c941bb1b9dc682f582dd1d3986115558d45fc3ff65d5dd4c20c0e0d2dedebd'
    when 'i686'
      arch = 'i386'
      sha256 = '6dd2197b1011470c3e2f13f2b8a8d96d7a01887b84bce53b75b72345a162fd83'
    when 'x86_64'
      arch = 'amd64'
      sha256 = '93b59b1c494048af7fcb01fd6cd058346ff491d36dab1537b7545eb4b5d35a85'
    end
    package = "beav_#{version}_#{arch}.deb"
    system "wget http://ftp.debian.org/debian/pool/main/b/beav/#{package}"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(package) ) == sha256
    system "alien -tc #{package}"
    system "tar xvf beav-1.40.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
