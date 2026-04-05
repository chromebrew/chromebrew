require 'package'

class Newsboat < Package
  description 'Newsboat is an RSS/Atom feed reader for the text console.'
  homepage 'https://newsboat.org/'
  version '2.43'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/newsboat/newsboat.git'
  git_hashtag "r#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '48e85a6f7d5b6206905113f81207b0ff9cd5395b4acacde0793a5d39421a6ec1',
     armv7l: '48e85a6f7d5b6206905113f81207b0ff9cd5395b4acacde0793a5d39421a6ec1',
       i686: 'f0d3115574ecd796cb6c8b07aa22fb3195ae49f8f322de7fe6e827238578756d',
     x86_64: '820160251ce1ba903ccdd6d8eeb50d37c78a4e948457e68dcaa42cef0c394f70'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gettext' => :build
  depends_on 'glibc' => :executable
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

  def self.build
    system "CXXFLAGS+=' -Wno-unused-function ' make"
  end

  # def self.check
  # Fails due to not having availsble TERM in the actions
  # container.
  #   system 'make', 'check'
  # end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postremove
    config_dir = "#{HOME}/.newsboat"
    if Dir.exist? config_dir
      print "Would you like to remove the config directory #{config_dir}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
