require 'package'

class Charm < Package
  description 'Charm is a set of tools that makes adding a backend to your terminal-based applications fun and easy.'
  homepage 'https://charm.sh'
  version '0.12.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/charmbracelet/charm/releases/download/v0.12.1/charm_0.12.1_linux_armv7.tar.gz',
     armv7l: 'https://github.com/charmbracelet/charm/releases/download/v0.12.1/charm_0.12.1_linux_armv7.tar.gz',
       i686: 'https://github.com/charmbracelet/charm/releases/download/v0.12.1/charm_0.12.1_linux_i386.tar.gz',
     x86_64: 'https://github.com/charmbracelet/charm/releases/download/v0.12.1/charm_0.12.1_linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: '2432a4ff4e529168515a31b74f0546a9f50a22d3733c82012783f4297754c3b4',
     armv7l: '2432a4ff4e529168515a31b74f0546a9f50a22d3733c82012783f4297754c3b4',
       i686: 'c7676318d8f616dfe7955b5729354d3e225d67c3ff60b06de1ab99cfb80ef098',
     x86_64: '040e44b510ff7326631f18f02f8feaf4010bd512a97e369af855cda0cb100938'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'charm', "#{CREW_DEST_PREFIX}/bin/charm", mode: 0o755
  end
end
