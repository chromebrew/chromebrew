require 'package'

class Kcov < Package
  description 'Kcov is a code coverage tester for compiled programs, Python scripts and shell scripts.'
  homepage 'http://simonkagstrom.github.io/kcov/'
  version 'v36'
  source_url 'https://github.com/SimonKagstrom/kcov/archive/v36.tar.gz'
  source_sha256 '29ccdde3bd44f14e0d7c88d709e1e5ff9b448e735538ae45ee08b73c19a2ea0b'

  depends_on 'curl'
  depends_on 'elfutils'

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
