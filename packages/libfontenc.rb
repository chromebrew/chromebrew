require 'package'

class Libfontenc < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.3'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libfontenc-1.1.3.tar.gz'
  source_sha256 '6fba26760ca8d5045f2b52ddf641c12cedc19ee30939c6478162b7db8b6220fb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80f8be4b0ed9e282172ca04b5945dfeca2f64c676afb45d727fce8dc0c1100ca',
     armv7l: '80f8be4b0ed9e282172ca04b5945dfeca2f64c676afb45d727fce8dc0c1100ca',
       i686: '18570f0cbbd7083ff01de80bf13a565f34319f27a93427fcf9dd2f47577c8342',
     x86_64: 'e908f737e72de556d70a7013efeaf6a23bdeb570b159df3907cdc387584b0de2',
  })
  
  depends_on 'xorg_proto'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
