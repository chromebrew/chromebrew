require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.0.8'
  source_url 'ftp://download.osgeo.org/libtiff/tiff-4.0.8.tar.gz'
  source_sha256 '59d7a5a8ccd92059913f246877db95a2918e6c04fb9d43fd74e5c3390dac2910'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '31be0b4de2160e9ecadf5ea1b0abe3547380a2fab1abd918a0149393829b3900',
     armv7l: '31be0b4de2160e9ecadf5ea1b0abe3547380a2fab1abd918a0149393829b3900',
       i686: '9d1e022d65dfa8bc85b8c0376c324e60d9f3333d321808a983851126954a597a',
     x86_64: '21e39ccbc1958bcc91f6ebd6c3866dc9d73ad884c780d9e124a6d2065a7d480b',
  })

  def self.build
    system "./configure CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
