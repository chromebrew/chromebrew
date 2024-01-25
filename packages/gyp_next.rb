require 'package'

class Gyp_next < Package
  description 'GYP is a fork of the GYP build system for use in the Node.js projects.'
  homepage 'https://github.com/nodejs/gyp-next/'
  version '0.10.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '4718cbdf9622ca6ad9e6015cd7f7415113d76162ffbb602ee44ecc53c804ea84',
     armv7l: '4718cbdf9622ca6ad9e6015cd7f7415113d76162ffbb602ee44ecc53c804ea84',
       i686: 'd0a603478fed55166f0516a4f8a4d688717556c198963ef066109650c646a13a',
     x86_64: 'a7c4e1a5c46b7d72fc35023a04110cb4cd76709b0ba8fcabb2af8a10362830a1'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
