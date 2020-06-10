require 'package'

class Glog < Package
  description 'A C++ implementation of the Google logging module.'
  homepage 'https://github.com/google/glog'
  version '0.3.5'
  compatibility 'all'
  source_url 'https://github.com/google/glog/archive/v0.3.5.zip'
  source_sha256 '267103f8a1e9578978aa1dc256001e6529ef593e5aea38193d31c2872ee025e8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glog-0.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glog-0.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glog-0.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glog-0.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bd0c7e649bb6e1128e44c8989ab4182f60665e50e5d992341d8bf19235a6dd2e',
     armv7l: 'bd0c7e649bb6e1128e44c8989ab4182f60665e50e5d992341d8bf19235a6dd2e',
       i686: '0ae1c98ddcbf078e0a7c63e38d8f1c993f2b1d80956b1e208490ad62f687a917',
     x86_64: '978c0906643f11a9c53c1a523a5d6824e948edb9ebb89cbfa24395486f435f87',
  })

  depends_on 'unzip' => :build

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make",
           "DESTDIR=#{CREW_DEST_DIR}",
           "install"
  end
end
