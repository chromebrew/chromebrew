require 'package'

class Newsboat < Package
  description 'Newsboat is an RSS/Atom feed reader for the text console.'
  homepage 'https://newsboat.org/'
  version '2.25'
  license 'MIT'
  compatibility 'all'
  source_url 'https://newsboat.org/releases/2.25/newsboat-2.25.tar.xz'
  source_sha256 '41aaab378f1dc9eff5094fc4a686a602c76497cb6c4b656c65e843a71fa6017e'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/newsboat/2.25_armv7l/newsboat-2.25-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/newsboat/2.25_armv7l/newsboat-2.25-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/newsboat/2.25_i686/newsboat-2.25-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/newsboat/2.25_x86_64/newsboat-2.25-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9c4d9c323fe5e4bd22608edfd220a1ac1ce421fd79e0d9ede3b87b895ae1c294',
     armv7l: '9c4d9c323fe5e4bd22608edfd220a1ac1ce421fd79e0d9ede3b87b895ae1c294',
       i686: '1437b3103969bb432fe1b23263a83c2b0c8cdbefb532d81925864991f8aa6aa7',
     x86_64: 'b74cf00b8080016eb459892dc6107d75d678a98ad413fefceb3a160f67b1c3d4'
  })

  depends_on 'sqlite'
  depends_on 'gettext'
  depends_on 'curl'
  depends_on 'libxml2'
  depends_on 'libstfl'
  depends_on 'jsonc'
  depends_on 'openssl'
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'rust' => :build

  def self.patch
    system "sed -i 's:prefix?=/usr/local:prefix?=#{CREW_PREFIX}:' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.remove
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
