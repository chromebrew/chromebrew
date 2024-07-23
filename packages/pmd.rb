require 'package'

class Pmd < Package
  description 'An extensible cross-language static code analyzer.'
  homepage 'https://pmd.github.io/'
  version '7.2.0'
  license 'custom'
  compatibility 'all'
  source_url "https://github.com/pmd/pmd/releases/download/pmd_releases%2F#{version}/pmd-dist-#{version}-bin.zip"
  source_sha256 '2dfee533351069816870c3fc1ea3b3089f0fea602748b0d8ab9db1f0c381ded2'

  depends_on 'openjdk8'
  depends_on 'unzip'

  no_compile_needed

  def self.build
    File.write 'cpd', <<~EOF
      #!/bin/bash
      pmd cpd "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/pmd"
    FileUtils.install 'cpd', "#{CREW_DEST_PREFIX}/bin/cpd", mode: 0o755
    FileUtils.rm 'cpd'
    FileUtils.rm Dir['bin/*.bat']
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/pmd"
    FileUtils.ln_s "#{CREW_PREFIX}/share/pmd/bin/pmd", "#{CREW_DEST_PREFIX}/bin/pmd"
  end

  def self.postinstall
    ExitMessage.add "\nType 'pmd -h' to get started.\n".lightblue
  end
end
