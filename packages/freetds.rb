require 'package'

class Freetds < Package
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.4'
  license 'GPL-2'
  compatibility 'all'
  source_url "ftp://ftp.freetds.org/pub/freetds/stable/freetds-#{version}.tar.gz"
  source_sha256 '16b688b3f16325bc69851c03b9c97f2f686a94c7e44f6c758ea188dea3b9ab1f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20ba20e796d3c67b2b21c4dfdcbad9e78dc70b131655cdcb6dde29e01c43a640',
     armv7l: '20ba20e796d3c67b2b21c4dfdcbad9e78dc70b131655cdcb6dde29e01c43a640',
       i686: 'c39b1e837d2f69810685dd063612a28f41bcebed55fd2876a665d14e9e177a78',
     x86_64: '051340765617e6e14c6ea55fac96ba8fdbedf6e3fda80ca8de302d54b69db643'
  })

  depends_on 'glibc' # R

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "Edit the #{CREW_PREFIX}/etc/freetds.conf file to add servers.".lightblue
    puts
    puts "Test the connection with #{CREW_PREFIX}/bin/tsql.".lightblue
    puts
  end
end
