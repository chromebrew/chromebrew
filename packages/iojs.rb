require 'package'

class Iojs < Package
  version '2.1.0'
  source_url 'https://iojs.org/dist/v2.1.0/iojs-v2.1.0.tar.gz'
  source_sha1 '3236518f6e16334d0ed4c40b075625a0bb04086d'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    # These are needed for iojs to install
    system "sudo ln -s /usr/local/bin/gcc /usr/local/bin/cc"

    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
