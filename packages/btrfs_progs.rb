require 'buildsystems/autotools'

class Btrfs_progs < Autotools
  description 'BTRFS is a modern copy on write filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration.'
  homepage 'https://btrfs.readthedocs.io/en/latest/'
  version '6.9'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/kdave/btrfs-progs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b82e35f3745ec1d31ae24c99d9a1abd46830c576106280810cc0035ed23b181b',
     armv7l: 'b82e35f3745ec1d31ae24c99d9a1abd46830c576106280810cc0035ed23b181b',
       i686: 'bc6641ab32514d25078506a97456ab0556fb0b109f2874e138940cab57cc14b4',
     x86_64: '5de03dcbd63e8741b54552cb2568766e7884eec1838cf4d52d2bf527bf5db790'
  })

  depends_on 'e2fsprogs'
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgcrypt' # R
  depends_on 'lzo' # R
  depends_on 'util_linux' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options '--disable-documentation \
    --disable-convert \
    --with-crypto=libgcrypt \
    --with-convert=ext2'
end
