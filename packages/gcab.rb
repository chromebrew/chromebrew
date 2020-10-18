require 'package'

class Gcab < Package
  description 'A GObject library to create cabinet files'
  homepage 'https://gitlab.gnome.org/GNOME/gcab'
  version '1.4'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gcab/-/archive/v1.4/gcab-v1.4.tar.bz2'
  source_sha256 '597dd7d0ddee9065412abf0ee15ae73e913daf967f43af5dd55ea9b87b514188'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcab-1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcab-1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcab-1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcab-1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '38438135d7527691a77a8c8016ad4afb13bebc6245663b87e8b0dd6beb41174d',
     armv7l: '38438135d7527691a77a8c8016ad4afb13bebc6245663b87e8b0dd6beb41174d',
       i686: '39f92f811a45cc0947c35dd7510eb00647bfd1cd6425b59c6483f84d2d6d4886',
     x86_64: '69ad98764b36a8745ae765aa683df6d91aca5e42f1e313db5ae2dc72bdf94ce7',
  })

  depends_on 'gobject_introspection'

  def self.prebuild
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} -Ddocs=false -Dvapi=false _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
