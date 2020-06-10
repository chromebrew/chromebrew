require 'package'

class Libglade < Package
  description 'Libglade is a library that performs a similar job to the C source output routines in the GLADE user interface builder.'
  homepage 'http://www.jamesh.id.au/software/libglade/'
  version '2.6.4'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libglade/2.6/libglade-2.6.4.tar.bz2'
  source_sha256 '64361e7647839d36ed8336d992fd210d3e8139882269bed47dc4674980165dec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libglade-2.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libglade-2.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libglade-2.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libglade-2.6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f211b42969c6d791e8d61f13aad15251e3991c0270c251810eda6c5fbdb550e',
     armv7l: '9f211b42969c6d791e8d61f13aad15251e3991c0270c251810eda6c5fbdb550e',
       i686: '13920b24507ee60dc5f4c8501dd89305a05797b030afe25af6d3771595b83e56',
     x86_64: '2749ac0d67edb91b1f59355fba8dd045c8dbc44ede3fc619304853b2ac4799cf',
  })

  depends_on 'gtk2'
  depends_on 'gtk3'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    #system 'make', 'check'
  end
end
