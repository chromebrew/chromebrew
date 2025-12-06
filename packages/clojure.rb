require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  version '1.12.3'
  license 'EPL-1.0, Apache-2.0 and BSD'
  compatibility 'all'
  source_url 'https://github.com/clojure/clojure.git'
  git_hashtag "clojure-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61a2dfde905c8391bff2ba62d56413eeab2c49f2de9a2e5b49cad93f82ec0b5d',
     armv7l: '61a2dfde905c8391bff2ba62d56413eeab2c49f2de9a2e5b49cad93f82ec0b5d',
       i686: '01f2d78d11a0835add56ac659ad07fb8614f6bc5dd903b2190778e11a8e89b66',
     x86_64: 'e6e0181831e240eb3ff7b3414c3a87d20852cd222b2df7d982914983f8e0a1c6'
  })

  depends_on 'ant' => :build
  depends_on 'maven' => :build
  depends_on 'openjdk17' # R
  depends_on 'rlwrap' # R

  def self.build
    ENV['JAVA_HOME'] = CREW_PREFIX
    File.write 'clojure.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/clojure/clojure.jar "$@"
    EOF
    system './antsetup.sh'
    system 'ant local'
  end

  def self.install
    FileUtils.install 'clojure.sh', "#{CREW_DEST_PREFIX}/bin/clojure", mode: 0o755
    FileUtils.install 'clojure.jar', "#{CREW_DEST_PREFIX}/share/clojure/clojure.jar", mode: 0o644
  end
end
