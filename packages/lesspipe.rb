require 'package'

class Lesspipe < Package
  description 'Input filter for the pager less'
  homepage 'https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html'
  version '2.28'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/wofr06/lesspipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4533f263369223d7b8adf20d846e807e153e2c74950c36cbd2941b1cd7df1eb2',
     armv7l: '4533f263369223d7b8adf20d846e807e153e2c74950c36cbd2941b1cd7df1eb2',
       i686: '8eb437107e99a0772f71386420986671a69c620e20f1729d7d4d6ce78e97749b',
     x86_64: 'd86625f86d2f98c6ffb257a194b39100f1e8d518bdf2d9f0a8af776243635fc0'
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
