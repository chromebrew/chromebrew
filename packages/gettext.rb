require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://gnu.org/s/gettext/'
  version '1.0'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  # source_url 'https://github.com/autotools-mirror/gettext.git'
  # git_hashtag "v#{version.split('-')[0]}"
  source_url "https://ftpmirror.gnu.org/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'd6342cbe1411a2fe7d139bfed80c2d63b1babc92acfedc72501cc105184f61ee'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '544431c68111b92e5d0276d864ff4f744d6730e3129a3bdd98aba141b16ac9b7',
     armv7l: '544431c68111b92e5d0276d864ff4f744d6730e3129a3bdd98aba141b16ac9b7',
       i686: 'ddf90d4b54d84863b94b63e833d96ed0c9052a2d8a476d98ca46a9ff6f2bc6f8',
     x86_64: '5c6e808ed06953e3e5ffc9defef6323253d4ada901e302900e79cdaed802f440'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openjdk8' => :build
  depends_on 'wget2' => :build

  # --without-git is needed as per https://github.com/autotools-mirror/gettext/blob/master/PACKAGING
  # to make sure $prefix/share/gettext/archive.dir.tar.* is installed.
  autotools_configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --with-xz \
    --without-git \
    --without-included-gettext'
end
