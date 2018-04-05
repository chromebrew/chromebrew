require 'package'

class Glog < Package
  description 'A C++ implementation of the Google logging module.'
  homepage 'https://github.com/google/glog'
  version '0.3.5'

  source_url 'https://github.com/google/glog/archive/v0.3.5.zip'
  source_sha256 '267103f8a1e9578978aa1dc256001e6529ef593e5aea38193d31c2872ee025e8'

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
