require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.5.20'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.5.20/kotlin-compiler-1.5.20.zip'
  source_sha256 'edf34263ddaabd48f7ec59661e4c0d1dc868462fd3a1ea323083d0e3e83a8a8b'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kotlin/1.5.20_armv7l/kotlin-1.5.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kotlin/1.5.20_armv7l/kotlin-1.5.20-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kotlin/1.5.20_i686/kotlin-1.5.20-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kotlin/1.5.20_x86_64/kotlin-1.5.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cf3d0cf2e00493f1076f488ab16d3abd3a80248b3eea8aa7ab808a3d3f34cab2',
     armv7l: 'cf3d0cf2e00493f1076f488ab16d3abd3a80248b3eea8aa7ab808a3d3f34cab2',
       i686: 'c0af546acb272c9105111e3a3b7ae43ed8e94b40ac7b89aa51a6d429bb915795',
     x86_64: 'b428ec2c0a697e3ffcbb68a5f6062776938bcb2bdebab5b005637bb8c358678a',
  })

  depends_on 'jdk8'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.rm_f Dir['bin/*.bat']
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/kotlin/bin" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/kotlin/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
    end
  end
end
