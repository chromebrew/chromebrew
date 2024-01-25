require 'package'

class Ndctl < Package
  description 'Helper tools and libraries for managing the libnvdimm (non-volatile memory device) sub-system in the Linux kernel'
  homepage 'https://github.com/pmem/ndctl'
  version '72.1'
  license 'GPL-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/pmem/ndctl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'baade842dde6df21f38c6506d89d11b6c569d131c4c4a0bedf66992a952dfc1f',
     armv7l: 'baade842dde6df21f38c6506d89d11b6c569d131c4c4a0bedf66992a952dfc1f',
     x86_64: '6d1a0625c7c26687531cf8d63859bbe4bcdd44c5f1b623657491845c89a2a8bc'
  })

  depends_on 'ruby_asciidoctor' => :build
  depends_on 'bash_completion' => :build
  depends_on 'iniparser' => :build
  depends_on 'jsonc' => :build
  depends_on 'keyutils' => :build
  depends_on 'libkmod' => :build
  depends_on 'xmlto' => :build

  def self.build
    system './autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} --without-systemd"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
