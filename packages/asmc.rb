require 'package'

class Asmc < Package
  description 'Asmc Macro Assembler'
  homepage 'https://github.com/nidud/asmc'
  license 'GPL-2.0'
  version '2.39'
  compatibility 'all'
  source_url 'https://github.com/nidud/asmc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e4e66ec418d389c19ce28c740d083e41d16ee3f7bea90d31b89b964758f75614',
     armv7l: 'e4e66ec418d389c19ce28c740d083e41d16ee3f7bea90d31b89b964758f75614',
       i686: 'f9ab49087ea87467a9b30b8c49dedf049d44798dd1480bbb7b980f5028bb6ee8',
     x86_64: '344903c084b24ea8df7a58428bd5ba580d5cde9fa216a40a8a598371fbb0dcfc'
  })

  def self.build
    system 'make', chdir: 'source/asmc'
  end

  def self.install
    FileUtils.install "bin/asmc#{CREW_LIB_SUFFIX}", "#{CREW_DEST_PREFIX}/bin/asmc", mode: 0o755
  end
end
