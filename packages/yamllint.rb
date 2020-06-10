require 'package'

class Yamllint < Package
  description 'A linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint'
  version '1.11.1'
  compatibility 'all'
  source_url 'https://github.com/adrienverge/yamllint/archive/v1.11.1.tar.gz'
  source_sha256 '56221b7c0a50b1619e491eb157624a5d1b160c1a4f019d64f117268f42fe4ca4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yamllint-1.11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yamllint-1.11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yamllint-1.11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yamllint-1.11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9798d172ec31c7b2c6b739dfd1177084c80aeb9ad15d129e3a84caed558bde54',
     armv7l: '9798d172ec31c7b2c6b739dfd1177084c80aeb9ad15d129e3a84caed558bde54',
       i686: '5cf8682e924268a750cd34433bb2a99698d8c31460c25495be924210617ba40f',
     x86_64: 'fa88bcfa61c580b18e421518bd1f2078dcd2f8fc050e6c564643fdf46c074191',
  })

  def self.build
    system 'python3 setup.py sdist'
  end

  def self.install
    system "pip3 install dist/yamllint-*.tar.gz --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
