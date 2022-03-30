require 'package'

class Fragments < Package
  description 'Fragments is an easy to use BitTorrent client for the GNOME desktop environment.'
  homepage 'https://gitlab.gnome.org/World/Fragments'
  @_ver = '2.0.2'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/World/Fragments.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fragments/2.0.2_armv7l/fragments-2.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fragments/2.0.2_armv7l/fragments-2.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fragments/2.0.2_i686/fragments-2.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fragments/2.0.2_x86_64/fragments-2.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6a9fd858eee3dd2190d6e868c4c7cc1aa497dcb315b60d01f656b560724c6d17',
     armv7l: '6a9fd858eee3dd2190d6e868c4c7cc1aa497dcb315b60d01f656b560724c6d17',
       i686: '39fcf8e8829285e6cb631d9f665a367e6e387214742ed48d5952447da1a22060',
     x86_64: 'a58de807bee72c7fbb4bd015d4222412162fa82283beb7064c9f2778ea384e8b'
  })

  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gtk4'
  depends_on 'pango'
  depends_on 'libadwaita'
  depends_on 'rust' => :build
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'samu -C builddir || samu -C builddir || samu -C builddir' # Known bug where transmission-client crate fails to build the first time and succeeds the second or third.
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test || true'
  end
end
