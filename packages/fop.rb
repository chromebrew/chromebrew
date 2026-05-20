require 'package'

class Fop < Package
  description 'Apache FOP (Formatting Objects Processor) is a print formatter driven by XSL formatting objects (XSL-FO) and an output independent formatter.'
  homepage 'https://xmlgraphics.apache.org/fop/'
  version '2.11'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.apache.org/xmlgraphics/fop/binaries/fop-#{version}-bin.tar.gz"
  source_sha256 'b7e12dc8c96ce0087742757debad3798fa6f8778f8b8ed7acfbf6e405e4ede76'

  depends_on 'openjdk8' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/fop #{CREW_DEST_PREFIX}/etc/env.d/]
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/fop"
    FileUtils.ln_s "#{CREW_PREFIX}/share/fop/fop/fop", "#{CREW_DEST_PREFIX}/bin/fop"

    File.write "#{CREW_DEST_PREFIX}/etc/env.d/fop", <<~FOPEOF
      # Fop configuration
      export JAVA_HOME=#{CREW_PREFIX}/jre
    FOPEOF
  end
end
