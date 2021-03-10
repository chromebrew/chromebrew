require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  @_ver = '1.1.90'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libhandy/-/archive/#{@_ver}/libhandy-#{@_ver}.tar.bz2"
  source_sha256 '6ddac98a287e4e9b31e3ec3d72dae756c4ef6e12f3b1150db7ec2ee339750bde'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.1.90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.1.90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.1.90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.1.90-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '55c875283be39533c6683a967e1857ad844c4e8cdf6d638852118ba8e2b61d16',
     armv7l: '55c875283be39533c6683a967e1857ad844c4e8cdf6d638852118ba8e2b61d16',
       i686: '5cba24d72415faa55c8064c0693ad79051ad88545d9b55b2ad2f5deede171921',
     x86_64: '89e363e201acb5c7040ceb5f4b34d0800996816c3559059b8a8abb0b3d341b38'
  })

  depends_on 'vala'

  def self.prebuild
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
