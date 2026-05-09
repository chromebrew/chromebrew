require 'buildsystems/autotools'

class Dosfstools < Autotools
  description 'dosfstools consists of the programs mkfs.fat, fsck.fat and fatlabel to create, check and label file systems of the FAT family.'
  homepage 'https://github.com/dosfstools/dosfstools'
  version '4.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dosfstools/dosfstools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bccc3d266c65d5fda76a4694a49afe9a580633ae911d1af23c52f1d6ef69220b',
     armv7l: 'bccc3d266c65d5fda76a4694a49afe9a580633ae911d1af23c52f1d6ef69220b',
       i686: '72d1784288c75e9cdafa4b56e31bd9c02b33fc4a17ea922200a5fa676979e1cb',
     x86_64: 'f63c26700393920c65db0cd4dc9d5d071c444472fb99ae84b16759714db40e53'
  })

  depends_on 'glibc' => :executable

  autotools_configure_options '--enable-compat-symlinks'
end
