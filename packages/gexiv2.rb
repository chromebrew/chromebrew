require 'package'

class Gexiv2 < Package
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  version '0.10.8'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gexiv2/0.10/gexiv2-0.10.8.tar.xz'
  source_sha256 '81c528fd1e5e03577acd80fb77798223945f043fd1d4e06920c71202eea90801'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gexiv2-0.10.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gexiv2-0.10.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gexiv2-0.10.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gexiv2-0.10.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '237da7c428e80aabb82fe529cc54d51912656c43356096b43e24e44a5a8784d2',
     armv7l: '237da7c428e80aabb82fe529cc54d51912656c43356096b43e24e44a5a8784d2',
       i686: '4f74a753cfc4286e93d65f96e046661957f5b0bfef54732b20a8793f514d1fb8',
     x86_64: 'bda3197ee000806a1151f44587eb422b0afedc3b8b6b28c9def8ca490ff8db6a',
  })

  depends_on 'libexiv2'
  depends_on 'gobject_introspection'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--with-python2-girdir',
           '--with-python3-girdir'
    system 'make'
  end

  def self.check
#    system "make check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
