require 'package'

class Scala < Package
  description 'The Scala 3 compiler, also known as Dotty.'
  homepage 'https://scala-lang.org/'
  version '3.3.8'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/scala/scala3.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '564976d1515a5150930d137a91ff82aba0467a9ab54105f957083d57f1e97f65'
  })

  depends_on 'openjdk17' => :logical
  depends_on 'sbt' => :build

  def self.build
    system 'sbt dist/packArchive'
  end

  def self.install
    # Remove Windows batch files.
    FileUtils.rm_f Dir['dist/target/pack/bin/*.bat']
    FileUtils.install Dir['dist/target/pack/bin/*'], "#{CREW_DEST_PREFIX}/share/scala/bin/", mode: 0o755
    FileUtils.install Dir['dist/target/pack/lib/*'], "#{CREW_DEST_PREFIX}/share/scala/lib/", mode: 0o644
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir["#{CREW_DEST_PREFIX}/share/scala/bin/*"].each do |binary|
      bin = File.basename(binary)
      FileUtils.ln_s "#{CREW_PREFIX}/share/scala/bin/#{bin}", "#{CREW_DEST_PREFIX}/bin/#{bin}"
    end
  end

  def self.postinstall
    ExitMessage.add "\nType 'scala -help' to get started.\n"
  end
end
