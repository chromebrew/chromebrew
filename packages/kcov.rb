require 'package'

class Kcov < Package
  description 'Kcov is a code coverage tester for compiled programs, Python scripts and shell scripts.'
  homepage 'http://simonkagstrom.github.io/kcov/'
  version 'v36'
  compatibility 'all'
  source_url 'https://github.com/SimonKagstrom/kcov/archive/v36.tar.gz'
  source_sha256 '29ccdde3bd44f14e0d7c88d709e1e5ff9b448e735538ae45ee08b73c19a2ea0b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kcov-v36-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kcov-v36-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kcov-v36-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kcov-v36-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f1ccc1d5d85941c1bb00fa93cafcf50546621c6063aa87f66b017e218fb2734f',
     armv7l: 'f1ccc1d5d85941c1bb00fa93cafcf50546621c6063aa87f66b017e218fb2734f',
       i686: 'a9a0be31864db5aacc0d9771e60a453972423d33689b8381cea41c6caa26d5f1',
     x86_64: '35ccebb9cda52beb4cf13977483fcb4ebc6011fe0c1e52ce9be2cefb5fbd300a',
  })

  depends_on 'curl'
  depends_on 'elfutils'
  depends_on 'six'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

end
