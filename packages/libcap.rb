require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap'
  version '2.25'
  source_url 'https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.25.tar.xz'
  source_sha1 'f0b102e4a68e1bbdcb6b143b63c34a250e473088'

  def self.build
    # change the path to ld
    system 'sed -i "s,/usr/bin/ld,/usr/local/bin/ld,g" Make.Rules'
    # change prefix
    system 'sed -i "s,prefix=/usr,prefix=/usr/local," Make.Rules'
    # set exec_prefix
    system 'sed -i "s,^exec_prefix=,exec_prefix=\$(prefix)," Make.Rules'
    # http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-support/libcap/files/0001-ensure-the-XATTR_NAME_CAPS-is-defined-when-it-is-use.patch
    system 'sed -i "s,^\#ifdef VFS_CAP_U32,\#if defined (VFS_CAP_U32) \&\& defined (XATTR_NAME_CAPS),g" libcap/cap_file.c'
    # only root user can setcap
    system 'sed -i "s,\$(FAKEROOT)\$(SBINDIR)/setcap,sudo \$(FAKEROOT)\$(SBINDIR)/setcap," progs/Makefile'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
