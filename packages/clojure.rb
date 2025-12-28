require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  version '1.12.4'
  license 'EPL-1.0, Apache-2.0 and BSD'
  compatibility 'all'
  source_url 'https://github.com/clojure/clojure.git'
  git_hashtag "clojure-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7332fa47344f098834ece70893f628bfdcfcbfbbe46a05b2dfa74e086ea16f88',
     armv7l: '7332fa47344f098834ece70893f628bfdcfcbfbbe46a05b2dfa74e086ea16f88',
       i686: 'a1d5cf74cf77505f9df67d9fa7e7e38ae7c4bd195697e82d11e2aa286721c207',
     x86_64: 'd7f573b1bb41662bda5fa512dafc1586ed3786f31073ba507fbc84929958abbc'
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
