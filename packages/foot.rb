require 'buildsystems/meson'

class Foot < Meson
  description 'Wayland terminal emulator - fast, lightweight and minimalistic'
  homepage 'https://codeberg.org/dnkl/foot'
  version '1.25.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/dnkl/foot.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd57847d67c11d9a9b50bd124a030526ea9f444d58c654e44deaaf7fa9d3a144',
     armv7l: 'dd57847d67c11d9a9b50bd124a030526ea9f444d58c654e44deaaf7fa9d3a144',
     x86_64: '3b460b562e8c2fd91932f2af4bad13c3029b29faac5af02e0347ca27c330af2b'
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

  # This avoids conflicts with ncurses.
  meson_options '-Dterminfo=disabled'
end
