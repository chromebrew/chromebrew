require 'buildsystems/autotools'

class Augeas < Autotools
  description 'Augeas is a configuration editing tool that parses native formats and transforms them into a tree.'
  homepage 'http://augeas.net/'
  version '1.14.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "http://download.augeas.net/augeas-#{version}.tar.gz"
  source_sha256 '321942c9cc32185e2e9cb72d0a70eea106635b50269075aca6714e3ec282cb87'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'deb5ee9ae3d8410b88942f8a0a2845c7a69772bf8a04f10554b07fe4ede8378c',
     armv7l: 'deb5ee9ae3d8410b88942f8a0a2845c7a69772bf8a04f10554b07fe4ede8378c',
       i686: 'd026cbb44eb81de1db2ef5fc5fb7f048e528144e87c9d6371fefce6714221cf5',
     x86_64: '5fdc33f52d54d7a50a3b4b72e8e65232b062b783a160261e9f32234474e02c97'
  })

  depends_on 'gcc_lib' # R
end
