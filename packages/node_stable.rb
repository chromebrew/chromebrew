require 'package'

class Node_stable < Package
  version '5.4.1'
  source_url 'https://nodejs.org/dist/v5.5.0/node-v5.5.0.tar.xz'
  source_sha1 '0be3f49f6e5e01e38822f90dd68d4b68ce91c645

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
