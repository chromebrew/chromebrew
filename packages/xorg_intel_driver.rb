require 'package'

class Xorg_intel_driver < Package
  description 'The Xorg Intel Driver package contains the X.Org Video Driver for Intel integrated video chips including 8xx, 9xx, Gxx, Qxx, HD, Iris, and Iris Pro graphics processors.'
  homepage 'https://01.org/linuxgraphics/'
  version '3.7.8'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/endlessm/xf86-video-intel/archive/Release_3.7.8.tar.gz'
    source_sha256 '411d644cba1a46e9fd8143a969edc70a67ae18f15bba333f24ed8b87716f93fe'
    depends_on 'xorg_server' => :build
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_intel_driver-3.7.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '5bd9bdf5b812ee93a39809cd3ba7e05cd71251280d8049ac07deee29249f3fde',
  })

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static',
           '--enable-kms-only',
           '--enable-uxa'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
