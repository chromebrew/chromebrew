require 'package'

class Py3_urllib3 < Package
  description 'URLlib3 is an HTTP library with thread-safe connection pooling, file post, and more.'
  homepage 'https://urllib3.readthedocs.io/'
  @_ver = '1.26.7'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/urllib3/urllib3.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7-py3.11_armv7l/py3_urllib3-1.26.7-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7-py3.11_armv7l/py3_urllib3-1.26.7-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7-py3.11_i686/py3_urllib3-1.26.7-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7-py3.11_x86_64/py3_urllib3-1.26.7-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1891aef5d72cf74255d5a1f1c2a2bfdd074c7737805b4e49e5b64cef94b0aa38',
     armv7l: '1891aef5d72cf74255d5a1f1c2a2bfdd074c7737805b4e49e5b64cef94b0aa38',
       i686: 'd82141b243d4412371f34c76b46bc6cc8c6ca950551336176071088762b4c8c8',
     x86_64: 'cab19fea342c980f528c8f3f73b9279ec256643d0c20f8a55ddb513f81b2784d'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
