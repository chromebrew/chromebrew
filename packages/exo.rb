require 'package'

class Exo < Package
  description 'Extension library for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/exo/#{version.rpartition('.')[0]}/exo-#{version}.tar.bz2"
  source_sha256 '4e89f5536afbf1cb9191cceb720fb2764df1a4fae3459512b7320841ab5a9e9d'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'dc9b3c212c72d35e40fc7710d3bba50bc60ed606f0413cc98bb6bc9f5131a6e0',
     armv7l: 'dc9b3c212c72d35e40fc7710d3bba50bc60ed606f0413cc98bb6bc9f5131a6e0',
       i686: '21d0447321f661d4427ba9a2ae193778d590bca295e1067367db38ad503acbae',
     x86_64: '0badd872b7670ba922e11a798d7f49e92eedfd53c618517211ebcd5fb2f35d97'
  })

  depends_on 'libxfce4ui'
  depends_on 'xfce4_dev_tools'
  depends_on 'valgrind' => :build

  def self.patch
    FileUtils.mkdir_p 'm4'
    system 'NOCONFIGURE=1 xdt-autogen'
    system 'filefix'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
