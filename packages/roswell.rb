require 'buildsystems/autotools'

class Roswell < Autotools
  description 'A lisp installer and launcher for major environment.'
  homepage 'https://github.com/roswell/roswell'
  version '26.10.119'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/roswell/roswell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '110d16d744890274c60564486ae0437d7b280bb7c45cf92d032486a09a21c122',
     armv7l: '110d16d744890274c60564486ae0437d7b280bb7c45cf92d032486a09a21c122',
       i686: 'd8f2edc83bc8b57bd2a2994f2b586a91008aeb254dd8b714a32fe06cce661f6f',
     x86_64: 'cb6d6d5e00ad6181736d24cfeb3017dcadbc6ca39e1fcc2e1bf429370ff67603'
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
