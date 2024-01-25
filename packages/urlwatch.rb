require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  @_ver = '2.23'
  version "#{@_ver}-2"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/thp/urlwatch.git'
  git_hashtag @_ver
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '0bfe1f433e06852c427d3bb6d7fe160e1340d3841d99848c15783ff8d685ad3a',
     armv7l: '0bfe1f433e06852c427d3bb6d7fe160e1340d3841d99848c15783ff8d685ad3a',
       i686: '5d6ef968a353e561aa9d8a1bd3d29e7bfe1acd826c2698c691452ee6117132f6',
     x86_64: '9a08612a54f577049a3ee4af398d023a46e23a40587ed0361810c2fda0873d4b'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_cssselect'
  depends_on 'py3_minidb'
  depends_on 'py3_pyyaml'
  depends_on 'py3_requests'
  depends_on 'py3_appdirs'
  depends_on 'py3_keyring'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
