require 'package'

class Btop < Package
  description 'Resource monitor that shows usage and stats for processor, memory, disks, network and processes.'
  homepage 'https://github.com/aristocratos/btop'
  version '1.2.13'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aristocratos/btop.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17be864bd2d5ce7c2c7975452d8baefc8b7fcef0adf833227b17e13d46cebb4b',
     armv7l: '17be864bd2d5ce7c2c7975452d8baefc8b7fcef0adf833227b17e13d46cebb4b',
       i686: '49cede8a4d3b2f1d0091dac06aa0cb8527890764e17dcccef2c3fa8e17535dca',
     x86_64: 'c7ee94ef41ce100eb4c9b247a97dfeb008b5f176dc5641614b49c0322029aa56'
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
