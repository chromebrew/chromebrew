require 'buildsystems/autotools'

class Sed < Autotools
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.9'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.9.tar.xz'
  source_sha256 '6e226b732e1cd739464ad6862bd1a1aba42d7982922da7a53519631d24975181'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '132c549c208cb26f1770797b997163003d7d29d1cd234c6351647df201958e96',
     armv7l: '132c549c208cb26f1770797b997163003d7d29d1cd234c6351647df201958e96',
       i686: '02cae930c6dcfa33bab8e6f1a748c8c40be0ca14dcf66ebd59bb5f1dac89454d',
     x86_64: 'a63c523c7433712c49f82ecddb83dccebf35e2ba6c5784fea7e5ec394e2b520a'
  })

  depends_on 'acl' # R
  depends_on 'glibc' # R

  configure_options '--without-selinux'
end
