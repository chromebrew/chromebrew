require 'package'

class Node_stable < Package
  version '5.4.1'
  source_url 'https://nodejs.org/dist/v5.4.1/node-v5.4.1.tar.gz'
  source_sha1 '8055bb2bf30a44ed5aaf4b07e69709dd09ca3ebf'

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
