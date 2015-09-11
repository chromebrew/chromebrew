require 'package'

class Iojs < Package
  version '3.3.0'
  source_url 'https://iojs.org/dist/v3.3.0/iojs-v3.3.0.tar.gz'
  source_sha1 '17c199be74fdcd3f44b70386fb903dc7fbd7402a'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    system "CC='gcc' python2.7 ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
