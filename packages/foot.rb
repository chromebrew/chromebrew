require 'buildsystems/meson'

class Foot < Meson
  description 'Wayland terminal emulator - fast, lightweight and minimalistic'
  homepage 'https://codeberg.org/dnkl/foot'
  version '1.26.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/dnkl/foot.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0785522a584e77a166d4c11a71102cfabd7ec0eb88a5c048839b5ab8074186ac',
     armv7l: '0785522a584e77a166d4c11a71102cfabd7ec0eb88a5c048839b5ab8074186ac',
     x86_64: 'd2604346ff47fb4e8b539078e304af15df85803e9935181f9ca957c9bc1c84e5'
  })

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for pre-M92 systems.
    return unless LIBC_VERSION < '2.28'
    downloader 'https://raw.githubusercontent.com/jtsiomb/c11threads/3b0ee4127ff8e8d954d183c9acc06be9e32aecf2/c11threads.h', '9b8a21dc65ed4891eb4c469adaaa94955b365009b6b8d1858bd91378b0157865', 'threads.h'
    FileUtils.cp('threads.h', 'tests')
  end

  depends_on 'fcft'
  depends_on 'fcft' => :executable_only
  depends_on 'fontconfig'
  depends_on 'fontconfig' => :executable_only
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable_only
  depends_on 'harfbuzz' => :executable_only
  depends_on 'libxkbcommon'
  depends_on 'libxkbcommon' => :executable_only
  depends_on 'ncurses'
  depends_on 'pixman'
  depends_on 'pixman' => :executable_only
  depends_on 'tllist' => :build
  depends_on 'utf8proc'
  depends_on 'utf8proc' => :executable_only
  depends_on 'wayland'
  depends_on 'wayland' => :executable_only
  depends_on 'wayland_protocols' => :build

  # This avoids conflicts with ncurses.
  meson_options '-Dterminfo=disabled'
end
