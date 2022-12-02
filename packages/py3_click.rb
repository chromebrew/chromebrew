require 'package'

class Py3_click < Package
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  @_ver = '8.0.3'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/click.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.0.3-py3.11_armv7l/py3_click-8.0.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.0.3-py3.11_armv7l/py3_click-8.0.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.0.3-py3.11_i686/py3_click-8.0.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.0.3-py3.11_x86_64/py3_click-8.0.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6135233d39f8258ac64e39e3c271365005995e09607c7f280bfd439a9e79c711',
     armv7l: '6135233d39f8258ac64e39e3c271365005995e09607c7f280bfd439a9e79c711',
       i686: '5c104e6ebff35e8d8650e9a04a823bc28773fe22c29e3cd2606f7eb459b67074',
     x86_64: 'af275727cbea5c79880ef59c9c80dbcd9972fa9437bff7103a24cde7b86b393d'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
