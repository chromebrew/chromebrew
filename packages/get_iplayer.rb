require 'package'

class Get_iplayer < Package
  description 'A utility for downloading TV and radio programmes from BBC iPlayer'
  homepage 'https://github.com/get-iplayer/get_iplayer'
  version '3.31-perl5.34'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/get-iplayer/get_iplayer/archive/v3.31.tar.gz'
  source_sha256 '21bc00887365034f76e56b829eeba8b6d510f83424ebf1840ff9ca76713f58d5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0fc9ba7a18b419cba3f94655b4004a9526f56907e486e7201e259230a1acca63',
     armv7l: '0fc9ba7a18b419cba3f94655b4004a9526f56907e486e7201e259230a1acca63',
     x86_64: 'fcafafde21e3763f926e2b2babe13fdea1465d422660fa992258b23c61b1c48c'
  })

  depends_on 'perl'
  depends_on 'perl_app_cpanminus' => :build
  depends_on 'perl_lwp_protocol_https' # R
  depends_on 'ffmpeg'
  depends_on 'atomicparsley'
  depends_on 'libxml2'
  depends_on 'zlibpkg'

  def self.build; end

  def self.install
    FileUtils.install 'get_iplayer', "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
  end

  def self.postinstall
    @cpan_deps = ['LWP', 'XML::LibXML', 'Mojolicious', 'CGI']
    @cpan_deps.each do |dep|
      system "cpanm #{dep} --force"
    end
  end

  def self.remove
    @cpan_deps = ['LWP', 'XML::LibXML', 'Mojolicious', 'CGI']
    @cpan_deps.each do |dep|
      system "cpanm --uninstall #{dep}"
    end
  end
end
