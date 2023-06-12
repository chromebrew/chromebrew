require 'package'

class Libdeflate < Package
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  version '1.17'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ebiggers/libdeflate.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdeflate/1.17_armv7l/libdeflate-1.17-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdeflate/1.17_armv7l/libdeflate-1.17-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdeflate/1.17_i686/libdeflate-1.17-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdeflate/1.17_x86_64/libdeflate-1.17-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '498cd8b738c0017ed135db145d769f0caabf21af9865c906f968108c20163094',
     armv7l: '498cd8b738c0017ed135db145d769f0caabf21af9865c906f968108c20163094',
       i686: '4eccb78ac8e66cb31024d24271303bfa78c00147f34ebfdae0785e837e433938',
     x86_64: '3a413cb2834ceb7fa84de3b0925409ce8ab742bf8333ab1a17fe6fe7d2a52ae8'
  })

  depends_on 'glibc' # R

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
         .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
