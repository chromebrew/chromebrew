require 'buildsystems/autotools'

class Roswell < Autotools
  description 'A lisp installer and launcher for major environment.'
  homepage 'https://github.com/roswell/roswell'
  version '26.10.118'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/roswell/roswell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a33224cdf3938744758cfa2b9358bd72b34fba2c3b05b249c7133cd41aecfe9a',
     armv7l: 'a33224cdf3938744758cfa2b9358bd72b34fba2c3b05b249c7133cd41aecfe9a',
       i686: 'b8dab1dfa60eb753a925c86bfd5a16e7bbe4e281e86f321772ab580e784c41a8',
     x86_64: '502ced452e46d79ffe6f30846aa1d6b37ee478ac74be1d42f93d041403a427f6'
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
