require 'package'

class Nodejs < Package
  version '0.12.0'
  source_url 'http://nodejs.org/dist/v0.12.0/node-v0.12.0.tar.gz'
  source_sha1 'a969f17a0a6c9238584f8946d96e8d39be8eb957'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    # These are needed for node to install
    system "sudo ln -s /usr/local/bin/gcc /usr/local/bin/cc"

    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
