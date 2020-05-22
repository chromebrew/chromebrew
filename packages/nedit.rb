require 'package'

class Nedit < Package
  description 'Nedit 5.7'
  homepage 'https://sourceforge.net/projects/nedit/'
  version '5.7'
  source_url 'https://downloads.sourceforge.net/project/nedit/nedit-source/nedit-5.7-src.tar.gz'
  source_sha256 'add9ac79ff973528ad36c86858238bac4f59896c27dbf285cbe6a4d425fca17a' 

  # binary_url ({
  #    aarch64: 'file:///home/chronos/user/Downloads/nedit/nedit-5.7-chromeos-aarch64.tar.xz'
  # })
  # binary_sha256 ({
  #    aarch64: '8c60d9a44afafc6e3be4fb4084ec42c3f36910a466bcc59cfe4a5f199c1aef7b'
  # })

  #depends_on 'automake' => :build
  #depends_on 'autoconf' => :build
  depends_on 'libxfont2'
  depends_on 'sed'
  depends_on 'motif'

  def self.build
    #system "autoconf"
    #system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "sed -i 's/$@/linux/g' Makefile"
    system "make linux"
  end

  def self.install
    #system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "cp ./source/nedit /usr/local/bin"
  end

  def self.check
    system "make", "check"
  end

end

