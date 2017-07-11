require 'package'

class Perl_www_curl < Package
  description 'Perl binding for libcurl'
  homepage 'https://github.com/szbalint/WWW--Curl'
  version '4.17'
  source_url 'https://github.com/szbalint/WWW--Curl/archive/4.17.tar.gz'
  source_sha256 'd3bcaa4a49435bd33663a64eaeca9bcac46ee735de6b6e8bc3e539dbf977f664'

  depends_on 'perl'
  depends_on 'curl'
  depends_on 'patch' => :build

  def self.build
    system "wget -O Makefile.patch http://cpan.cpantesters.org/authors/id/S/SR/SREZIC/patches/WWW-Curl-4.17-RT117793.patch"
    system "patch Makefile.PL Makefile.patch"
    system "perl Makefile.PL"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  
  def self.check
    system "make test"
  end
end