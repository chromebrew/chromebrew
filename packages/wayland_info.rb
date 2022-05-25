require 'package'

class Wayland_info < Package
  description 'wayland-info is a utility for displaying information about the Wayland protocols supported by a Wayland compositor.'
  homepage 'https://gitlab.freedesktop.org/wayland/wayland-utils'
  @_ver = '3fec240801442ae229112d35e070ea71eac06d0b'
  version "1.1-#{@_ver[0...7]}"
  license 'MIT/Expat'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-utils.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_info/1.1-3fec240_armv7l/wayland_info-1.1-3fec240-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_info/1.1-3fec240_armv7l/wayland_info-1.1-3fec240-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_info/1.1-3fec240_i686/wayland_info-1.1-3fec240-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_info/1.1-3fec240_x86_64/wayland_info-1.1-3fec240-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '47fffcb289200ca6fadc3e03a6dc6f38aa411c03baa4c1e38186084a5c9fc0ff',
     armv7l: '47fffcb289200ca6fadc3e03a6dc6f38aa411c03baa4c1e38186084a5c9fc0ff',
       i686: '48af9f71adf12c8916a8c3fec92a17746a55fe126b1c8f9ea06b0b85449773e9',
     x86_64: '460ac914559ad023d4e6f26214bff0773b1e04626312917982d8bba31ecfafff'
  })

  depends_on 'glibc' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
