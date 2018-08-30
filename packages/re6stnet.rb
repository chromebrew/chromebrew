require 'package'
class Re6stnet < Package
  description 'Resilient, Scalable, IPv6 Network'
  homepage 'https://re6st.nexedi.com/'
  version '0.501'
  source_url 'https://lab.nexedi.com/nexedi/chromebrew-buildout-re6st/repository/archive.tar.bz2?ref=64b11f4eb4fe1f1f07861f8060546414dfcf949f'
  source_sha256 '5e1815347175d982a0184f22a0d913f8efc992b2ed74b73c92a543299d9f89e3'

  binary_url ({
    x86_64: 'https://softinst62285.host.vifib.net/public/re6stnet-0.501-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '39e86454e8e11ba9672145a2fa5ab4754c1c739a9062f2019e6a2f066787e064',
  })

  depends_on 'python27' => :build
  depends_on 'filecmd' => :build
  depends_on 'libiconv' => :build

  @re6st_dir = 	"#{CREW_PREFIX}/opt/re6st"

  def self.build
    system "mkdir -p #{@re6st_dir}/bin && cp buildout.cfg #{@re6st_dir} && cp bin/grandenet #{@re6st_dir}/bin"
    system "SSL_CERT_DIR=/etc/ssl/certs ./bin/buildout buildout:directory=#{@re6st_dir}"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/opt/ "
    system "cp -r #{@re6st_dir} #{CREW_DEST_DIR}#{@re6st_dir}"
    system "rm -rf #{CREW_DEST_DIR}#{@re6st_dir}/download-cache"
    system "ln -fs #{@re6st_dir}/bin/grandenet #{CREW_PREFIX}/sbin/grandenet"
    system "ln -fs #{@re6st_dir}/bin/re6stnet #{CREW_PREFIX}/sbin/re6stnet"
    system "ln -fs #{@re6st_dir}/bin/re6st-conf #{CREW_PREFIX}/bin/re6st-conf"
    system "ln -fs #{@re6st_dir}/bin/re6st-registry #{CREW_PREFIX}/bin/re6st-registry"
  end

  def self.postinstall
    puts "To initiate re6stnet, run #{CREW_PREFIX}/sbin/grandenet"
  end
end
