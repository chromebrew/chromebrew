require 'package'

class Httpd < Package
  version '2.2.32'
  source_url 'https://github.com/apache/httpd/archive/2.2.32.tar.gz'
  source_sha1 '647e459f645c4138561e3f4314570f2f525d754d'

  depends_on 'svn'

  def self.build
    system 'svn co http://svn.apache.org/repos/asf/apr/apr/branches/1.4.x srclib/apr'
    system 'svn co http://svn.apache.org/repos/asf/apr/apr-util/branches/1.4.x srclib/apr-util'
    system './buildconf'
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system 'make -i install'
  end
end
