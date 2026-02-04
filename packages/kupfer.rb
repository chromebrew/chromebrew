require 'package'

class Kupfer < Package
  description 'a smart, quick launcher'
  homepage 'https://kupferlauncher.github.io/'
  version '329'
  license 'GPL-3.0'
  compatibility 'x86_64'
  source_url 'https://github.com/kupferlauncher/kupfer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  depends_on 'desktop_file_utils'
  depends_on 'shared_mime_info'
  depends_on 'py3_dbus_python'
  depends_on 'py3_pygobject' => :build
  depends_on 'py3_pyxdg'
  depends_on 'py3_docutils' => :build
  depends_on 'python3' => :build
  depends_on 'pygobject2' => :build
  depends_on 'pygtk' => :build
  depends_on 'sommelier' => :logical

  binary_sha256({
     x86_64: 'd8ee8a6df3086275c4900c020ce29ab667dc6bf55d7cc461a3ca354fce173493'
  })

  def self.build
    system "./waf configure --prefix=#{CREW_PREFIX}"
    system "./waf -j#{CREW_NPROC}"
  end

  def self.install
    system './waf', "--destdir=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system "update-desktop-database #{CREW_PREFIX}/share/applications"
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end
end
