require 'package'

class Elinks < Package
  description 'Full-Featured Text WWW Browser'
  homepage 'http://elinks.or.cz/'
  version '0.13'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://elinks.or.cz/download/elinks-current-0.13.tar.bz2'
  source_sha256 '03bd8cb436830e89407acbc8d4a736356f3780dc863a2e9df593d6c870d0bb55'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elinks/0.13_armv7l/elinks-0.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elinks/0.13_armv7l/elinks-0.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elinks/0.13_i686/elinks-0.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elinks/0.13_x86_64/elinks-0.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7478d48810157ace3bf8672f68398ff9ba4fff19f93fde529ebe655ff9c4e2f0',
     armv7l: '7478d48810157ace3bf8672f68398ff9ba4fff19f93fde529ebe655ff9c4e2f0',
       i686: '7852bd73a485390c86c0416b28dbfc701dd931f22b0c76fbb478133512b8bd4c',
     x86_64: '21b68488bdc3dda9286760e087288234ceee0ba147cba8ad8b3b0f67f3205309'
  })

  depends_on 'lzip'
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R
  depends_on 'bzip2' # R
  depends_on 'expat' # R

  def self.build
    system "./configure --without-x #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/share/locale/locale.alias"
  end
end
