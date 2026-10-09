require 'buildsystems/autotools'

class Roswell < Autotools
  description 'A lisp installer and launcher for major environment.'
  homepage 'https://github.com/roswell/roswell'
  version '26.02.116'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/roswell/roswell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a2ad1ae4a6ccd5d9fb54bd407f1a42dc6a424876fb7988ce4c0bde492d9ee5d',
     armv7l: '0a2ad1ae4a6ccd5d9fb54bd407f1a42dc6a424876fb7988ce4c0bde492d9ee5d',
       i686: '1f99fe1ba741bdb7ed566ac82bb94ca850477320f9652f1c9dfd91fc1b1eb81d',
     x86_64: 'cd65542cccd5533eb11a176b4ee4e059ed4e4393dd20db82f91243d65b00208a'
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
