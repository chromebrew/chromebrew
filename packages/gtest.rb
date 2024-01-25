require 'package'

class Gtest < Package
  description 'Google Test - C++ testing utility'
  homepage 'https://opensource.google/projects/googletest'
  version '1.11.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/google/googletest.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '523a783df726759242ab363f4174ef27b3db4b2794b85398b2d5f97dd3c136a3',
     armv7l: '523a783df726759242ab363f4174ef27b3db4b2794b85398b2d5f97dd3c136a3',
       i686: '67f2af894a33460bf36d2c4e913384e1afcaaa95256225abf80b6e271b9630c2',
     x86_64: '79392e23282200e8d37d47738832b0e05d916f6c51b5af01b332b9887bc476a5'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env #{CREW_ENV_OPTIONS} \
        cmake -G Ninja #{CREW_CMAKE_OPTIONS} -DBUILD_SHARED_LIBS=ON .."
      system 'samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
