require 'package'

class Iojs < Package
  version '2.3.4'
  source_url 'https://iojs.org/dist/v2.3.4/iojs-v2.3.4.tar.gz'
  source_sha1 '97639c34ebb951a4655ce8b903fa38a3f0135396'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    # These are needed for iojs to install
    system "sudo ln -sf /usr/local/bin/gcc /usr/local/bin/cc"

    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
