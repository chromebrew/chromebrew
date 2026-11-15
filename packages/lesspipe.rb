require 'package'

class Lesspipe < Package
  description 'Input filter for the pager less'
  homepage 'https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html'
  version '2.30'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/wofr06/lesspipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c92adfe052184be401613bf5825f99e8f86bd40974a8be549cf2a4b8dee1ed2b',
     armv7l: 'c92adfe052184be401613bf5825f99e8f86bd40974a8be549cf2a4b8dee1ed2b',
       i686: 'cb7a7d11b19d8249f86d3cc6ce5ee9b309aaab2080afc083b3f1a56d9d6a3ff4',
     x86_64: 'd2c55b8998ea0319b50f815c47bfed6008266cb490cda89bf590569ac48bcba8'
  })

  depends_on 'less'

  print_source_bashrc

  def self.build
    File.write '10-lesspipe', <<~EOF
      LESSOPEN="|#{CREW_PREFIX}/bin/lesspipe.sh %s"
    EOF
  end

  def self.install
    FileUtils.install %w[archive_color lesscomplete lesspipe.sh vimcolor],
                      "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install '10-lesspipe', "#{CREW_DEST_PREFIX}/etc/env.d/10-lesspipe", mode: 0o644
    FileUtils.install 'bash_completion', "#{CREW_DEST_PREFIX}/etc/bash.d/less_completion", mode: 0o644
  end
end
