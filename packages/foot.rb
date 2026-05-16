require 'buildsystems/meson'

class Foot < Meson
  description 'Wayland terminal emulator - fast, lightweight and minimalistic'
  homepage 'https://codeberg.org/dnkl/foot'
  version '1.27.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/dnkl/foot.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26d52ca46e8b7fc8bdef35dd901845c282ef56ca2811af145269f05b510575a0',
     armv7l: '26d52ca46e8b7fc8bdef35dd901845c282ef56ca2811af145269f05b510575a0',
     x86_64: 'ffff4b5d38e55802afbeed2241d8f0d01a86a3419abbb7d2fdf1110d81b7ee1c'
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
  depends_on 'glibc_lib' => :executable
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
