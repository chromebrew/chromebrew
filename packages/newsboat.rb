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
    aarch64: '9c4d9c323fe5e4bd22608edfd220a1ac1ce421fd79e0d9ede3b87b895ae1c294',
     armv7l: '9c4d9c323fe5e4bd22608edfd220a1ac1ce421fd79e0d9ede3b87b895ae1c294',
       i686: '1437b3103969bb432fe1b23263a83c2b0c8cdbefb532d81925864991f8aa6aa7',
     x86_64: 'b74cf00b8080016eb459892dc6107d75d678a98ad413fefceb3a160f67b1c3d4'
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

  def self.check
    system 'make', 'check'
  end

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
