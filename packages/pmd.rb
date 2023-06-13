require 'package'

class Pmd < Package
  description 'An extensible cross-language static code analyzer.'
  homepage 'https://pmd.github.io/'
  version '6.52.0'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.52.0/pmd-bin-6.52.0.zip'
  source_sha256 'fa757430ee45bb79ce3d10bb5706b71aa7bd2f0df40c135b1ae2ffd2ae91810e'

  depends_on 'openjdk8'
  depends_on 'unzip'

  no_compile_needed

  def self.build
    cpd = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/pmd
      exec bin/run.sh cpd "$@"
    EOF
    File.write('cpd', cpd)
    pmd = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/pmd
      exec bin/run.sh pmd "$@"
    EOF
    File.write('pmd', pmd)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/pmd"
    FileUtils.rm 'bin/*.bat'
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/pmd"
    FileUtils.install %w[cpd pmd], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'pmd -h' to get started.\n".lightblue
  end
end
