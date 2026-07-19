require 'buildsystems/autotools'

class Newsboat < Autotools
  description 'Newsboat is an RSS/Atom feed reader for the text console.'
  homepage 'https://newsboat.org/'
  version '2.44'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/newsboat/newsboat.git'
  git_hashtag "r#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6695a1c3398f2fd40891b9eb580b8741c23fa578bc6d223b2b1376affd0b1657',
     armv7l: '6695a1c3398f2fd40891b9eb580b8741c23fa578bc6d223b2b1376affd0b1657',
     x86_64: '8d1d0f327773241c34e865be5faa2f8430dc414a4ecb71ecfd46c47f995beb0e'
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
