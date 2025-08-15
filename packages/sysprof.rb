# Adapted from Arch Linux sysprof PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sysprof/-/blob/main/PKGBUILD?ref_type=heads
require 'buildsystems/meson'

class Sysprof < Meson
  description 'Kernel based performance profiler'
  homepage 'https://apps.gnome.org/Sysprof/'
  version '49.alpha'
  license 'GPL-3.0-or-later'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/sysprof.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f1fbfab13ddbe345aeb6a12edfb82e2f629ab2e33b4dbb0069c8871ea225e72',
     armv7l: '9f1fbfab13ddbe345aeb6a12edfb82e2f629ab2e33b4dbb0069c8871ea225e72',
       i686: 'e78460760fc07db1609433a54ff02bdb46d372beb70f6062960c0f9175c973c2',
     x86_64: '4ba8891fe80c832821d36fe5c2331c446dc1968ef4911bfae19ac8bf2a0ea731'
  })

  depends_on 'json_glib' => :build
  depends_on 'libdex' => :build
  depends_on 'libunwind' => :build
  depends_on 'py3_itstool' => :build

  def self.patch
    file = File.read('meson.build')
    file.gsub!("if need_glib
  subdir('contrib')
endif", "if need_glib or get_option('libsysprof')
  subdir('contrib')
endif")
    File.write('meson.build', file)
  end

  # meson_options '-Dexamples=false -Dgtk=false -Dinstall-static=false -Dlibsysprof=false -Dsysprofd=none -Dtests=false -Dtools=false'
  meson_options '-Dexamples=false -Dgtk=false -Dinstall-static=false -Dsysprofd=none -Dtests=false -Dtools=true -Dpolkit-agent=disabled -Dhelp=false -Ddebuginfod=disabled'
end
