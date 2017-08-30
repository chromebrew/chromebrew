require 'package'

class Httpd < Package
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'http://httpd.apache.org/'
  version '2.4.27'
  source_url 'http://www-us.apache.org/dist/httpd/httpd-2.4.27.tar.gz'
  source_sha256 '346dd3d016ae5d7101016e68805150bdce9040a8d246c289aa70e68a7cd86b66'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a1a143e339089ed712e7c5c85eebf7af2d21001e51931a6ce9d4508f27598bb9',
     armv7l: 'a1a143e339089ed712e7c5c85eebf7af2d21001e51931a6ce9d4508f27598bb9',
       i686: '3d462f9c3704fb7b58b5c3e57a0c8307669e26b85103612a132674fc35c3b9c0',
     x86_64: '50a7f5187edb55a4d7ec9f47ad8d6972b3d28bb659bbb2bb96e2804ffe9733ef',
  })

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
