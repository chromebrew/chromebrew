require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  version '1.12.6'
  license 'EPL-1.0, Apache-2.0 and BSD'
  compatibility 'all'
  source_url 'https://github.com/clojure/clojure.git'
  git_hashtag "clojure-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c2e37a64531caca0843100445f4b645121c7f48faffca610d15abdcaca8018ef',
     armv7l: 'c2e37a64531caca0843100445f4b645121c7f48faffca610d15abdcaca8018ef',
       i686: '540f49371358d71abc23dc1f345493cf1064fbc6b91a1b88b7afa9039ba2f3a8',
     x86_64: 'ae86daac4a6da4ef82814abaffa727628649ff44c248c981f3bf9b66a12b1111'
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
