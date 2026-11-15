require 'buildsystems/meson'

class Foot < Meson
  description 'Wayland terminal emulator - fast, lightweight and minimalistic'
  homepage 'https://codeberg.org/dnkl/foot'
  version '1.28.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/dnkl/foot.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09f0cdd1c0faad01fe8c4ed1b158a34e0a9fe46e9938503d845185e101d1d3ec',
     armv7l: '09f0cdd1c0faad01fe8c4ed1b158a34e0a9fe46e9938503d845185e101d1d3ec',
     x86_64: '2877cd074ee79685fd46566b46cc3cc5764718ba5c2deebe95662e3e7e67394a'
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
