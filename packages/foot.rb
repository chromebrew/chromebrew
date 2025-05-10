require 'buildsystems/meson'

class Foot < Meson
  description 'Wayland terminal emulator - fast, lightweight and minimalistic'
  homepage 'https://codeberg.org/dnkl/foot'
  version '1.18.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/dnkl/foot.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d867d515e613a68f40d853474f56a62d68ce57b45c0e5b3541fe7fada81d4a7',
     armv7l: '4d867d515e613a68f40d853474f56a62d68ce57b45c0e5b3541fe7fada81d4a7',
     x86_64: 'b15f9dc468b2119adbfc2d41b34cae84a6cd8db639bface1fda065edbc5f51c4'
  })

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for pre-M92 systems.
    return unless LIBC_VERSION < '2.28'
    downloader 'https://raw.githubusercontent.com/jtsiomb/c11threads/3b0ee4127ff8e8d954d183c9acc06be9e32aecf2/c11threads.h', '9b8a21dc65ed4891eb4c469adaaa94955b365009b6b8d1858bd91378b0157865', 'threads.h'
    FileUtils.cp('threads.h', 'tests')
  end

  depends_on 'fcft'
  depends_on 'fontconfig'
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libxkbcommon'
  depends_on 'ncurses'
  depends_on 'pixman'
  depends_on 'tllist' => :build
  depends_on 'utf8proc'
  depends_on 'wayland'
  depends_on 'wayland_protocols' => :build

  # https://codeberg.org/dnkl/foot/issues/1789
  meson_options '-Dwerror=false'
end
