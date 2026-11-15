require 'buildsystems/autotools'

class Newsboat < Autotools
  description 'Newsboat is an RSS/Atom feed reader for the text console.'
  homepage 'https://newsboat.org/'
  version '2.45.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/newsboat/newsboat.git'
  git_hashtag "r#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd589e4387c0d49874fb04a81cb8b703ad9569eddc6a2c58f84308343d475cb75',
     armv7l: 'd589e4387c0d49874fb04a81cb8b703ad9569eddc6a2c58f84308343d475cb75',
     x86_64: '21ad57ee8d0a155e8a9c455ae00d198dd636551f4b0a609f197be8dc8262a015'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gettext' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'json_c' => :executable
  depends_on 'libstfl' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :executable
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'rust' => :build
  depends_on 'sqlite' => :executable

  def self.patch
    system "sed -i 's:prefix?=/usr/local:prefix?=#{CREW_PREFIX}:' Makefile"
  end

  autotools_skip_configure
  autotools_pre_make_options "CXXFLAGS+=' -Wno-unused-function '"

  def self.postremove
    Package.agree_to_remove("#{HOME}/.newsboat")
  end
end
