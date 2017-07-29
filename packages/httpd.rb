require 'package'

class Httpd < Package
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'http://httpd.apache.org/'
  version '2.4.27'
  source_url 'https://github.com/apache/httpd/archive/2.4.27.tar.gz'
  source_sha256 '20d6a9258d408077b822d223da7893a905b185fbca518f4399445a68ad971b21'

  depends_on 'subversion'

  def self.build
    system 'svn co https://svn.apache.org/repos/asf/apr/apr/branches/1.5.x srclib/apr'
    system 'svn co https://svn.apache.org/repos/asf/apr/apr-util/branches/1.5.x srclib/apr-util'
    system './buildconf'
    system './configure --with-included-apr'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
