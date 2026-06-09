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
    aarch64: '2e1652281b3489309385aede912c5bbd4299bf22f6b06b72200c32c9881cb208',
     armv7l: '2e1652281b3489309385aede912c5bbd4299bf22f6b06b72200c32c9881cb208',
       i686: 'e7707617af4f593a3cc8e369b1a29fd7cc5b87b40853c2fb086fdbe7c5cbd13e',
     x86_64: '0efdd728cf3befef029e23f853435a988c7f4333c21ed86246520ba760263665'
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
