require 'package'

class Httpd < Package
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'http://httpd.apache.org/'
  version '2.4.27'
  source_url 'http://www-us.apache.org/dist/httpd/httpd-2.4.27.tar.gz'
  source_sha256 '346dd3d016ae5d7101016e68805150bdce9040a8d246c289aa70e68a7cd86b66'

  depends_on 'apr'
  depends_on 'aprutil'
  depends_on 'libtool'
  depends_on 'pcre'
  depends_on 'expat'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
