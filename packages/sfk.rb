require 'buildsystems/autotools'

class Sfk < Autotools
  description 'The Swiss File Knife - A Command Line Tools Collection for Windows / Linux / Mac.'
  homepage 'https://swissfileknife.sourceforge.net/'
  version '2.0.0'
  license 'BSD'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/swissfileknife/1-swissfileknife/#{version}.3/sfk-#{version}.tar.gz"
  source_sha256 'b7e2e3848e3126dcee916056bff5f8340acae9158f3610049de2cde999ccca63'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b507ab01f38b79b99e3ef221014ed11e3652929ab2c2abd01b9aef3524bf6204',
     armv7l: 'b507ab01f38b79b99e3ef221014ed11e3652929ab2c2abd01b9aef3524bf6204',
       i686: '3d8d79d85cc3431545c2a9e645e81c6f87c54a5f8324b35723f9d4ca2f1eded0',
     x86_64: '269706e7db78e840c1d40058c5c4e43c204f8dd43d006040a5a8eea07a1593f7'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
