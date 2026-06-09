require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.4.4'
  license 'GPL-3'
  compatibility 'all'
  # source_url 'https://github.com/RsyncProject/rsync'
  # git_hashtag "v#{version}"
  source_url "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"
  source_sha256 'bd88cf82fa653da32314fb229136407c5c90f80d1758d8f4b091767877d8fa96'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93853f1a3c76455644656c624949b62a8be460ab5c94b039790cbca15fbb4b57',
     armv7l: '93853f1a3c76455644656c624949b62a8be460ab5c94b039790cbca15fbb4b57',
       i686: '5ecb9355614806b7042f6ceb2c0e880998296476af5dda40c81b1723ff36671a',
     x86_64: 'ad2557558ea34207a04a2df32fcb2fbbcf26a0f84395fa8bebfaa346ec56b848'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'lz4' => :executable
  depends_on 'openssl' => :executable
  depends_on 'popt' => :executable
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--disable-openat2'
end
