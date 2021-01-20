require 'package'

class Get_iplayer < Package
  description 'A utility for downloading TV and radio programmes from BBC iPlayer'
  homepage 'https://github.com/get-iplayer/get_iplayer'
  version '3.01'
  compatibility 'all'
  source_url 'https://github.com/get-iplayer/get_iplayer/archive/v3.01.tar.gz'
  source_sha256 '0e1e16f3706efa98893e33b1602cc00bb3d8e22e269bfc5a1a078559e4c21ce6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/get_iplayer-3.01-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/get_iplayer-3.01-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/get_iplayer-3.01-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/get_iplayer-3.01-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'acc8ccea3930ac219c7547df326fa5cee0a228c30fef885916229c09d2c050ba',
     armv7l: 'acc8ccea3930ac219c7547df326fa5cee0a228c30fef885916229c09d2c050ba',
       i686: '3a50f3a4e6564407ef95e88d41618567420fe18bf7b49a60690c1e36c4323478',
     x86_64: '04383b2db0fd7dd810d01a3145c240cad3e66a8fd8bcbe2c3c60c622262ec42d',
  })

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
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp get_iplayer #{CREW_DEST_PREFIX}/bin/"
  end
end
