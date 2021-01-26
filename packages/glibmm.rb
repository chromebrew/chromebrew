require 'package'

class Glibmm < Package
  description 'C++ bindings for GLib'
  homepage 'https://www.gtkmm.org'
  version '2.64.5'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/glibmm/2.64/glibmm-2.64.5.tar.xz'
  source_sha256 '508fc86e2c9141198aa16c225b16fd6b911917c0d3817602652844d0973ea386'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.64.5-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.64.5-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.64.5-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.64.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '08d942541e0df0a351f6d748051cc7deb18c4aa21c7950d9b166780ad86f2327',
      armv7l: '08d942541e0df0a351f6d748051cc7deb18c4aa21c7950d9b166780ad86f2327',
        i686: 'f0be0860b956388e55cc8d6d5cfb67f6ff547e653a06570ea0aa72e0e7121913',
      x86_64: '2f050d4abd5cda7efa15e8df5dedc713bc18eb60141982c6b322b21d742ea233',
  })

  depends_on 'libsigcplusplus'
  depends_on 'mm_common' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Dbuild-documentation=false \
    -Dbuild-demos=false \
    -Dbuild-tests=false \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
