require 'package'

class Freetds < Package
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'http://www.freetds.org/'
  version '1.2.9'
  compatibility 'all'
  source_url 'ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.2.9.tar.bz2'
  source_sha256 '90d7c2553d86fcca0029f118a2d61b48d69eed193549c4ff7306c5f8e132c2f5'

  binary_url ({
  })
  binary_sha256 ({
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
