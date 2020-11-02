require 'package'

class Freetds < Package
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'http://www.freetds.org/'
  version '1.2.9'
  compatibility 'all'
  source_url 'ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.2.9.tar.bz2'
  source_sha256 '90d7c2553d86fcca0029f118a2d61b48d69eed193549c4ff7306c5f8e132c2f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetds-1.2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetds-1.2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetds-1.2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetds-1.2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94f48cce54a8548a73f5a387eea6ad90ffcbc6c1f5003d3066a1c7a9f8bdc2b4',
     armv7l: '94f48cce54a8548a73f5a387eea6ad90ffcbc6c1f5003d3066a1c7a9f8bdc2b4',
       i686: 'df276d4a6252b9723a594450d07849371188a136b9a106a1f3924a40b3e504cc',
     x86_64: '5f272856bfc561fd1fd848b1487e41ce69e19d80af72cbec53076442733702b0',
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
