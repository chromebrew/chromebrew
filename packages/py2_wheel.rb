require 'package'

class Py2_wheel < Package
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version '0.36.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag version
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '0d3fefe56883596140bec955b6098f4f486a29f74167e914949c560653ac12a3',
     armv7l: '0d3fefe56883596140bec955b6098f4f486a29f74167e914949c560653ac12a3',
       i686: '43f51e7a624afa1a0bdf9f023d1079b3627ae3cbd792ce2bde9b3c526dd2c301',
     x86_64: '214daa1cb230f9fb1ba3f0ae6e4005813c9a01749ee7b2beef4aa34fec790ff1'
  })

  depends_on 'python2'
  depends_on 'py2_setuptools' => :build

  def self.build
    system "python2 setup.py build #{PY2_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"

    # Remove conflicting executables
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/wheel"
  end
end
