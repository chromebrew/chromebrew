require 'buildsystems/autotools'

class Cryptsetup < Autotools
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.8.6'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/utils/cryptsetup/v#{version.sub(/\.\d+$/, '')}/cryptsetup-#{version}.tar.xz"
  source_sha256 '8004265fd993885d08f7b633dbe056851de1a210307613a4ebddc743fccefe5a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f41f0851a056c8ec2e48a15da9d388163e41f40326934a32a3597fdb5bbc946a',
     armv7l: 'f41f0851a056c8ec2e48a15da9d388163e41f40326934a32a3597fdb5bbc946a',
       i686: '7ed753be31eedd86c2527136305dbc0e651010573d37cb64f3789c9d602c2355',
     x86_64: 'c54367b164056afc9cc065d4a0affeb62c7774cb68058a86309ce6f0176e690f'
  })

  depends_on 'glibc' => :library
  depends_on 'json_c' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libssh' => :library
  depends_on 'lvm2' => :library
  depends_on 'openssl' => :library
  depends_on 'popt' => :executable
  depends_on 'util_linux' => :library

  autotools_configure_options '--disable-asciidoc'
end
