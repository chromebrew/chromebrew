require 'package'

class Node < Package
  version '4.3.0'
  source_url 'https://nodejs.org/dist/v4.3.0/node-v4.3.0.tar.xz'
  source_sha1 'd7b4e9676e63fc3dd1d506cef244874466264e22'

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
