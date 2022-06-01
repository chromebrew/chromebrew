require 'package'

class Grive < Package
  description 'Google Drive client with support for new Drive REST API and partial sync'
  homepage 'https://github.com/vitalif/grive2'
  version '0.5.2-e6fcc63'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vitalif/grive2.git'
  git_hashtag 'e6fcc637f8d51126312f12d0c0a568046c4f95de'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.2-e6fcc63_armv7l/grive-0.5.2-e6fcc63-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.2-e6fcc63_armv7l/grive-0.5.2-e6fcc63-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.2-e6fcc63_i686/grive-0.5.2-e6fcc63-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.2-e6fcc63_x86_64/grive-0.5.2-e6fcc63-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2a2c5dae9efd74c5b0497813c895f5bac5c91df8b1b7a9a31ac196ccaf09dd13',
     armv7l: '2a2c5dae9efd74c5b0497813c895f5bac5c91df8b1b7a9a31ac196ccaf09dd13',
       i686: '35301f6fe1a3d097341c1ef9b881b2f5dab461b3fd24c5859ddacb4a79b69b0a',
     x86_64: '6aecea77e9fd0150ac18f2df6444b12cc95e411897800d462d89a1a5f6c8aeae',
  })

  depends_on 'yajl'
  depends_on 'libcurl'
  depends_on 'libgcrypt'
  depends_on 'boost'
  depends_on 'expat'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake #{CREW_CMAKE_OPTIONS} .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
