require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.1.61'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.1.61/kotlin-compiler-1.1.61.zip'
  source_sha256 '46103d3f65c4016cb62ff8b77ee3e072ff930e69edf69444d723bb22b12a0d83'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kotlin-1.1.61-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kotlin-1.1.61-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kotlin-1.1.61-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kotlin-1.1.61-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '88e4445c28ea847187e48e917768072d35fe8f7456d58c405200c34c53dac262',
     armv7l: '88e4445c28ea847187e48e917768072d35fe8f7456d58c405200c34c53dac262',
       i686: '0003d375998c1e190a4911fe7cf9380b07f3e1437841215fbeb86ddef02f3a5c',
     x86_64: '59fb9ec98d2f8a17f9772bf00efe0727ed75b9b0ce255a6c41bc50135f9c9682',
  })

  depends_on 'jdk8'
  depends_on 'unzip' => :build

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/kotlin"
    system "rm -f bin/*.bat"
    system "cp -r . #{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/kotlin/bin") do
      system "find . -exec ln -s #{CREW_PREFIX}/share/kotlin/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
    end
  end
end
