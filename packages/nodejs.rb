require 'package'

class Nodejs < Package
  version '0.10.36'
  source_url 'http://nodejs.org/dist/v0.10.36/node-v0.10.36.tar.gz'
  source_sha1 '7e89d33ad0e56f6ca517f43a4a7b56079db18420'

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
