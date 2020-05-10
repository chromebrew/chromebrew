require 'package'

class Freetds < Package
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'http://www.freetds.org/'
  version '1.00.109'
  compatibility 'all'
  source_url 'ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.109.tar.bz2'
  source_sha256 '3e93b2bcdddc7246147398b9bc3b989c6e7ffed54acbce18f4f34b745c8f0034'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetds-1.00.109-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetds-1.00.109-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetds-1.00.109-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetds-1.00.109-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e2ee2213f781c3f36180e01cf9c5123fdab8d3528172ceb25b19b53a84210248',
     armv7l: 'e2ee2213f781c3f36180e01cf9c5123fdab8d3528172ceb25b19b53a84210248',
       i686: '34473f6c9cf9512da0de7017a7522d43a60f6ea8a78672269166a85e55dc3353',
     x86_64: 'cda228331626e14d559eb680d7a157d1545e24d60f3b5db49d1fbb54180206bd',
  })

  depends_on 'unixodbc'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "Edit the #{CREW_PREFIX}/etc/freetds.conf file to add servers.".lightblue
    puts
    puts "Test the connection with #{CREW_PREFIX}/bin/tsql.".lightblue
    puts
  end
end
