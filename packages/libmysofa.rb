require 'package'

class Libmysofa < Package
  description 'libmysofa is a reader for AES SOFA files to get better HRTFs.'
  homepage 'https://github.com/hoene/libmysofa/'
  version '1.2.1'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://github.com/hoene/libmysofa.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '1eafd9c9f7644c142f409027768195c9dcfaa20c0f78058e3f9ee87f04ba4ff5',
      armv7l: '1eafd9c9f7644c142f409027768195c9dcfaa20c0f78058e3f9ee87f04ba4ff5',
        i686: '8cacc806698f6e19d28d044f7352a286232f8016941905ef7b3d5133e3a13bbb',
      x86_64: '4732529c1ad40072a727d76b6e485777d0a007fa19722f3f5440376cfd59f5ef'
  })

  depends_on 'cunit'

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
