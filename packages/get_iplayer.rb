require 'package'

class Get_iplayer < Package
  description 'A utility for downloading TV and radio programmes from BBC iPlayer'
  homepage 'https://github.com/get-iplayer/get_iplayer'
  version '3.01'
  source_url 'https://github.com/get-iplayer/get_iplayer/archive/v3.01.tar.gz'
  source_sha256 '0e1e16f3706efa98893e33b1602cc00bb3d8e22e269bfc5a1a078559e4c21ce6'

  depends_on 'perl'
  depends_on 'ffmpeg'
  depends_on 'atomicparsley'
  depends_on 'libxml2'
  depends_on 'zlibpkg'

  def self.build
    system "wget http://search.cpan.org/CPAN/authors/id/W/WI/WIMV/Math-LP-0.03.tar.gz"
    system "tar xf Math-LP-0.03.tar.gz"
    Dir.chdir "Math-LP-0.03" do
 	    system "perl Makefile.PL"
 	    system "make"
 	    system "make install"
 	    system "make DESTIDR=#{CREW_DEST_DIR} install"
    end
    
    system "cpanm JSON::PP --force"
    system "cpanm LWP --force"
    system "cpanm LWP::Protocol::https --force"
    system "cpanm Mojolicious --force"
    system "cpanm XML::Simple --force"

    system "wget http://search.cpan.org/CPAN/authors/id/S/SH/SHLOMIF/XML-LibXML-2.0129.tar.gz"
    system "tar xf XML-LibXML-2.0129.tar.gz"
    Dir.chdir "XML-LibXML-2.0129" do
 	    system "perl Makefile.PL"
 	    system "make"
 	    system "make install"
 	    system "make DESTIDR=#{CREW_DEST_DIR} install"
    end
    
    system "cpanm CGI --force"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp get_iplayer #{CREW_DEST_DIR}/usr/local/bin/"
  end
end
