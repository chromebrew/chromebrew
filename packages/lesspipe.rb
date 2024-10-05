require 'package'

class Lesspipe < Package
  description 'Input filter for the pager less'
  homepage 'https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html'
  version '2.15'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/wofr06/lesspipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38f9471a37a413df9fdf1b391501c63d3c6bf63f7553f8f68ac794ce59d4bcc4',
     armv7l: '38f9471a37a413df9fdf1b391501c63d3c6bf63f7553f8f68ac794ce59d4bcc4',
       i686: 'f50031b15e3220321fc2acc66cc716dece18be7e2aa24477b558731da1dfcd42',
     x86_64: '189186709ed2e441164565f2883b208206936619954dfdf1c255ed4b0f4fa488'
  })

  depends_on 'less'

  print_source_bashrc

  def self.build
    File.write '10-lesspipe', <<~EOF
      LESSOPEN="|#{CREW_PREFIX}/bin/lesspipe.sh %s"
    EOF
  end

  def self.install
    FileUtils.install %w[lesspipe.sh code2color archive_color vimcolor sxw2txt lesscomplete],
                      "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install '10-lesspipe', "#{CREW_DEST_PREFIX}/etc/env.d/10-lesspipe", mode: 0o644
    FileUtils.install 'less_completion', "#{CREW_DEST_PREFIX}/etc/bash.d/less_completion", mode: 0o644
  end
end
