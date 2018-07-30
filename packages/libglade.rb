require 'package'

class Libglade < Package
  description 'Libglade is a library that performs a similar job to the C source output routines in the GLADE user interface builder.'
  homepage 'http://www.jamesh.id.au/software/libglade/'
  version '2.6.4'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libglade/2.6/libglade-2.6.4.tar.bz2'
  source_sha256 '64361e7647839d36ed8336d992fd210d3e8139882269bed47dc4674980165dec'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

  def self.build
    system 'pip3 install six'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
    system 'pip3 uninstall --yes six'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
