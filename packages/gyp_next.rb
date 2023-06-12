require 'package'

class Gyp_next < Package
  description 'GYP is a fork of the GYP build system for use in the Node.js projects.'
  homepage 'https://github.com/nodejs/gyp-next/'
  version '0.10.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gyp_next/0.10.0_armv7l/gyp_next-0.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gyp_next/0.10.0_armv7l/gyp_next-0.10.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gyp_next/0.10.0_i686/gyp_next-0.10.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gyp_next/0.10.0_x86_64/gyp_next-0.10.0-chromeos-x86_64.tpxz'
  })
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
