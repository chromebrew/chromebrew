require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  @_ver = '2.0.7'
  version "#{@_ver}-py3.11"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7-py3.11_armv7l/itstool-2.0.7-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7-py3.11_armv7l/itstool-2.0.7-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7-py3.11_i686/itstool-2.0.7-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7-py3.11_x86_64/itstool-2.0.7-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a74762c5e822a1d3697b013e3b358a8e972d4e7bbfab88389526978af01508c8',
     armv7l: 'a74762c5e822a1d3697b013e3b358a8e972d4e7bbfab88389526978af01508c8',
       i686: '32641b3f9f80960295007e090dd45dad83f5aa6d614b716e5024edc433315b32',
     x86_64: 'e6cb13fd65ecfe34f25973142cde21926b825c3b997486992b756c1e6f58fffa'
  })

  depends_on 'py3_libxml2'
  depends_on 'python3' => :build

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
