require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  @_ver = '0.58.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/mesonbuild/meson/archive/#{@_ver}.tar.gz"
  source_sha256 '78e0f553dd3bc632d5f96ab943b1bbccb599c2c84ff27c5fb7f7fff9c8a3f6b4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.1_armv7l/meson-0.58.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.1_armv7l/meson-0.58.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.1_i686/meson-0.58.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.1_x86_64/meson-0.58.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd2a6cacfd9e258918fe0627e117faf27be537c2d7340f0d6ff663e59f0800a3f',
     armv7l: 'd2a6cacfd9e258918fe0627e117faf27be537c2d7340f0d6ff663e59f0800a3f',
       i686: '81211605d926df2868241b31726224bfe41f816faa7095a123e9c78dea680a7a',
     x86_64: 'abe7dfe244c45c3daa4d91938a199c997d81d063a53125117ce218c4a4677aaf'
  })

  depends_on 'ninja'
  depends_on 'samurai'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
