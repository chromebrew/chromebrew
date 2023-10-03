require 'buildsystems/python'

class Mesonbuild < Python
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.2.2'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.2.1-py3.11_armv7l/meson-1.2.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.2.1-py3.11_armv7l/meson-1.2.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.2.1-py3.11_i686/meson-1.2.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.2.1-py3.11_x86_64/meson-1.2.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd42c13bf8dfba2c95b34d5350216177eb1a21cb56ab51a5bfad3e5b13bb751bb',
     armv7l: 'd42c13bf8dfba2c95b34d5350216177eb1a21cb56ab51a5bfad3e5b13bb751bb',
       i686: '898f835770a66fe5e4d149d6127b485a0cede791d1a21c3440740d73eeadce94',
     x86_64: '2acb417c85ff27772afca5cb306c4b5c55fd2ef3c6e753d55d7f6775ea6944be'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
