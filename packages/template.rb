require 'package'

class Template < Package
  description ''
  homepage ''
  version ''
  source_url '*.tar.gz'
  source_sha256 ''

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/*-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/*-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/*-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/*-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
       i686: '',
     x86_64: '',
  })


  # Register dependencies (use the following line as a basis)
  #
  # depends_on '*'
  #

  # Define here behavior to build the package from source
  def self.build
  end

  # Define here the behavior to install the package from binary
  def self.install
  end

end
