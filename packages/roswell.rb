require 'buildsystems/autotools'

class Roswell < Autotools
  description 'A lisp installer and launcher for major environment.'
  homepage 'https://github.com/roswell/roswell'
  version '26.10.117'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/roswell/roswell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3bc1619d6e0470352b7e5eaa8df8ea32b3845fae9b1c9e66575c874ed09b83cb',
     armv7l: '3bc1619d6e0470352b7e5eaa8df8ea32b3845fae9b1c9e66575c874ed09b83cb',
       i686: 'ef8b81408923ed3018b28f56d21feb00cbaf5ce16b7e99b938277078ff91aae9',
     x86_64: 'a713adab63c839ab210f9be98ebbc4cbe62607ae6481b09b44bb899984089808'
  })

  depends_on 'brotli' => :build
  depends_on 'curl' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libcyrussasl' => :build
  depends_on 'libnghttp2' => :build
  depends_on 'openldap' => :build
  depends_on 'rtmpdump' => :build
  depends_on 'xdg_base' => :logical

  no_fhs

  autotools_install_extras do
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.roswell"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.roswell", "#{CREW_DEST_HOME}/.roswell"
  end

  def self.postinstall
    ExitMessage.add "\nType 'ros' to get started.\n"
  end
end
