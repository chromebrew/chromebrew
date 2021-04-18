require 'package'

class Exo < Package
  description 'Extension library for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  @_ver = '4.16.2'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/exo/#{@_ver.rpartition('.')[0]}/exo-#{@_ver}.tar.bz2"
  source_sha256 '4e89f5536afbf1cb9191cceb720fb2764df1a4fae3459512b7320841ab5a9e9d'

  depends_on 'libxfce4ui'
  depends_on 'xfce4_dev_tools'

  def self.patch
    FileUtils.mkdir_p 'm4'
    system 'NOCONFIGURE=1 xdt-autogen'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
