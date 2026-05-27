require 'package'

class Get_iplayer < Package
  description 'A utility for downloading TV and radio programmes from BBC iPlayer'
  homepage 'https://github.com/get-iplayer/get_iplayer'
  version "3.36-#{CREW_PERL_VER}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/get-iplayer/get_iplayer.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85141bd76ec610d7924f6dbf4bf784a3ccf8bf2bf338771f5c3e8e11c0b97b01',
     armv7l: '85141bd76ec610d7924f6dbf4bf784a3ccf8bf2bf338771f5c3e8e11c0b97b01',
     x86_64: 'e1ffcf0476747896dda2b7bbe8f33be0fb3fffeee2062e16fe7b61ac41e83122'
  })

  depends_on 'perl' => :logical
  depends_on 'perl_app_cpanminus' => :build
  depends_on 'perl_io_socket_ssl' => :executable
  depends_on 'perl_lwp_protocol_https' => :executable
  depends_on 'ffmpeg' => :executable
  depends_on 'atomicparsley' => :library
  depends_on 'libxml2' => :library
  depends_on 'zlib' => :library

  def self.install
    FileUtils.install 'get_iplayer', "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
  end

  def self.postinstall
    @cpan_deps = ['LWP', 'XML::LibXML', 'Mojolicious', 'CGI']
    @cpan_deps.each do |dep|
      system "cpanm #{dep} --force"
    end
  end

  def self.postremove
    @cpan_deps = ['LWP', 'XML::LibXML', 'Mojolicious', 'CGI']
    @cpan_deps.each do |dep|
      system "cpanm --uninstall #{dep}"
    end
  end
end
