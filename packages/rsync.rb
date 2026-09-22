require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.5.1'
  license 'GPL-3'
  compatibility 'all'
  # source_url 'https://github.com/RsyncProject/rsync'
  # git_hashtag "v#{version}"
  source_url "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"
  source_sha256 'c55f9c9dc10fb8bec397b399a0fdded53cc9a2d8e30891bb0d63724d25c37bef'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d6e6984f97160849b24bf6ee825207e113b6782ecb350c91191d06de46667bf',
     armv7l: '6d6e6984f97160849b24bf6ee825207e113b6782ecb350c91191d06de46667bf',
       i686: '43ce01b77ece5c0db90376cc06236138598697704216d68638a18432f012b478',
     x86_64: '0e9713d410c52f1c12a29a204303f03a04eba8148b4c3aab2ae8638a4463ec34'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libiconv' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'lz4' => :executable
  depends_on 'openssl' => :executable
  depends_on 'popt' => :executable
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--disable-openat2'
end
