require 'package'

class Uthash < Package
  description 'A hash table for C structures'
  homepage 'https://troydhanson.github.com/uthash/'
  version '2.4.0'
  license 'BSD-1'
  compatibility 'all'
  source_url 'https://github.com/troydhanson/uthash.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1915de04f1ca2f29b2654caa7c26d0ed0af67a8bc09c59ed43f58d73f34dab7f',
     armv7l: '1915de04f1ca2f29b2654caa7c26d0ed0af67a8bc09c59ed43f58d73f34dab7f',
       i686: 'd3818f8687e8b6ec47912e26a9e5c1bab0e5dffa188fe07134b4d9a2d7d0861e',
     x86_64: '28d61632caab2de1ca768a1ed97ed3ad89aa51c6f3cb08a4fedd846bcca96d9c'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/"
    FileUtils.cp_r Dir['./src/*'], "#{CREW_DEST_PREFIX}/include/"
  end

  def self.check
    system 'make -C tests'
  end
end
