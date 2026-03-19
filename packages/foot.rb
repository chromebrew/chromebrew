require 'buildsystems/meson'

class Foot < Meson
  description 'Wayland terminal emulator - fast, lightweight and minimalistic'
  homepage 'https://codeberg.org/dnkl/foot'
  version '1.26.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/dnkl/foot.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2884de51d076dfc42d4087470fd14939fde6ea03988f2dfbd903190dc627ff1',
     armv7l: 'b2884de51d076dfc42d4087470fd14939fde6ea03988f2dfbd903190dc627ff1',
     x86_64: '315b809f64d38ef42cc2a01add728c3914eb7a52f1927f2fe29a4095a3944374'
  })

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for pre-M92 systems.
    return unless LIBC_VERSION < '2.28'
    downloader 'https://raw.githubusercontent.com/jtsiomb/c11threads/3b0ee4127ff8e8d954d183c9acc06be9e32aecf2/c11threads.h', '9b8a21dc65ed4891eb4c469adaaa94955b365009b6b8d1858bd91378b0157865', 'threads.h'
    FileUtils.cp('threads.h', 'tests')
  end

  depends_on 'fcft' => :executable
  depends_on 'fontconfig' => :executable
  depends_on 'glibc' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libxkbcommon' => :executable
  depends_on 'pixman' => :executable
  depends_on 'tllist' => :build
  depends_on 'utf8proc' => :executable
  depends_on 'wayland' => :executable
  depends_on 'wayland_protocols' => :build

  # This avoids conflicts with ncurses.
  meson_options '-Dterminfo=disabled'
end
