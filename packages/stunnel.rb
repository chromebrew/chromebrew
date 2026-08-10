require 'buildsystems/autotools'

class Stunnel < Autotools
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.80'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/mtrojnar/stunnel.git'
  git_hashtag "stunnel-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '877e2fe163c0215bc262eb8cd80f6f27db5952c7388cb8ed9abee762ce568dcf',
     armv7l: '877e2fe163c0215bc262eb8cd80f6f27db5952c7388cb8ed9abee762ce568dcf',
       i686: '7a00118302234de0a24f1706b9d342c76031ca3f8304719985b4210fafe03568',
     x86_64: '4ada48f543baef427c34560031391b83ecad9d0048d28593c68cf2e8d4502072'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :executable
  depends_on 'pandoc' => :build
  depends_on 'tcpwrappers' => :library

  autotools_skip_autoreconf

  def self.patch
    # The aclocal & automake versions are hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp
    automake_version = `automake --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    system "sed -i \"s,am__api_version='1.17',am__api_version='#{automake_version}',g\" aclocal.m4"
    system "sed -i 's/m4_if([$1], [1.17]/m4_if([$1], [#{automake_version}]/g' aclocal.m4"
    system "sed -i 's,1.17,#{aclocal_version},g' aclocal.m4"
    system "sed -i 's,1.17,#{aclocal_version},g' configure"
    system 'automake'
  end

  def self.postbuild
    # Fix bash: /usr/local/bin/stunnel3: /usr/bin/perl: bad interpreter: No such file or directory
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' #{CREW_DEST_PREFIX}/bin/stunnel3"
  end
end
