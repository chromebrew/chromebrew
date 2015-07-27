require 'package'

class Nodejs < Package
  version '0.12.0'
  source_url 'http://nodejs.org/dist/v0.12.0/node-v0.12.0.tar.gz'
  source_sha1 'd08810034d170c19759cb38bfc9442ab6b0ebc7a'

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
